set(_target_name "cell")

process_directory_files(diretoryfiles
  DIRECTORIES cell demo math utility
)

add_definitions(-DSTB_IMAGE_IMPLEMENTATION)
add_definitions(-DSTB_IMAGE_STATIC)

add_executable(${_target_name} ${diretoryfiles})

target_include_directories(${_target_name}
  PUBLIC
  ${CMAKE_CURRENT_BINARY_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(${_target_name}
  PUBLIC
  glfw
  assimp::assimp

  # assimp::zlibstatic
)

# set working directory
set_target_properties(${_target_name} PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}/resources")

option(CELL_DEBUG_OPTION "debug info while release" OFF)

if(${CELL_DEBUG_OPTION})
  if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    target_compile_options(${_target_name} PRIVATE /Zi /Od)

    # Tell linker to include symbol data
    set_target_properties(${_target_name} PROPERTIES
      LINK_FLAGS "/INCREMENTAL:NO /DEBUG /OPT:REF /OPT:ICF"
    )

    # Set file name & location
    set_target_properties(${_target_name} PROPERTIES
      COMPILE_PDB_NAME ${_target_name}
      COMPILE_PDB_OUTPUT_DIR ${CMAKE_BINARY_DIR}
    )
  else()
    # other system like linux
    message(FATAL_ERROR "")
  endif()
endif()