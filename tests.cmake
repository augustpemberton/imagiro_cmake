include(${Catch2_SOURCE_DIR}/extras/Catch.cmake)

add_executable(${ProjectName}_Tests
        tests/main.cpp)

target_link_libraries(${ProjectName}_Tests PRIVATE
        ${SHARED_DEPENDENCIES}
        Catch2::Catch2WithMain)

target_include_directories(${ProjectName}_Tests SYSTEM PUBLIC
        ${SHARED_INCLUDE_DIRS}
)

catch_discover_tests(${ProjectName}_Tests)
target_compile_definitions(${ProjectName}_Tests PRIVATE $<TARGET_PROPERTY:${PROJECT_NAME},COMPILE_DEFINITIONS>)
