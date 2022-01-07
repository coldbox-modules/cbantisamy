<cfscript>
	/**
	 * Clean HTML from XSS scripts using the AntiSamy project. The available policies are basic, antisamy, ebay, myspace, slashdot, custom
	 *
	 * @htmlData   The html data to clean
	 * @policyFile The policy file to use. Defaults to the one in the configuration file
	 *
	 * @return sanitized html data
	 */
	string function antisamyClean( required htmlData, string policyFile ){
		return getInstance( "AntiSamy@CBAntiSamy" ).HTMLSanitizer( argumentCollection = arguments );
	}

	/**
	 * Checks whether HTML is safe from XSS scripts using the AntiSamy project. The available policies are basic, antisamy, ebay, myspace, slashdot, custom
	 *
	 * @htmlData   The html data to clean
	 * @policyFile The policy file to use. Defaults to the one in the configuration file
	 *
	 * @return True if it is safe, false if not
	 */
	boolean function antisamyCheck( required htmlData, string policyFile ){
		arguments.check = true;
		return getInstance( "AntiSamy@CBAntiSamy" ).HTMLSanitizer( argumentCollection = arguments );
	}
</cfscript>
