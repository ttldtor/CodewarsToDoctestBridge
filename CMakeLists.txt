# Copyright (c) 2024 ttldtor.
# SPDX-License-Identifier: BSL-1.0

cmake_minimum_required(VERSION 3.21)

if (POLICY CMP0092)
    cmake_policy(SET CMP0092 NEW)
endif ()

if (POLICY CMP0135)
    cmake_policy(SET CMP0135 NEW)
endif ()

project(CodewarsToDoctestBridge)

include(cmake/ParseVersion.cmake)

set(ORG_TTLDTOR_CW2DT_VERSION "v1.0.0" CACHE STRING "The Codewars -> Doctest testing system bridge version.")

org_ttldtor_ParseVersion(${ORG_TTLDTOR_CW2DT_VERSION} ORG_TTLDTOR_CW2DT_MAJOR_VERSION ORG_TTLDTOR_CW2DT_MINOR_VERSION ORG_TTLDTOR_CW2DT_PATCH_VERSION ORG_TTLDTOR_CW2DT_SUFFIX_VERSION)

set(CPM_CMAKE_VERSION "v0.40.2")
set(DOCTEST_VERSION "2.4.11")

include(cmake/third_party/CPM.cmake-${CPM_CMAKE_VERSION}/CPM.cmake)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CXX_EXTENSIONS OFF)
set(C_EXTENSIONS OFF)

if (NOT DEFINED ORG_TTLDTOR_CW2DT_IS_ROOT_PROJECT)
    if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
        set(ORG_TTLDTOR_CW2DT_IS_ROOT_PROJECT ON)
        message(STATUS "CMake version: ${CMAKE_VERSION}")
    else ()
        set(ORG_TTLDTOR_CW2DT_ROOT_PROJECT OFF)
    endif ()
endif ()

CPMAddPackage("gh:doctest/doctest#v${DOCTEST_VERSION}")

add_library(${PROJECT_NAME} INTERFACE include/cw2dt.hpp)
add_library(cw2dt ALIAS ${PROJECT_NAME})
add_library(cw2dt::cw2dt ALIAS ${PROJECT_NAME})
target_include_directories(${PROJECT_NAME} INTERFACE include)
target_link_libraries(${PROJECT_NAME} INTERFACE doctest)