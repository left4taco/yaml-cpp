# Set defaults
if(NOT CMAKE_C_STANDARD)
  message(STATUS "Setting C Standard to 11.")
  set(CMAKE_C_STANDARD 11 CACHE STRING "" FORCE)
endif()

if(NOT CMAKE_CXX_STANDARD)
  message(STATUS "Setting C++ Standard to 14.")
  set(CMAKE_CXX_STANDARD 14 CACHE STRING "" FORCE)
endif()

# Compiler flags for all builds
list(APPEND CMAKE_C_FLAGS
  -frecord-gcc-switches
  -Wall
  -Werror=format-security
  -Werror=implicit-function-declaration
  -Wextra
  -Wno-unused
  -Wcast-align
  -Wunused-result
  -Wno-error=deprecated-declarations # necessary to indicate deprecated features to users.
)

list(APPEND CMAKE_CXX_FLAGS
  # this is the part to build with libc++
  -nostdinc++
  -nodefaultlibs
  -I/usr/include/c++/v1
  -lc++
  -lc++abi
  -lc
  -lgcc_s
  -lgcc
  ${CMAKE_C_FLAGS}
  -Woverloaded-virtual
  -Wlogical-op
  -Wno-noexcept-type
  -Wno-duplicated-branches
  -Wno-stringop-overflow
#  -Wsuggest-override
)
link_libraries(c++ c++abi c gcc_s gcc)

list(APPEND CMAKE_C_FLAGS ${EXTRA_C_FLAGS})
list(APPEND CMAKE_CXX_FLAGS ${EXTRA_CXX_FLAGS})

# Convert lists to space-separated string
macro(configure_flag_var)
  string(REPLACE ";" " " ${ARGV0} "${${ARGV0}}")
  set(${ARGV0} "${${ARGV0}}" CACHE STRING "" FORCE)
endmacro()

configure_flag_var(CMAKE_C_FLAGS)
configure_flag_var(CMAKE_CXX_FLAGS)
configure_flag_var(CMAKE_C_FLAGS_COVERAGE)
configure_flag_var(CMAKE_CXX_FLAGS_COVERAGE)
configure_flag_var(CMAKE_C_FLAGS_RELWITHDEBINFO)
configure_flag_var(CMAKE_CXX_FLAGS_RELWITHDEBINFO)
configure_flag_var(CMAKE_C_FLAGS_RELEASE)
configure_flag_var(CMAKE_CXX_FLAGS_RELEASE)