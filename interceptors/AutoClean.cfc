/**
* Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ---
* This Interceptor if activated automatically cleans the request collection for you
*/
component extends="coldbox.system.Interceptor"{

	// DI: This is a provider as it needs to javaloaded first
	property name="antisamy" inject="provider:AntiSamy@CBAntiSamy";

	// On request capture
	function onRequestCapture( event, interceptData, buffer, rc, prc ){
		// if not activated, just exit
		if( !getModuleSettings( "cbantisamy", "autoClean" ) || !event.getPrivateValue( "antisamy-autoclean", true ) ){
			return;
		}

		rc.keyArray().each(
			function( key ){
				if( !isNull( rc[ key ] ) && isSimpleValue( rc[ key ] ) ){
					rc[ key ] = variables.antiSamy.clean( rc[ key ] );
				}
			}
		);

	}

}
