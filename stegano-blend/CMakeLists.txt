# Author: M. Dalewski



##### Initialization -----------------------------------------------------------

# Required version
cmake_minimum_required(VERSION 3.1)



##### Utilities ----------------------------------------------------------------

# Set default build type
if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build, options are: None (CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used), Debug, Release, RelWithDebInfo, MinSizeRel." FORCE)
else()
   set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING "Choose the type of build, options are: None (CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used), Debug, Release, RelWithDebInfo, MinSizeRel.")
endif()

# Allow easy adding flags, based on build type
function(build_type_compose out global debug release relwithdebinfo minsizerel)
    set(
        ${out}
        ${global}
        $<$<CONFIG:Debug>:${debug}>
        $<$<CONFIG:Release>:${release}>
        $<$<CONFIG:RelWithDebInfo>:${relwithdebinfo}>
        $<$<CONFIG:MinSizeRel>:${minsizerel}>
        PARENT_SCOPE
    )
endfunction()



##### Project ------------------------------------------------------------------

# Include project main CMake file
include(project/root.cmake)
