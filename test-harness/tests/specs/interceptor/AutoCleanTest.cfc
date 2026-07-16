/**
 * My BDD Test
 */
component extends="coldbox.system.testing.BaseTestCase" appMapping="/root" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){
		// all your suites go here.
		describe( "AntiSamy Module", function(){
			beforeEach( function( currentSpec ){
				setup();
			} );

			it( "should clean XSS junk from request collection", function(){
				url.data  = "guest<script>alert('I am an attacker')</script>";
				var event = execute( "main.index" );
				var rc    = event.getCollection();
				expect( rc.data ).toBe( "guest" );
			} );

			it( "should skip auto clean exclusions annotated on the current action", function(){
				url.data     = "guest<script>alert('I am an attacker')</script>";
				url.password = "secret<script>alert('leave me alone')</script>";
				var event    = execute( "main.index" );
				var rc       = event.getCollection();
				expect( rc.data ).toBe( "guest" );
				expect( rc.password ).toBe( "secret<script>alert('leave me alone')</script>" );
			} );

			it( "should skip auto clean exclusions configured for the current event", function(){
				url.data     = "guest<script>alert('I am an attacker')</script>";
				url.apiToken = "token<script>alert('leave me alone')</script>";
				var event    = execute( "main.configDriven" );
				var rc       = event.getCollection();
				expect( rc.data ).toBe( "guest" );
				expect( rc.apiToken ).toBe( "token<script>alert('leave me alone')</script>" );
			} );

			it( "should match configured auto clean exclusions for module event patterns", function(){
				url.data            = "guest<script>alert('I am an attacker')</script>";
				url.moduleToken     = "token<script>alert('leave me alone')</script>";
				url.moduleSignature = "signature<script>alert('leave me alone')</script>";
				var event           = execute( "api-v1:Trips.update" );
				var rc              = event.getCollection();
				expect( rc.data ).toBe( "guest" );
				expect( rc.moduleToken ).toBe( "token<script>alert('leave me alone')</script>" );
				expect( rc.moduleSignature ).toBe( "signature<script>alert('leave me alone')</script>" );
			} );
		} );
	}

}
