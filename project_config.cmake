# pull in version
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/CMakeVersion.cmake)
set(Version ${CURRENT_VERSION})

if (BETA)
    set (ProjectName "${ProjectName}-beta")
    set (PluginName "${PluginName} [beta]")
    add_compile_definitions(BETA)
endif()

if (NOT DEFINED ProductSlug)
    set (ProductSlug ${ProjectName})
endif()

# Define resource, project, company names, and version for use in the project
add_compile_definitions(
        RESOURCE_NAME="${ResourceName}"
        PROJECT_NAME="${PluginName}"
        COMPANY_NAME="${CompanyName}"
        PROJECT_ID="${PluginName}" # slug used for CI
        PROJECT_VERSION="${Version}"
        SRCPATH="${CMAKE_CURRENT_SOURCE_DIR}/src"
)

