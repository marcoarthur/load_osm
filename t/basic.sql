SET client_min_messages TO warning; 
CREATE EXTENSION IF NOT EXISTS pgtap; 
RESET client_min_messages; 

BEGIN; 

SELECT no_plan(); 

-- SELECT ok('add tests here'); 
SELECT pass( 'My test passed, w00t!' );

SELECT finish(); 
ROLLBACK; 
