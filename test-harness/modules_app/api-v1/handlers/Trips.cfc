component {

	property name="antisamy" inject="antisamy@cbantisamy";

	any function update( event, rc, prc ){
		rc.data = antisamy.clean( event.getValue( "data", "no data sent" ) );
	}

}
