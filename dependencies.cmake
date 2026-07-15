include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)

# JUCE is strictly opt-in. Plugins that ship a JUCE-hosted shell set
# IMAGIRO_ENABLE_JUCE before including this; CLAP-first plugins leave it off and
# nothing here references a juce:: target or pulls a JUCE-specific config file.
option(IMAGIRO_ENABLE_JUCE "Fetch JUCE and build the JUCE plugin shell" OFF)

if(IMAGIRO_ENABLE_JUCE)
    CPMAddPackage(
            NAME JUCE
            GITHUB_REPOSITORY juce-framework/JUCE
            GIT_TAG 8.0.10
            OPTIONS
            "JUCE_BUILD_EXAMPLES OFF" # Disable building examples
            "JUCE_BUILD_EXTRAS OFF"   # Disable building extras
            "JUCE_ENABLE_MODULE_SOURCE_GROUPS OFF" # Improve generation speed
    )
endif()

CPMAddPackage(
        NAME Catch2
        GITHUB_REPOSITORY catchorg/Catch2
        GIT_TAG v3.4.0 # Use the desired version tag
        OPTIONS
        "CATCH_BUILD_TESTING OFF" # Disable building tests
        "CATCH_INSTALL_DOCS OFF"  # Disable installation of documentation
        "CATCH_INSTALL_HELPERS OFF" # Disable installation of helpers
)

set(SHARED_INCLUDE_DIRS)

set(SHARED_DEPENDENCIES
        timestamp
)

if(IMAGIRO_ENABLE_JUCE)
    list(APPEND SHARED_DEPENDENCIES
            juce::juce_audio_utils
            juce::juce_dsp
            juce::juce_cryptography
    )
endif()
