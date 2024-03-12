# pull in version
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/CMakeVersion.cmake)
set(Version ${CURRENT_VERSION})

if (BETA)
    set (PluginName "${PluginName} [beta]")
    add_compile_definitions(BETA)
endif()

add_compile_definitions(JUCE_SILENCE_XCODE_15_LINKER_WARNING)

# Define resource, project, company names, and version for use in the project
add_compile_definitions(
        RESOURCE_NAME="${ResourceName}"
        PROJECT_NAME="${PluginName}"
        COMPANY_NAME="${CompanyName}"
        PROJECT_ID="${PluginName}" # slug used for CI
        PROJECT_VERSION="${Version}"
        SRCPATH="${CMAKE_CURRENT_SOURCE_DIR}/src"
)

