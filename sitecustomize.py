import os
if str(os.environ.get('PYCOVERAGE')) == '1':
    os.environ['COVERAGE_PROCESS_START'] = r'/scons/.coveragerc'
    os.environ['COVERAGE_FILE'] = r'/scons/.coverage'
    import coverage
    coverage.process_startup()
