@echo off
echo =======================================================
echo       JENKINS PIPELINE LOCAL SIMULATION RUNNER
echo =======================================================
echo.

echo -------------------------------------------------------
echo [STAGE 1] BUILD: Creating venv and installing packages
echo -------------------------------------------------------
python -m venv --system-site-packages venv
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Build failed during venv creation.
    goto failure
)
echo [BUILD SUCCESS] Virtual environment initialized.
echo.

echo -------------------------------------------------------
echo [STAGE 2] TEST: Running unittests
echo -------------------------------------------------------
.\venv\Scripts\python -m unittest discover -v
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [TEST FAILED] One or more assertions failed!
    goto failure
)
echo [TEST SUCCESS] All tests passed!
echo.

echo -------------------------------------------------------
echo [STAGE 3] DEPLOY: Gating passed! Deploying app
echo -------------------------------------------------------
if not exist deployment mkdir deployment
copy /Y app.py deployment\
dir deployment
echo.
echo =======================================================
echo [POST ACTION] Pipeline succeeded - app deployed.
echo =======================================================
exit /b 0

:failure
echo.
echo =======================================================
echo [POST ACTION] Pipeline failed - check the logs.
echo Deploy stage was SKIPPED. Broken code blocked from release.
echo =======================================================
exit /b 1
