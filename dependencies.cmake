include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)
set(CPM_SOURCE_CACHE "${CMAKE_CURRENT_LIST_DIR}/cache/")

# JUCE, yaml-cpp, and Catch2
CPMAddPackage(
        NAME JUCE
        GITHUB_REPOSITORY juce-framework/JUCE
        GIT_TAG 8.0.3
        OPTIONS
        "JUCE_BUILD_EXAMPLES OFF" # Disable building examples
        "JUCE_BUILD_EXTRAS OFF"   # Disable building extras
        "JUCE_ENABLE_MODULE_SOURCE_GROUPS OFF" # Improve generation speed
)

CPMAddPackage(
        NAME yaml-cpp
        GITHUB_REPOSITORY jbeder/yaml-cpp
        GIT_TAG 0.8.0
        OPTIONS "YAML_CPP_BUILD_TESTS OFF"
)

CPMAddPackage(
        NAME Catch2
        GITHUB_REPOSITORY catchorg/Catch2
        GIT_TAG v3.4.0 # Use the desired version tag
        OPTIONS
        "CATCH_BUILD_TESTING OFF" # Disable building tests
        "CATCH_INSTALL_DOCS OFF"  # Disable installation of documentation
        "CATCH_INSTALL_HELPERS OFF" # Disable installation of helpers
)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_SHARED_LIBS OFF)
set(CPR_BUILD_SHARED_LIBS OFF)
set(CPR_USE_SYSTEM_CURL ON)

CPMAddPackage(
        NAME cpr
        GITHUB_REPOSITORY libcpr/cpr
        GIT_TAG 1.9.9
)

find_package(Boost REQUIRED COMPONENTS system)  # system is required for Beast

set(SHARED_DEPENDENCIES
        juce::juce_audio_utils
        juce::juce_dsp
        juce::juce_cryptography
        yaml-cpp
        cpr::cpr
        ${Boost_LIBRARIES}
#        imagiro_util
#        imagiro_processor
        "${ProjectName}Data"
)
