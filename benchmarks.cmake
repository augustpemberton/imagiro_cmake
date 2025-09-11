file(GLOB_RECURSE BenchmarkFiles CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/benchmarks/*.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/benchmarks/*.h")

add_executable(${ProjectName}_Benchmarks ${BenchmarkFiles})
target_compile_features(${ProjectName}_Benchmarks PRIVATE cxx_std_20)

target_link_libraries(${ProjectName}_Benchmarks PRIVATE
        ${SHARED_DEPENDENCIES})

target_include_directories("${ProjectName}_Benchmarks" SYSTEM PUBLIC
        ${SHARED_INCLUDE_DIRS}
)

target_compile_definitions(${ProjectName}_Benchmarks PRIVATE $<TARGET_PROPERTY:${PROJECT_NAME},COMPILE_DEFINITIONS>)
