# Compiler-conditional flags. Must be included AFTER project() —
# CMAKE_CXX_COMPILER_ID is empty before it, and every branch below
# silently no-ops (this bit us: -mf16c and the Release -O3/-ffast-math
# block never applied on Linux).

# Cache compiles when ccache is present (opt-out with -DUSE_CCACHE=OFF).
if(NOT DEFINED USE_CCACHE)
    set(USE_CCACHE ON)
endif()
if(USE_CCACHE AND NOT CMAKE_CXX_COMPILER_LAUNCHER)
    find_program(CCACHE_EXECUTABLE ccache)
    if(CCACHE_EXECUTABLE)
        set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_EXECUTABLE}" CACHE STRING "" FORCE)
        set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_EXECUTABLE}" CACHE STRING "" FORCE)
    endif()
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64|AMD64")
        add_compile_options(-mf16c)
    endif()
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    add_compile_options("$<$<NOT:$<CONFIG:Debug>>:-O3;-ffast-math;-ffp-contract=fast>")
elseif(MSVC)
    add_compile_options("$<$<NOT:$<CONFIG:Debug>>:/O2;/fp:fast>")
endif()

# Fast linker for iteration builds when available
if(NOT APPLE AND NOT WIN32 AND NOT EMSCRIPTEN)
    find_program(MOLD_EXECUTABLE mold)
    if(MOLD_EXECUTABLE)
        add_link_options(-fuse-ld=mold)
    else()
        find_program(LLD_EXECUTABLE ld.lld)
        if(LLD_EXECUTABLE)
            add_link_options(-fuse-ld=lld)
        endif()
    endif()
elseif(APPLE)
    find_program(LLD64_EXECUTABLE ld64.lld)
    if(LLD64_EXECUTABLE AND CMAKE_BUILD_TYPE STREQUAL "Debug")
        add_link_options(-fuse-ld=lld)
    endif()
endif()
