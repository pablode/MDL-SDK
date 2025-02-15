#!/bin/bash

#*****************************************************************************
# Copyright 2023 NVIDIA Corporation. All rights reserved.
#*****************************************************************************

@IGNORE_THE_FOLLOWING_COMMENT@
# This file is generated during CMake Configuration.
# If you want to regenerate it, delete this file and run CMake Configure again.

# On Windows we assume this script to be executed in an Unix environment like the git-bash or mingw.
# Alternatively, on every platform, you can open the Visual Studio Code workspace:
#   @CMAKE_BINARY_DIR@/mdl_python_examples.code-workspace

. @CMAKE_CURRENT_BINARY_DIR@/../env/@_CONFIG@/setup_env.sh

echo "Python:     " ${PYTHON_BINARY}
PYTHON_VERSION=$(${PYTHON_BINARY} --version)
echo "Version:    " ${PYTHON_VERSION}
# echo "PYTHONPATH: " ${PYTHONPATH}
# echo "@ENV_LIB_PATH@: " ${@ENV_LIB_PATH@}
echo
echo

${PYTHON_BINARY} @CMAKE_CURRENT_SOURCE_DIR@/@CREATE_FROM_PYTHON_PRESET_MAIN@ "$@"