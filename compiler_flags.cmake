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

# -O3/-O2 is fine everywhere (incl. third-party deps).
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    add_compile_options("$<$<NOT:$<CONFIG:Debug>>:-O3>")
elseif(MSVC)
    add_compile_options("$<$<NOT:$<CONFIG:Debug>>:/O2>")
endif()

# Fast-math belongs ONLY on our DSP, not on dependencies (fmt/visage/clap-
# wrapper have no reason to want it, and it breaks fmt's inf constant). Our
# DSP targets link this INTERFACE target to opt in. -fno-finite-math-only
# keeps the speed but lets inf/NaN exist (our DSP can produce them).
if(NOT TARGET imagiro_fastmath)
    add_library(imagiro_fastmath INTERFACE)
    target_compile_options(imagiro_fastmath INTERFACE
            "$<$<AND:$<NOT:$<CONFIG:Debug>>,$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>>:-ffast-math;-fno-finite-math-only;-ffp-contract=fast>"
            "$<$<AND:$<NOT:$<CONFIG:Debug>>,$<CXX_COMPILER_ID:MSVC>>:/fp:fast>")
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
