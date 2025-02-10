# Windows configuration
if (WIN32)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    add_compile_options(/EHsc /bigobj)
    add_compile_definitions(NOMINMAX WIN32_LEAN_AND_MEAN)
    add_compile_definitions(WINRT_LEAN_AND_MEAN)

    add_compile_options(/await)
    set(CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION 10.0)

    # Enable PDB generation for both Debug and Release builds
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /Zi")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Zi")

    # Ensure the linker generates PDB files
    set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE} /DEBUG /OPT:REF /OPT:ICF")
    set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG} /DEBUG")

    # Set PDB output directory
    set(CMAKE_PDB_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/pdb")
endif()

# macOS and iOS configuration
if(APPLE)
    # Check if we're building for iOS
    if(CMAKE_SYSTEM_NAME STREQUAL "iOS")
        # iOS specific settings
        set(CMAKE_OSX_DEPLOYMENT_TARGET "12.0" CACHE STRING "Minimum iOS deployment version" FORCE)
        set(CMAKE_OSX_ARCHITECTURES "arm64" CACHE STRING "Architectures" FORCE)
    else()
        # macOS specific settings
        set(CMAKE_OSX_DEPLOYMENT_TARGET "10.15" CACHE STRING "Minimum macOS deployment version" FORCE)
        set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE STRING "Architectures" FORCE)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Xlinker -headerpad -Xlinker 578")
    endif()
endif()

cmake_policy(SET CMP0069 NEW)
set(CMAKE_POLICY_DEFAULT_CMP0069 NEW)

#if(CMAKE_BUILD_TYPE STREQUAL "Release")
#    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)
#endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-dev")
endif()

#if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
#    add_compile_options($<$<CONFIG:Release>:-ffast-math>)
#endif()
