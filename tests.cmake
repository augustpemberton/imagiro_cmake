include(${Catch2_SOURCE_DIR}/extras/Catch.cmake)

add_executable(${ProjectName}_Tests
        tests/main.cpp)

target_link_libraries(${ProjectName}_Tests PRIVATE
        ${SHARED_DEPENDENCIES}
        Catch2::Catch2WithMain)

catch_discover_tests(${ProjectName}_Tests)
