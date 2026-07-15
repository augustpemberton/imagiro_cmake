# JUCE-only: wires sources/deps onto the juce_add_plugin target. A no-op unless
# the project opted into JUCE (the ${ProjectName} target and juce:: deps only
# exist then).
if(NOT IMAGIRO_ENABLE_JUCE)
    return()
endif()

# Add .cpp source files
target_sources("${ProjectName}" PRIVATE "${PROJECT_SOURCES}")

# Setup binary data
file(GLOB binarydata_SRC ${BINARY_SOURCES})
if (binarydata_SRC)
    juce_add_binary_data("${ProjectName}Data" SOURCES ${binarydata_SRC})
    list(APPEND SHARED_DEPENDENCIES "${ProjectName}Data")
endif ()

target_include_directories("${ProjectName}" PUBLIC "${PROJECT_BINARY_DIR}")

target_include_directories("${ProjectName}" SYSTEM PUBLIC
        ${SHARED_INCLUDE_DIRS}
)


# Link dependencies
target_link_libraries("${ProjectName}" PRIVATE
        ${SHARED_DEPENDENCIES}
        PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_warning_flags
        juce::juce_recommended_lto_flags
)


# Setup unity build for everything except debug builds
set_target_properties("${ProjectName}" PROPERTIES
        UNITY_BUILD $<NOT:$<CONFIG:Debug>>
        UNITY_BUILD_BATCH_SIZE 16
)

# link against WinRT so we can manually check for windows text scaling
if (WIN32)
    target_link_libraries(${ProjectName} PRIVATE WindowsApp)
endif()

if(MSVC)
    set_target_properties(${ProjectName} PROPERTIES
            COMPILE_PDB_NAME ${ProjectName}
            COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/pdb"
    )
endif()