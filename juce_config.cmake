juce_add_plugin("${ProjectName}"
        ICON_BIG ${CMAKE_CURRENT_LIST_DIR}/../src/resources/icon-large.png
        ICON_SMALL ${CMAKE_CURRENT_LIST_DIR}/../src/resources/icon-small.png
        COMPANY_NAME "${CompanyName}"
        IS_SYNTH "${IsSynth}"
        NEEDS_MIDI_INPUT "${NeedsMidiInput}"
        COPY_PLUGIN_AFTER_BUILD TRUE
        PLUGIN_MANUFACTURER_CODE "${CompanyCode}"
        PLUGIN_CODE "${PluginCode}"
        FORMATS AU VST3 Standalone
        PRODUCT_NAME "${PluginName}"
        VST3_AUTO_MANIFEST TRUE)

target_compile_definitions("${ProjectName}"
        PUBLIC
        JUCE_WEB_BROWSER=0
        JUCE_USE_CURL=0
        JUCE_VST3_CAN_REPLACE_VST2=0
        JUCE_DISPLAY_SPLASH_SCREEN=0
        DONT_SET_USING_JUCE_NAMESPACE=1
)

option(JUCE_BUILD_EXTRAS "Build JUCE Extras" ON)
option(JUCE_BUILD_EXAMPLES "Build JUCE Examples" OFF)
