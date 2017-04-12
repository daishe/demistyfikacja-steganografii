# Author: M. Dalewski



##### Threads -------------------------------------------------------------

# Find package
find_package(Threads REQUIRED)

# Set libraries to link
list(APPEND LINK_LIBRARIES_LIST "Threads::Threads")



##### Boost -------------------------------------------------------------

# Set options
set(Boost_NO_BOOST_CMAKE     ON)
set(Boost_USE_STATIC_LIBS    ON)
set(Boost_USE_STATIC_RUNTIME OFF)
set(Boost_USE_MULTITHREADED  ON)

# Set requied components (by main executable)
set(Boost_COMPONENTS system random)

# Set requied components (by test executables)
if(ENABLE_TESTING)
    set(Boost_COMPONENTS ${Boost_COMPONENTS})
endif()

# Find package
find_package(Boost 1.56.0 COMPONENTS ${Boost_COMPONENTS} REQUIRED)

# Set include directories
list(APPEND project.include ${Boost_INCLUDE_DIRS})

# Set libraries to link
list(APPEND project.link ${Boost_RANDOM_LIBRARY} ${Boost_SYSTEM_LIBRARY})



##### SFML ----------------------------------------------------------------

# Find package
find_package(SFML 2 REQUIRED system window graphics)

# Set include directories
list(APPEND project.include ${SFML_INCLUDE_DIR})

# Set libraries to link
list(APPEND project.link ${SFML_LIBRARIES})

