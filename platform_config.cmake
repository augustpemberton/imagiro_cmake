# Windows configuration
if (WIN32)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    add_compile_options(/EHsc /bigobj)
    add_compile_definitions(NOMINMAX WIN32_LEAN_AND_MEAN)
    add_compile_definitions(WINRT_LEAN_AND_MEAN)

    add_compile_options(/await)
    set(CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION 10.0)
endif()

# macOS configuration
if(APPLE)
    set (CMAKE_OSX_DEPLOYMENT_TARGET "10.13" CACHE STRING "Minimum OS X deployment version" FORCE)
    set (CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE STRING "Architectures" FORCE)
endif()

cmake_policy(SET CMP0069 NEW)
set(CMAKE_POLICY_DEFAULT_CMP0069 NEW)

if(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-dev")
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    add_compile_options($<$<CONFIG:Release>:-ffast-math>)
endif()
