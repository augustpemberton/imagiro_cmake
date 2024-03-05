include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)
set(CPM_SOURCE_CACHE "${CMAKE_CURRENT_LIST_DIR}/cache/")

# JUCE, yaml-cpp, and Catch2
CPMAddPackage("gh:juce-framework/JUCE#7.0.10")
CPMAddPackage("gh:jbeder/yaml-cpp#0.8.0")
CPMAddPackage("gh:catchorg/Catch2@3.4.0")

set(SHARED_DEPENDENCIES
        juce::juce_audio_utils
        juce::juce_dsp
        yaml-cpp
        imagiro_util
        imagiro_processor
        "${ProjectName}Data"
)

if (APPLE)
    list(APPEND SHARED_DEPENDENCIES "-framework Foundation")
endif()
