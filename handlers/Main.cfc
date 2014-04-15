/**
* My Event Handler Hint
*/
component{

	property name="antisamy" inject="antisamy@antisamy";

	// Index
	any function index( event,rc, prc ){
		rc.data = antisamy.clean( event.getValue( "data", "no data sent" ) );
	}

	// Run on first init
	any function onAppInit( event, rc, prc ){
	}

}