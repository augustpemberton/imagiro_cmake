include(${Catch2_SOURCE_DIR}/extras/Catch.cmake)

add_executable(${ProjectName}_Tests
        ${TEST_SOURCES})
set(_test_targets ${ProjectName}_Tests)

if(TEST_SOURCES_SLOW)
    add_executable(${ProjectName}_Tests_slow
            ${TEST_SOURCES_SLOW})
    list(APPEND _test_targets ${ProjectName}_Tests_slow)
endif()

foreach(_test_target IN LISTS _test_targets)
    target_link_libraries(${_test_target} PRIVATE
            ${TEST_DEPENDENCIES}
            Catch2::Catch2WithMain)

    target_include_directories(${_test_target} SYSTEM PUBLIC
            ${SHARED_INCLUDE_DIRS}
    )

    target_compile_definitions(${_test_target} PRIVATE $<TARGET_PROPERTY:${PROJECT_NAME},COMPILE_DEFINITIONS>)

    if(EXISTS "${CMAKE_SOURCE_DIR}/tests/tests_pch.hpp")
        target_precompile_headers(${_test_target} PRIVATE
                "$<$<COMPILE_LANGUAGE:CXX>:${CMAKE_SOURCE_DIR}/tests/tests_pch.hpp>")
    endif()

    catch_discover_tests(${_test_target} DISCOVERY_MODE PRE_TEST)
endforeach()
