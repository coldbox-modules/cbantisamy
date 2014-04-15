component {

	// Module Properties
	this.title 				= "JavaLoader";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "A JavaLoader Module for ColdBox";
	this.version			= "1.0.0.@build.version@";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "JavaLoader";

	function configure(){

		// Java Loader Settings
		settings = {
			// The array paths to load
			loadPaths = getJars( getDirectoryFromPath( getCurrentTemplatePath() ) & "lib" ),
			// Load ColdFusion classes with loader
			loadColdFusionClassPath = false,
			// Attach a custom class loader as a parent
			parentClassLoader = "",
			// Directories that contain Java source code that are to be dynamically compiled
			sourceDirectories = [],
			// the directory to build the .jar file for dynamic compilation in, defaults to ./tmp
			compileDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) & "model/javaloader/tmp",
			// Whether or not the source is trusted, i.e. it is going to change? Defaults to false, so changes will be recompiled and loaded
			trustedSource = false
		};

		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		// Custom Declared Interceptors
		interceptors = [
		];

		// Register Custom DSL, don't map it because it is too late, mapping DSLs are only good by the parent app
		controller.getWireBox().registerDSL( namespace="javaloader", path="#moduleMapping#.model.JavaLoaderDSL" );

		// Bind Loader Proxy Class
		binder.map( "loader@javaloader" )
			.to( "#moduleMapping#.model.Loader" );

		// Bind Core JavaLoader
		binder.map( "jl@javaloader" )
			.to( "#moduleMapping#.model.javaloader.JavaLoader" )
			.initArg( name="loadPaths", 				value=settings.loadPaths )
			.initArg( name="loadColdFusionClassPath", 	value=settings.loadColdFusionClassPath )
			.initArg( name="parentClassLoader", 		value=settings.parentClassLoader )
			.initArg( name="sourceDirectories", 		value=settings.sourceDirectories )
			.initArg( name="compileDirectory", 			value=settings.compileDirectory )
			.initArg( name="trustedSource", 			value=settings.trustedSource );
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// Load JavaLoader and class load
		wirebox.getInstance( "loader@javaloader" ).setup();
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

	/**
	* Get an array of jar files
	*/
	private array function getJars( required string dirPath, string filter="*.jar" ){
		if( not directoryExists( arguments.dirPath ) ){
			throw( message="Invalid library path", detail="The path is #path#", type="JavaLoader.DirectoryNotFoundException" );
		}

		return directoryList( arguments.dirPath, true, "array", arguments.filter, "name desc" );
	}

}