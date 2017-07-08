running
tearDown
	super tearDown.

	monitor disable.	
	classFactory cleanUp.
	logBuilder cleanUp.