component extends="coldbox.system.Interceptor"{

	property name="wirebox" inject="wirebox";

	function configure(){
	}

	function onRequestCapture( event, interceptData, buffer ){
		var antiSamy = wirebox.getInstance( "AntiSamy@AntiSamy" );
		var rc = event.getCollection();

		for( var key in rc ){
			if( structKeyExists( rc, key ) and isSimpleValue( rc[ key ] ) ){
				rc[ key ] = antiSamy.clean( rc[ key ] );
			}
		}
	}

}