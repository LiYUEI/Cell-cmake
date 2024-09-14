include(CMakeParseArguments)

macro(process_directory_files subfiles)

    set(${subfiles} PARENT_SCOPE)

    set(_OPTIONS_ARGS)
    set(_ONE_VALUE_ARGS)
    set(_MULTI_VALUE_ARGS DIRECTORIES)

    cmake_parse_arguments(_Perfix "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN} )

    # 循环获取路径
    foreach(child ${_Perfix_DIRECTORIES})
        file(GLOB _local_header_files ${CMAKE_CURRENT_SOURCE_DIR}/${child}/*.h)
        file(GLOB _local_source_files ${CMAKE_CURRENT_SOURCE_DIR}/${child}/*.c??)

        list(APPEND ${subfiles} ${_local_header_files})
        list(APPEND ${subfiles} ${_local_source_files})

        source_group("${child}" FILES ${_local_header_files} ${_local_source_files})
    endforeach()

    # 递归再往下获取一层
    foreach(child ${_Perfix_DIRECTORIES})
        file(GLOB children ${CMAKE_CURRENT_SOURCE_DIR}/${child}/*)
        foreach(subsubdir ${children})
            if(IS_DIRECTORY ${subsubdir})
                file(GLOB _local_sub_header_files ${subsubdir}/*.h)
                file(GLOB _local_sub_source_files ${subsubdir}/*.c??)

                list(APPEND ${subfiles} ${_local_sub_header_files})
                list(APPEND ${subfiles} ${_local_sub_source_files})

                get_filename_component(_dir_name ${subsubdir} NAME_WE)
                source_group("${child}/${_dir_name}" FILES ${_local_sub_header_files} ${_local_sub_source_files})
            endif()
        endforeach()
    endforeach()

endmacro()