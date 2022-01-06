/**
 * My BDD Test
 */
component extends="coldbox.system.testing.BaseTestCase" appMapping="/root" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
		variables.model = getWireBox().getInstance( "antiSamy@cbantiSamy" );
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

			it( "tests model isstantiation", function(){
				expect( variables.model ).toBeComponent();
			} );

			it( "HTMLSantizer method should remove attack scripts from a string", function(){
				var attack      = "guest<script>alert('I am an attacker')</script>";
				var cleanedHTML = model.HTMLSanitizer( attack );
				expect( trim( cleanedHTML ) ).toBe( "guest" );
			} );

			it( "HTMLSanitizer should not clean safe HTML Tags", function(){
				var safe    = "<p>I am safe</p>";
				var cleaned = model.HTMLSanitizer( HTMLData = safe );
				expect( cleaned ).toBe( safe );
			} );

			it( "HTMLSantizer should return a boolean as to whether the HTML is safe when the check argument is passed", function(){
				var attack  = "guest<script>alert('I am an attacker')</script>";
				var cleaned = model.HTMLSanitizer( HTMLData = attack, check = true );
				expect( cleaned ).toBeFalse();
			} );

			it( "Will throw an error if an invalid policy file is specified", function(){
				expect( function(){
					return model.HTMLSanitizer( "<p>Foo</p>", "foo" );
				} ).toThrow( "cbantisamy.AntiSamy.InvalidPolicyFile" );
			} );

			it( "clean method will always return a string", function(){
				var attack      = "guest<script>alert('I am an attacker')</script>";
				var cleanedHTML = model.clean( attack );
				expect( trim( cleanedHTML ) ).toBeString().toBe( "guest" );
			} );

			it( "check method will always return a boolean", function(){
				var attack = "guest<script>alert('I am an attacker')</script>";
				var safe   = model.check( attack );
				expect( safe ).toBeFalse();
			} );
		} );
	}

}
