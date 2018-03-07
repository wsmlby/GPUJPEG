# Modified version of https://github.com/Kitware/CMake/blob/master/Modules/FindGLEW.cmake
#
#.rst:
# FindGLEW
# --------
#
# Find the OpenGL Extension Wrangler Library (GLEW)
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``GLEW::GLEW``,
# if GLEW has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   GLEW_INCLUDE_DIRS - include directories for GLEW
#   GLEW_LIBRARIES - libraries to link against GLEW
#   GLEW_FOUND - true if GLEW has been found and can be used

#=============================================================================
# Copyright 2012 Benjamin Eikel
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

find_path(GLEW_INCLUDE_DIR GL/glew.h)

if(WIN32)
    if("${CMAKE_SIZEOF_VOID_P}" EQUAL "8")
        set(path_suffix "amd64")
    else()
        set(path_suffix "")
    endif()
    find_library(GLEW_LIBRARY NAMES GLEW glew32 glew glew32s PATH_SUFFIXES ${path_suffix})
    find_file(GLEW_DLL NAMES GLEW glew32.dll glew.dll glew32s.dll PATH_SUFFIXES ${path_suffix})
    if(GLEW_DLL STREQUAL "GLEW_DLL-NOTFOUND")
        unset(GLEW_DLL CACHE)
    endif()
else()
    find_library(GLEW_LIBRARY NAMES GLEW glew32 glew glew32s)
endif()

set(GLEW_INCLUDE_DIRS ${GLEW_INCLUDE_DIR})
set(GLEW_LIBRARIES ${GLEW_LIBRARY})

find_package(PackageHandleStandardArgs)
find_package_handle_standard_args(GLEW
                                  REQUIRED_VARS GLEW_INCLUDE_DIR GLEW_LIBRARY)

if(GLEW_FOUND AND NOT TARGET GLEW::GLEW)
  add_library(GLEW::GLEW UNKNOWN IMPORTED)
  set_target_properties(GLEW::GLEW PROPERTIES
    IMPORTED_LOCATION "${GLEW_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${GLEW_INCLUDE_DIRS}")
endif()

mark_as_advanced(GLEW_INCLUDE_DIR GLEW_LIBRARY)