/**
 * ********************************************************************************
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * *******************************************************************************
 */
component {

	// Module Properties
	this.title             = "AntiSamy";
	this.author            = "Ortus Solutions, Corp";
	this.webURL            = "https://www.ortussolutions.com";
	this.description       = "Leverages the AntiSamy libraries for XSS cleanups";
	this.version           = "@build.version@+@build.number@";
	// CF Mapping
	this.cfmapping         = "cbantisamy";
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies      = [ "cbjavaloader" ];
	// Helpers
	this.applicationHelper = [ "helpers/mixins.cfm" ];

	function configure(){
		// Default settings
		settings = {
			// The library path
			libPath       : modulePath & "/models/lib",
			// Activate auto request capture cleanups
			autoClean     : true,
			// Default Policy to use, available are: antisamy, ebay, myspace, slashdot and tinymce
			defaultPolicy : "ebay",
			// Custom Policy absolute path, leave empty if not used
			customPolicy  : ""
		};

		// Custom Declared Interceptors
		interceptors = [
			{
				class : "#this.cfmapping#.interceptors.AutoClean",
				name  : "AutoClean@CBAntiSamy"
			}
		];
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad(){
		// Class load antisamy
		controller
			.getWireBox()
			.getInstance( "loader@cbjavaloader" )
			.appendPaths( settings.libPath );
	}

}
