cmake_minimum_required(VERSION 3.10.2 FATAL_ERROR)

set(PROJ_Name "cell-cmake")

project(${PROJ_Name}
  VERSION 1.0.0
  LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 17)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

# Prevent building in the source directory
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there.\n")
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(process_directory_files)

#启用glfw3
set(glfw3_DIR ${PROJECT_SOURCE_DIR}/libs/glfw3-3.4.0/lib/cmake/glfw3)
find_package(glfw3 3.4.0 CONFIG REQUIRED)

set(Assimp_DIR ${PROJECT_SOURCE_DIR}/libs/Assimp-5.4.3/lib/cmake/assimp-5.4)
find_package(Assimp 5.4.3 CONFIG REQUIRED)

file(GLOB_RECURSE all_dll_files "${PROJECT_SOURCE_DIR}/libs/*.dll")
foreach(file_dll ${all_dll_files})
  get_filename_component(_targe_name_ ${file_dll} NAME_WE)
  file(COPY_FILE ${file_dll} ${CMAKE_BINARY_DIR}/Release/${_targe_name_}.dll)
endforeach()

add_subdirectory(sources)