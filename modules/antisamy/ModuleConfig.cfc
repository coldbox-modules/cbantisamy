/**
*********************************************************************************
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
*/
component {

	// Module Properties
	this.title 				= "antisamy";
	this.author 			= "Ortus Solutions, Corp";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "Leverages the AntiSamy libraries for XSS cleanups";
	this.version			= "1.0.0.@build.number@";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "antisamy";
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies		= [ "javaloader" ];

	function configure(){

		// module settings - stored in modules.name.settings
		settings = {
			// The library path
			libPath = getDirectoryFromPath( getCurrentTemplatePath() ) & "models/lib",
			// Activate auto request capture cleanups
			autoClean = false,
			// Default Policy to use, available are: antisamy, ebay, myspace, slashdot and tinymce
			defaultPolicy = "ebay",
			// Custom Policy absolute path, leave empty if not used
			customPolicy = ""
		};

		// Custom Declared Interceptors
		interceptors = [
		];

		// Load auto clean interceptor if activated
		if( settings.autoClean ){
			arrayAppend( interceptors, { class="#moduleMapping#.interceptors.AutoClean", name="AutoClean@AntiSamy" } );
		}

		// Binder Mappings
		binder.map( "AntiSamy@AntiSamy" )
			.to( "#moduleMapping#.models.AntiSamy" );

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// Class Load via dependency the lib folder
		controller.getWireBox().getInstance( "loader@javaloader" ).appendPaths( settings.libPath );
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}