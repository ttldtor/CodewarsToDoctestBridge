# Copyright (c) 2024 ttldtor.
# SPDX-License-Identifier: BSL-1.0

## org_ttldtor_ParseVersion(<version>, [majorVersion, [minorVersion, [patchVersion, [suffixVersion]]]])
function(org_ttldtor_ParseVersion)
    set(__org_ttldtor_ParseVersion_Usage "org_ttldtor_ParseVersion(<version>, [majorVersion, [minorVersion, [patchVersion, [suffixVersion]]]])")

    if (ARGC EQUAL 0)
        message(FATAL_ERROR "Empty function parameter list!\nUsage: ${__org_ttldtor_ParseVersion_Usage}")
    endif ()

    set(version "${ARGV0}")

    set(_majorVersion "0")
    set(_minorVersion "0")
    set(_patchVersion "0")
    set(_suffixVersion "")

    string(REGEX REPLACE "^v?([0-9]+).*$" "\\1" _majorVersion ${version})

    if (${_majorVersion} STREQUAL "")
        set(_majorVersion "0")
    else ()
        string(REGEX REPLACE "^v?[0-9]+\\.([0-9]+).*$" "\\1" _minorVersion ${version})

        if (${_minorVersion} STREQUAL "")
            set(_minorVersion "0")
            string(REGEX REPLACE "^v?[0-9]+(.*)$" "\\1" _suffixVersion ${version})
        else ()
            string(REGEX REPLACE "^v?[0-9]+\\.[0-9]+\\.([0-9]+).*$" "\\1" _patchVersion ${version})

            if (${_patchVersion} STREQUAL "")
                set(_patchVersion "0")
                string(REGEX REPLACE "^v?[0-9]+\\.[0-9]+(.*)$" "\\1" _suffixVersion ${version})
            else ()
                string(REGEX REPLACE "^v?[0-9]+\\.[0-9]+\\.[0-9]+(.*)$" "\\1" _suffixVersion ${version})
            endif ()
        endif ()
    endif ()

    if (ARGC EQUAL 1)
        message(STATUS "Major version: '${_majorVersion}'")
        message(STATUS "Minor version: '${_minorVersion}'")
        message(STATUS "Patch version: '${_patchVersion}'")
        message(STATUS "Suffix version: '${_suffixVersion}'")
    endif ()

    if (ARGC GREATER 1)
        set(${ARGV1} "${_majorVersion}" PARENT_SCOPE)

        if (ARGC GREATER 2)
            set(${ARGV2} "${_minorVersion}" PARENT_SCOPE)

            if (ARGC GREATER 3)
                set(${ARGV3} "${_patchVersion}" PARENT_SCOPE)

                if (ARGC GREATER 4)
                    set(${ARGV4} "${_suffixVersion}" PARENT_SCOPE)
                endif ()
            endif ()
        endif ()
    endif ()
endfunction()