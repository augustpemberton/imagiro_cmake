set (env_file "${PROJECT_SOURCE_DIR}/.env")
message ("Writing ENV file for CI: ${env_file}")

# the first call truncates, the rest append
file(WRITE  "${env_file}" "PROJECT_NAME=${ProjectName}\n")
file(APPEND  "${env_file}" "RESOURCE_NAME=\"${ResourceName}\"\n")
file(APPEND "${env_file}" "PLUGIN_NAME=\"${PluginName}\"\n")
file(APPEND  "${env_file}" "COMPANY_NAME=${CompanyName}\n")
file(APPEND "${env_file}" "VERSION=${CURRENT_VERSION}\n")
file(APPEND "${env_file}" "PRODUCT_SLUG=${ProductSlug}\n")
file(APPEND "${env_file}" "WRAPTOOL_ID=${WRAPTOOL_ID}\n")
