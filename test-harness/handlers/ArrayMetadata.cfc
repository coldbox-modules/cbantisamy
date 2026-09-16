component {

	property name="antisamy" inject="antisamy@cbantisamy";

	any function index( event, rc, prc ) antisamyAutoCleanExclusions=[ "password", "payloadJSON" ] {
		rc.data = antisamy.clean( event.getValue( "data", "no data sent" ) );
	}

}
