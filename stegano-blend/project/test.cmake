# Author: M. Dalewski



##### Testing initialization ---------------------------------------------------

# Enable
enable_testing()



##### Test cases ---------------------------------------------------------------

# 1st - Original version of application runs
add_test(application_run ${project.executable_name})

# 2nd - List all tests locations
FILE(GLOB possible_test_directories RELATIVE ${CMAKE_CURRENT_LIST_DIR}/tests ${CMAKE_CURRENT_LIST_DIR}/tests/*)
FOREACH(TEST_ROOT_NAME ${possible_test_directories})
    IF(IS_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/tests/${TEST_ROOT_NAME})

        # Enable specific test - user option
        option("${PROJECT_NAME}_TESTING \"tests/${TEST_ROOT_NAME}\"" "If this option is enabled, an executable for test ${TEST_ROOT_NAME} is created." ON)
        mark_as_advanced("${PROJECT_NAME}_TESTING \"tests/${TEST_ROOT_NAME}\"")
        get_property(options.test.current VARIABLE PROPERTY "${PROJECT_NAME}_TESTING \"tests/${TEST_ROOT_NAME}\"")

        # Include test case from a given location (if enabled)
        if(${options.test.current})
            include(${CMAKE_CURRENT_LIST_DIR}/tests/${TEST_ROOT_NAME}/test.cmake)
        endif()

    ENDIF()
ENDFOREACH()
