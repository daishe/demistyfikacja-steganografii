# Author: M. Dalewski



##### Project ------------------------------------------------------------------

# Project name
project(stegano-blend)



##### Source files and directories ---------------------------------------------

# Project source files
set(project.source.main "${CMAKE_CURRENT_LIST_DIR}/main.cpp")
file(
    GLOB_RECURSE tmp
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_LIST_DIR}/src/*.c
    ${CMAKE_CURRENT_LIST_DIR}/src/*.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/*.h
    ${CMAKE_CURRENT_LIST_DIR}/src/*.hpp
)
list(APPEND project.source "${tmp}")

# Project header files locations
list(APPEND project.include "${CMAKE_CURRENT_LIST_DIR}/include" "${CMAKE_CURRENT_LIST_DIR}/src")



##### Flags and definitions ----------------------------------------------------

# Compiler definitions
list(APPEND project.define)
# list(APPEND project.define.debug                )
# list(APPEND project.define.release        NDEBUG)
# list(APPEND project.define.relwithdebinfo NDEBUG)
# list(APPEND project.define.minsizerel     NDEBUG)

# Compiler flags
list(APPEND project.cflags -Wall -std=gnu++17 -std=c++17)
# list(APPEND project.cflags.debug          -O0 -g)
# list(APPEND project.cflags.release        -O3   )
# list(APPEND project.cflags.relwithdebinfo -O2 -g)
# list(APPEND project.cflags.minsizerel     -Os   )

if(MINGW OR MSYS OR CYGWIN OR CMAKE_COMPILER_IS_GNUCXX)
    list(APPEND project.cflags -Wextra)
endif()

# Linker flags
set(project.lflags "${project.lflags}")



##### Dependencies -------------------------------------------------------------

# Add custom modules directory
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake_modules" ${CMAKE_MODULE_PATH})

# Project dependencies (see dependencies.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/dependencies.cmake)



##### Main target -----------------------------------------------------------

# Basic executable name
set(project.executable_name ${PROJECT_NAME})

# Basic executable
add_executable(${project.executable_name} ${project.source} ${project.source.main})

# Includes
target_include_directories(${project.executable_name} PUBLIC "${project.include}")

# Compiler definitions
build_type_compose(project.define.buildtypebased "${project.define}" "${project.define.debug}" "${project.define.release}" "${project.define.relwithdebinfo}" "${project.define.minsizerel}")
target_compile_definitions(${project.executable_name} PUBLIC ${project.define.buildtypebased})

# Compiler flags
build_type_compose(project.cflags.buildtypebased "${project.cflags}" "${project.cflags.debug}" "${project.cflags.release}" "${project.cflags.relwithdebinfo}" "${project.cflags.minsizerel}")
target_compile_options(${project.executable_name} PUBLIC ${project.cflags.buildtypebased})

# Linker flags
set_property(TARGET ${project.executable_name} PROPERTY LINK_FLAGS ${project.lflags})

# Link libraries
target_link_libraries(${project.executable_name} ${project.link})



##### Tests --------------------------------------------------------------------

# Enable testing - user option
option("${PROJECT_NAME}_TESTING" "If this option is enabled, a set of new executables is created (with project tests)." ON)
get_property(options.test VARIABLE PROPERTY "${PROJECT_NAME}_TESTING")

# If testing is enabled include required packages
if(${options.test})
    include(${CMAKE_CURRENT_LIST_DIR}/test.cmake)
endif()
