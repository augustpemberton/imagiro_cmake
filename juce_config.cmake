if(DEFINED ENV{COPY_PLUGIN_AFTER_BUILD})
    set(SHOULD_COPY_PLUGIN $ENV{COPY_PLUGIN_AFTER_BUILD})
else()
    set(SHOULD_COPY_PLUGIN TRUE)
endif()

if (NOT DEFINED USE_VST3_MANIFEST)
    set(USE_VST3_MANIFEST TRUE)
endif()

if (NOT DEFINED USE_WEBVIEW)
    set(USE_WEBVIEW TRUE)
endif()

if(${USE_WEBVIEW})
    set(USE_WEBVIEW_NUM 1)
else()
    set(USE_WEBVIEW_NUM 0)
endif()

juce_add_plugin("${ProjectName}"
        ICON_BIG ${CMAKE_CURRENT_LIST_DIR}/../resources/icon-large.png
        ICON_SMALL ${CMAKE_CURRENT_LIST_DIR}/../resources/icon-small.png
        COMPANY_NAME "${CompanyName}"
        IS_SYNTH "${IsSynth}"
        NEEDS_MIDI_INPUT "${NeedsMidiInput}"
        COPY_PLUGIN_AFTER_BUILD ${SHOULD_COPY_PLUGIN}
        PLUGIN_MANUFACTURER_CODE "${CompanyCode}"
        PLUGIN_CODE "${PluginCode}"
        FORMATS AU VST3 Standalone AAX AUv3
        PRODUCT_NAME "${PluginName}"
        LV2URI https://imagi.ro/piano
        NEEDS_WEBVIEW2 "${USE_WEBVIEW}"
        VST3_AUTO_MANIFEST ${USE_VST3_MANIFEST})

target_compile_definitions("${ProjectName}"
        PUBLIC
        JUCE_WEB_BROWSER=${USE_WEBVIEW_NUM}
        JUCE_USE_WIN_WEBVIEW2_WITH_STATIC_LINKING=0
        JUCE_USE_CURL=0
        JUCE_VST3_CAN_REPLACE_VST2=0
        DONT_SET_USING_JUCE_NAMESPACE=1
)

option(JUCE_BUILD_EXTRAS "Build JUCE Extras" ON)
option(JUCE_BUILD_EXAMPLES "Build JUCE Examples" OFF)
