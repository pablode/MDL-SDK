::*****************************************************************************
:: Copyright (c) 2022-2024, NVIDIA CORPORATION. All rights reserved.
::
:: Redistribution and use in source and binary forms, with or without
:: modification, are permitted provided that the following conditions
:: are met:
::  * Redistributions of source code must retain the above copyright
::    notice, this list of conditions and the following disclaimer.
::  * Redistributions in binary form must reproduce the above copyright
::    notice, this list of conditions and the following disclaimer in the
::    documentation and/or other materials provided with the distribution.
::  * Neither the name of NVIDIA CORPORATION nor the names of its
::    contributors may be used to endorse or promote products derived
::    from this software without specific prior written permission.
::
:: THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
:: EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
:: IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
:: PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
:: CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
:: EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
:: PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
:: PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
:: OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
:: (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
:: OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
::*****************************************************************************
@echo off
@IGNORE_THE_FOLLOWING_COMMENT@
:: This file is generated during CMake Configuration.
:: If you want to regenerate it, delete this file and run CMake Configure again.

:: On Windows this batch file can be used to quickly run the example.
:: Alternatively, on every platform, you can open the Visual Studio Code workspace:
::   @CMAKE_BINARY_DIR@/mdl_python_examples.code-workspace

call @CMAKE_CURRENT_BINARY_DIR@/../env/@_CONFIG@/setup_env.bat

echo Python:     %PYTHON_BINARY%
for /f "tokens=1-2" %%i in ('%PYTHON_BINARY% --version') do set PYTHON_VERSION=%%i %%j
echo Version:    %PYTHON_VERSION%
:: echo PYTHONPATH: %PYTHONPATH%
:: echo @ENV_LIB_PATH@:       %@ENV_LIB_PATH@%
echo.
echo.

SET CREATE_COVERAGE_REPORT=@CREATE_COVERAGE_REPORT@
SET REPORT_DIR=coverage_report
IF "%CREATE_COVERAGE_REPORT%"=="TRUE" (
    IF EXIST %REPORT_DIR% RD /q /s "%cd%\%REPORT_DIR%"
    MKDIR %REPORT_DIR%
    %PYTHON_BINARY% -m coverage run --data-file %REPORT_DIR%/.coverage @CMAKE_CURRENT_SOURCE_DIR@/@CREATE_FROM_PYTHON_PRESET_MAIN@ %*
    %PYTHON_BINARY% -m coverage html --data-file %REPORT_DIR%/.coverage --directory %REPORT_DIR%
) ELSE (
    %PYTHON_BINARY% @CMAKE_CURRENT_SOURCE_DIR@/@CREATE_FROM_PYTHON_PRESET_MAIN@ %*
)
