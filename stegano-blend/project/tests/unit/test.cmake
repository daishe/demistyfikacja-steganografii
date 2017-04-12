# Author: M. Dalewski



##### Test initialization ------------------------------------------------------

# Additional source files to compile with test version
file(
    GLOB_RECURSE t.source RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_LIST_DIR}/*.c
    ${CMAKE_CURRENT_LIST_DIR}/*.cpp
    ${CMAKE_CURRENT_LIST_DIR}/*.h
    ${CMAKE_CURRENT_LIST_DIR}/*.hpp
)

# Compiler definitions and directories for test files
include_directories("${CMAKE_CURRENT_LIST_DIR}")

# Test executanle name
set(t.executable_name "${PROJECT_NAME}-test-${TEST_ROOT_NAME}")

# Test version of application
add_executable(${t.executable_name} ${project.source} ${t.source})
list(APPEND test.executables "${t.executable_name}")

# Includes
target_include_directories(${t.executable_name} PUBLIC "${project.include}" "${CMAKE_CURRENT_LIST_DIR}")

# Compiler definitions
build_type_compose(project.define.buildtypebased "${project.define}" "${project.define.debug}" "${project.define.release}" "${project.define.relwithdebinfo}" "${project.define.minsizerel}")
target_compile_definitions(${t.executable_name} PUBLIC ${project.define.buildtypebased})

# Compiler flags
build_type_compose(project.cflags.buildtypebased "${project.cflags}" "${project.cflags.debug}" "${project.cflags.release}" "${project.cflags.relwithdebinfo}" "${project.cflags.minsizerel}")
target_compile_options(${t.executable_name} PUBLIC ${project.cflags.buildtypebased})

# Linker flags
set_property(TARGET ${t.executable_name} PROPERTY LINK_FLAGS ${project.lflags})

# Link libraries
target_link_libraries(${t.executable_name} ${project.link})



##### Test cases ---------------------------------------------------------------

add_test(test_${TEST_ROOT_NAME} ${t.executable_name})
