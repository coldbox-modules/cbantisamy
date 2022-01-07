/**
 * Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 * OWASP AntiSamy Project that provides XSS cleanup operations to ColdBox applications
 * http://www.owasp.org/index.php/Category:OWASP_AntiSamy_Project
 * http://code.google.com/p/owaspantisamy/downloads/list
 */
component singleton threadsafe {

	// DI
	property name="moduleSettings" inject="coldbox:moduleSettings:cbantisamy";
	property name="javaLoader"     inject="loader@cbjavaloader";
	property name="util"           inject="coldbox.system.core.util.Util";

	/**
	 * Engine We are runnning
	 */
	property name="engine" default="ADOBE";

	/**
	 * Antisamy policy to use
	 */
	property name="defaultPolicy" default="ebay";

	function onDIComplete(){
		// Engine selector
		variables.engine = server.keyExists( "lucee" ) ? "LUCEE" : "ADOBE";

		// Static Lookup
		variables.POLICIES = {
			// Basic Adobe/Lucee policyfile
			"basic"    : variables.moduleSettings.libPath & "/antisamy-basic.xml",
			// Load eBay policyfile
			"ebay"     : variables.moduleSettings.libPath & "/antisamy-ebay.xml",
			// Load myspace policyfile
			"myspace"  : variables.moduleSettings.libPath & "/antisamy-myspace.xml",
			// Load slashdot policyfile
			"slashdot" : variables.moduleSettings.libPath & "/antisamy-slashdot.xml",
			// Load tinymce policyfile
			"tinymce"  : variables.moduleSettings.libPath & "/antisamy-tinymce.xml",
			// AntiSamy policyfile
			"antisamy" : variables.moduleSettings.libPath & "/antisamy-anythinggoes.xml",
			// Custom Policy
			"custom"   : variables.moduleSettings.customPolicy
		};

		// set and verify policy according to settings
		if ( variables.moduleSettings.keyExists( "defaultPolicy" ) && len( variables.moduleSettings.defaultPolicy ) ) {
			if ( variables.POLICIES.keyExists( variables.moduleSettings.defaultPolicy ) ) {
				variables.defaultPolicy = variables.moduleSettings.defaultPolicy;
			} else {
				throw(
					type    = "cbantisamy.InvalidPolicyFile",
					message = "The policy specified, #variables.moduleSettings.defaultPolicy#, is not valid.. Valid policies are #variables.POLICIES.keyArray().toList()#"
				);
			}
		}
	}

	/**
	 * Clean HTML from XSS scripts using the AntiSamy project. The available policies are basic, antisamy, ebay, myspace, slashdot, custom
	 *
	 * @htmlData   The html data to clean
	 * @policyFile The policy file to use. Defaults to the one in the configuration file
	 *
	 * @return sanitized html data
	 */
	string function clean( required htmlData, string policyFile = variables.defaultPolicy ){
		return HTMLSanitizer( argumentCollection = arguments );
	}

	/**
	 * Checks whether HTML is safe from XSS scripts using the AntiSamy project. The available policies are basic, antisamy, ebay, myspace, slashdot, custom
	 *
	 * @htmlData   The html data to clean
	 * @policyFile The policy file to use. Defaults to the one in the configuration file
	 *
	 * @return True if it is safe, false if not
	 */
	boolean function check( required htmlData, string policyFile = variables.defaultPolicy ){
		arguments.check = true;
		return HTMLSanitizer( argumentCollection = arguments );
	}

	/**
	 * Clean HTML from XSS scripts using the AntiSamy project. The available policies are basic, antisamy, ebay, myspace, slashdot, custom
	 *
	 * @htmlData   The html data to clean
	 * @policyFile The policy file to use, by default it uses the basic policy file
	 * @check      By default it just returns the cleaned HTML, but if this is true, it will return the a boolean as to whether the HTML is safe.
	 *
	 * @return HTMl data or boolean from check
	 *
	 * @throws cbantisamy.InvalidPolicyFile      - When the passed policy is invalid
	 * @throws cbantisamy.InvalidPolicyException - When the default policy is invalid
	 */
	any function htmlSanitizer(
		required htmlData,
		string policyFile = variables.defaultPolicy,
		boolean check     = false
	){
		if ( len( arguments.policyfile ) && !variables.POLICIES.keyExists( arguments.policyfile ) ) {
			throw(
				type    = "cbantisamy.InvalidPolicyFile",
				message = "The policy specified, #arguments.policyFile#, does not exist. Valid policies are #variables.POLICIES.keyArray().toList()#"
			);
		}

		// Adobe implementation
		if ( variables.engine == "ADOBE" ) {
			if ( arguments.check ) {
				return isSafeHTML(
					arguments.htmlData,
					len( arguments.policyFile ) ? variables.POLICIES[ arguments.policyFile ] : javacast(
						"null",
						0
					)
				);
			} else {
				return getSafeHTML(
					arguments.htmlData,
					len( arguments.policyFile ) ? variables.POLICIES[ arguments.policyFile ] : javacast(
						"null",
						0
					)
				);
			}
		}

		// Lucee Implementation
		var _thread            = createObject( "java", "java.lang.Thread" );
		var currentClassloader = _thread.currentThread().getContextClassLoader();

		try {
			// Overide due to class cast exceptions
			_thread.currentThread().setContextClassLoader( javaloader.getURLClassLoader() );

			// you can use any xml, our your own customised policy xml
			var antiSamy = javaLoader.create( "org.owasp.validator.html.AntiSamy" );

			// Clean with policy
			var cleanResult = antiSamy.scan( arguments.htmlData, variables.POLICIES[ arguments.policyFile ] );

			// returning results object or just checking?
			if ( arguments.check ) {
				return !cleanResult.getNumberOfErrors();
			}

			return cleanResult.getCleanHTML();
		} catch ( any e ) {
			rethrow;
		} finally {
			/*
				We have to reset the classloader, due to
				thread pooling.
			*/
			_thread.currentThread().setContextClassLoader( currentClassloader );
		}
	}

}
