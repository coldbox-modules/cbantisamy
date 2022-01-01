/**
 * My BDD Test
 */
component extends="coldbox.system.testing.BaseTestCase" appMapping="/root" {

    /*********************************** LIFE CYCLE Methods ***********************************/

    // executes before all suites+specs in the run() method
    function beforeAll() {
        super.beforeAll();
    }

    // executes after all suites+specs in the run() method
    function afterAll() {
        super.afterAll();
    }

    /*********************************** BDD SUITES ***********************************/

    function run() {
        // all your suites go here.
        describe('AntiSamy Module', function() {
            beforeEach(function(currentSpec) {
                setup();
            });

            it('should clean XSS junk from request collection', function() {
                url.data = 'guest<script>alert(''I am an attacker'')</script>';
                var event = execute('main.index');
                var rc = event.getCollection();
                expect(rc.data).toBe('guest');
            });

        });
    }

}
