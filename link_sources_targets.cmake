# Add .cpp source files
target_sources("${ProjectName}" PRIVATE "${PROJECT_SOURCES}")

# Setup binary data
file(GLOB binarydata_SRC
        "${BINARY_SOURCES}"
        "${CMAKE_CURRENT_LIST_DIR}/../src/ui/dist/*.*"
        "${CMAKE_CURRENT_LIST_DIR}/../src/ui/dist/assets/*.*"
        "${CMAKE_CURRENT_LIST_DIR}/../src/ui/dist/fonts/*.*"
        "${CMAKE_CURRENT_LIST_DIR}/../src/Parameters.yaml"
)
juce_add_binary_data("${ProjectName}Data" SOURCES ${binarydata_SRC} )
target_include_directories("${ProjectName}" PUBLIC "${PROJECT_BINARY_DIR}")

# Link dependencies
target_link_libraries("${ProjectName}" PRIVATE
        ${SHARED_DEPENDENCIES}
        timestamp
        PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags
        juce::juce_recommended_warning_flags)

# Setup unity build
set_target_properties("${ProjectName}" PROPERTIES UNITY_BUILD ON)

file(GLOB_RECURSE JUCE_SOURCES CONFIGURE_DEPENDS
        "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cache/*.cpp"
        "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cache/*.mm"
        "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cache/*.r"
        "${CMAKE_CURRENT_SOURCE_DIR}/modules/*.cpp"
        "${CMAKE_CURRENT_SOURCE_DIR}/modules/*.mm"
        "${CMAKE_CURRENT_SOURCE_DIR}/modules/*.r")

set_source_files_properties(${JUCE_SOURCES} PROPERTIES SKIP_PRECOMPILE_HEADERS TRUE SKIP_UNITY_BUILD_INCLUSION TRUE)

