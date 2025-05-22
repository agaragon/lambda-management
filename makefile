run-tests:
	PYTHONPATH=functions/example-function python -m pytest functions/example-function/tests/
	PYTHONPATH=functions/whatsapp-integration python -m pytest functions/whatsapp-integration/tests/

run-tests-example-function:
	pytest functions/example-function/tests/
	
	