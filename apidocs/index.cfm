<cfparam name="url.version" default="0">
<cfparam name="url.path" 	default="#expandPath( "./CBAntiSamy-APIDocs" )#">
<cfscript>
	docName = "CBAntiSamy-APIDocs";
	base = expandPath( "/cbantisamy" );

	colddoc 	= new ColdDoc();
	strategy 	= new colddoc.strategy.api.HTMLAPIStrategy( url.path, "CBAntiSamy v#url.version#" );
	colddoc.setStrategy( strategy );

	colddoc.generate( inputSource=base, outputDir=url.path, inputMapping="cbantisamy" );
</cfscript>

<!---
<cfzip action="zip" file="#expandPath('.')#/#docname#.zip" source="#expandPath( docName )#" overwrite="true" recurse="yes">
<cffile action="move" source="#expandPath('.')#/#docname#.zip" destination="#url.path#">
--->

<cfoutput>
<h1>Done!</h1>
<a href="#docName#/index.html">Go to Docs!</a>
</cfoutput>

