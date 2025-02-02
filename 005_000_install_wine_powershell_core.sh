#!/bin/bash

sudo_askpass="$(command -v ssh-askpass)"
export SUDO_ASKPASS="${sudo_askpass}"
export NO_AT_BRIDGE=1  # get rid of (ssh-askpass:25930): dbind-WARNING **: 18:46:12.019: Couldn't register with accessibility bus: Did not receive a reply.

export bitranox_debug_global="${bitranox_debug_global}"  # set to True for global Debug
export debug_lib_bash_wine="${debug_lib_bash_wine}"  # set to True for Debug in lib_bash_wine

# call the update script if nout sourced
if [[ "${0}" == "${BASH_SOURCE[0]}" ]] && [[ -d "${BASH_SOURCE%/*}" ]]; then "${BASH_SOURCE%/*}"/install_or_update.sh else "${PWD}"/install_or_update.sh ; fi


function update_myself {
    /usr/local/lib_bash_wine/install_or_update.sh "${@}" || exit 0              # exit old instance after updates
}


update_myself ${0}

function include_dependencies {
    source /usr/local/lib_bash/lib_color.sh
    source /usr/local/lib_bash/lib_retry.sh
    source /usr/local/lib_bash/lib_helpers.sh
    source /usr/local/lib_bash_wine/900_000_lib_bash_wine.sh
}

include_dependencies  # me need to do that via a function to have local scope of my_dir

function install_powershell_core {

    local linux_release_name=$(get_linux_release_name)                                  # @lib_bash/bash_helpers
    local wine_release=$(get_and_export_wine_release_from_environment_or_default_to_devel) # @lib_bash_wine
    local wine_prefix=$(get_and_export_wine_prefix_from_environment_or_default_to_home_wine)     # @lib_bash_wine
    local wine_arch=$(get_and_export_wine_arch_from_wine_prefix "${wine_prefix}")          # @lib_bash_wine
    local wine_version_number=$(get_wine_version_number)  # @lib_bash_wine

    local wine_drive_c_dir=${wine_prefix}/drive_c
    local decompress_dir=${HOME}/bitranox_decompress
    local powershell_install_dir="${wine_drive_c_dir}/Program Files/PowerShell"
    local powershell_version="6.0.4"        # 2019-07-15 - that is the last version that is working actually, V6.1.x and V6.2.x does not work
    local powershell_path_to_add="C:/Program Files/PowerShell"
    local str_32_or_64_bit=$(get_str_32_or_64_from_wine_prefix ${wine_prefix})          # returns "32" oder "64"
    local str_x86_or_x64=$(get_str_x86_or_x64_from_wine_prefix ${wine_prefix})      # returns "x86" oder "x64"

    local zip_file_name="PowerShell-${powershell_version}-win-${str_x86_or_x64}.zip"

    banner "Installing Powershell Core Version ${powershell_version}:${IFS}\
            ${IFS}linux_release_name=${linux_release_name}${IFS}\
            wine_release=${wine_release}${IFS}\
            wine_version=${wine_version_number}${IFS}\
            WINEPREFIX=${wine_prefix}${IFS}\
            WINEARCH=${wine_arch}${IFS}\
            ZIP=${zip_file_name}
            "

     rm -Rf "${powershell_install_dir}"
    mkdir -p "${powershell_install_dir}"

    clr_green "Download Powershell ${powershell_version} ${str_32_or_64_bit} Bit"

    retry_nofail wget -nv -c -nc --no-check-certificate -O "${decompress_dir}/${zip_file_name}" "https://github.com/PowerShell/PowerShell/releases/download/v${powershell_version}/${zip_file_name}"

    unzip -oqq "${decompress_dir}/${zip_file_name}" -d "${powershell_install_dir}"

    clr_green "Adding path to wine registry: ${powershell_path_to_add}"
    prepend_path_to_wine_registry_path "${wine_prefix}" "C:/Program Files/PowerShell"

     chmod -R 0755 "${powershell_install_dir}"

    banner "Test Powershell ${powershell_version}"
    wine pwsh -ExecutionPolicy unrestricted -Command "get-executionpolicy"
    banner "Finished installing Powershell Core:${IFS}linux_release_name=${linux_release_name}${IFS}wine_release=${wine_release}${IFS}wine_version=${wine_version_number}${IFS}WINEPREFIX=${wine_prefix}${IFS}WINEARCH=${wine_arch}${IFS}powershell_core_version=${powershell_version}"



}

if [[ "${0}" == "${BASH_SOURCE}" ]]; then    # if the script is not sourced
    install_powershell_core
fi



