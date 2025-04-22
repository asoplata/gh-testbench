
powershell -Command "Invoke-WebRequest https://github.com/neuronsimulator/nrn/releases/download/8.2.6/nrn-8.2.6.w64-mingw-py-38-39-310-311-312-setup.exe -OutFile nrn-setup.exe"
if errorlevel 1 exit 1

:: start /b /wait .\nrn-setup.exe /S /D=C:\nrn_hnn_conda_install
start /b /wait .\nrn-setup.exe /S /D=C:\nrn
if errorlevel 1 exit 1

%PREFIX%\python.exe -m pip install . -vv --no-deps --no-build-isolation
:: "%PYTHON%" -m pip install . -vv --no-deps --no-build-isolation
if errorlevel 1 exit 1