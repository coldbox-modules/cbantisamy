/**
 * Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 * This Interceptor if activated automatically cleans the request collection for you
 */
component extends="coldbox.system.Interceptor" {

	// DI: This is a provider as it needs to javaloaded first
	property name="antisamy" inject="provider:AntiSamy@CBAntiSamy";

	// The handler method annotation used to exclude request collection keys from auto-cleaning
	variables.AUTO_CLEAN_EXCLUSIONS_ANNOTATION = "antisamyAutoCleanExclusions";

	// On request capture
	function onRequestCapture( event, interceptData, buffer, rc, prc ){
		// if not activated, just exit
		if ( !getModuleSettings( "cbantisamy", "autoClean" ) || !event.getPrivateValue( "antisamy-autoclean", true ) ) {
			return;
		}

		var exclusions = getAutoCleanExclusions( event );

		rc.keyArray()
			.each( function( key ){
				if ( !arrayFindNoCase( exclusions, key ) && !isNull( rc[ key ] ) && isSimpleValue( rc[ key ] ) ) {
					rc[ key ] = variables.antiSamy.clean( rc[ key ] );
				}
			} );
	}

	/**
	 * Resolve the request collection keys excluded from auto-cleaning for this event action.
	 */
	private array function getAutoCleanExclusions( required event ){
		var exclusions = [];

		exclusions.append( getConfiguredAutoCleanExclusions( arguments.event ), true );

		exclusions.append(
			normalizeAutoCleanExclusionKeys( getActionAutoCleanExclusionsAnnotation( arguments.event ) ),
			true
		);

		exclusions.append(
			normalizeAutoCleanExclusionKeys(
				arguments.event.getPrivateValue( "antisamy-autoclean-exclusions", [] )
			),
			true
		);

		return exclusions;
	}

	/**
	 * Resolve configured auto-clean exclusions for the current event.
	 */
	private array function getConfiguredAutoCleanExclusions( required event ){
		var settings = getModuleSettings( "cbantisamy" );

		if ( !settings.keyExists( "autoCleanExclusions" ) ) {
			return [];
		}

		if ( !isStruct( settings.autoCleanExclusions ) ) {
			return normalizeAutoCleanExclusionKeys( settings.autoCleanExclusions );
		}

		var exclusions = [];
		var patterns   = getAutoCleanExclusionEventPatterns( arguments.event );

		settings.autoCleanExclusions.each( function( pattern, keys ){
			if ( arrayFindNoCase( patterns, pattern ) ) {
				exclusions.append( normalizeAutoCleanExclusionKeys( keys ), true );
			}
		} );

		return exclusions;
	}

	/**
	 * Build the event patterns checked for configured auto-clean exclusions.
	 */
	private array function getAutoCleanExclusionEventPatterns( required event ){
		var currentEvent = arguments.event.getCurrentEvent();
		var patterns     = [ "*" ];

		if ( len( currentEvent ) ) {
			patterns.append( currentEvent );
			patterns.append( getEventHandlerPattern( currentEvent ) );

			if ( find( ":", currentEvent ) ) {
				patterns.append( listFirst( currentEvent, ":" ) & ":*" );
			}
		}

		return patterns;
	}

	/**
	 * Build an event handler wildcard pattern, preserving ColdBox module event prefixes.
	 */
	private string function getEventHandlerPattern( required string event ){
		return listFirst( arguments.event, "." ) & ".*";
	}

	/**
	 * Read the target handler action's auto-clean exclusions annotation.
	 */
	private any function getActionAutoCleanExclusionsAnnotation( required event ){
		var currentEvent = arguments.event.getCurrentEvent();

		if ( !len( currentEvent ) ) {
			return [];
		}

		try {
			var handlerService = controller.getHandlerService();
			var handlerBean    = handlerService.getHandlerBean( currentEvent );
			var action         = handlerBean.getMethod();
			var actionMetadata = getComponentActionMetadata( handlerBean.getRunnable(), action );

			if ( structIsEmpty( actionMetadata ) ) {
				var handler    = handlerService.newHandler( handlerBean );
				actionMetadata = structKeyExists( handler, action ) ? getMetadata( handler[ action ] ) : handler._actionMetadata(
					action
				);
			}

			return getAutoCleanExclusionsAnnotationValue( actionMetadata );
		} catch ( any e ) {
			return [];
		}
	}

	/**
	 * Find action metadata by reading the handler CFC metadata directly.
	 */
	private struct function getComponentActionMetadata( required string componentPath, required string action ){
		var componentMetadata = getComponentMetadata( arguments.componentPath );

		if ( !componentMetadata.keyExists( "functions" ) ) {
			return {};
		}

		for ( var functionMetadata in componentMetadata.functions ) {
			if (
				functionMetadata.keyExists( "name" ) && compareNoCase( functionMetadata.name, arguments.action ) == 0
			) {
				return functionMetadata;
			}
		}

		return {};
	}

	/**
	 * Read the auto-clean exclusions value from function metadata or docblock annotations.
	 */
	private any function getAutoCleanExclusionsAnnotationValue( required struct actionMetadata ){
		var exclusions = getStructValueNoCase(
			arguments.actionMetadata,
			variables.AUTO_CLEAN_EXCLUSIONS_ANNOTATION
		);

		if ( !isNull( exclusions ) ) {
			return exclusions;
		}

		if ( arguments.actionMetadata.keyExists( "annotations" ) ) {
			exclusions = getStructValueNoCase(
				arguments.actionMetadata.annotations,
				variables.AUTO_CLEAN_EXCLUSIONS_ANNOTATION
			);

			if ( !isNull( exclusions ) ) {
				return exclusions;
			}
		}

		return [];
	}

	/**
	 * Find a struct value by key without relying on the engine's key case behavior.
	 */
	private any function getStructValueNoCase( required struct target, required string key ){
		for ( var targetKey in arguments.target ) {
			if ( compareNoCase( targetKey, arguments.key ) == 0 ) {
				return arguments.target[ targetKey ];
			}
		}
	}

	/**
	 * Normalize an exclusion value to an array of key names.
	 */
	private array function normalizeAutoCleanExclusionKeys( required any keys ){
		var normalizedKeys = [];

		if ( isArray( arguments.keys ) ) {
			arguments.keys.each( function( key ){
				if ( isSimpleValue( key ) && len( trim( key ) ) ) {
					normalizedKeys.append( trim( key ) );
				}
			} );
		} else if ( isSimpleValue( arguments.keys ) ) {
			listToArray( arguments.keys ).each( function( key ){
				if ( len( trim( key ) ) ) {
					normalizedKeys.append( trim( key ) );
				}
			} );
		}

		return normalizedKeys;
	}

}
