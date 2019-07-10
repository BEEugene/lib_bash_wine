#!/bin/bash

function include_dependencies {
    local my_dir="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"  # this gives the full path, even for sourced scripts
    source "${my_dir}/install_lib_bash.sh"
    source "${my_dir}/lib_bash/lib_color.sh"
    source "${my_dir}/lib_bash/lib_retry.sh"
    source "${my_dir}/lib_bash/lib_helpers.sh"
    source "${my_dir}/lib_wine.sh"
}

include_dependencies  # we need to do that via a function to have local scope of my_dir

# if used outside github/travis You need to set :
# WINEARCH=win32    for 32 Bit Wine
# WINEARCH=         for 64 Bit Wine
# WINEPREFIX defaults to ${HOME}/.wine   or you need to pass it via environment variable

# if running headless, the xvfb service needs to run

banner "Install Git Portable"
get_and_export_wine_prefix_or_default_to_home_wine  # @lib_bash_wine
get_and_export_wine_arch_or_default_to_win64        # @lib_bash_wine

wine_drive_c_dir=${WINEPREFIX}/drive_c
decompress_dir=${HOME}/bitranox_decompress
mkdir -p ${decompress_dir}

clr_green "Download Git Portable Binaries"
retry sudo wget -nc --no-check-certificate -O ${decompress_dir}/binaries_portable_git-master.zip https://github.com/bitranox/binaries_portable_git/archive/master.zip

clr_green "Unzip Git Portable Binaries Master to ${decompress_dir}"
unzip -nqq ${decompress_dir}/binaries_portable_git-master.zip -d ${decompress_dir}

if [[ "${WINEARCH}" == "win32" ]]
    then
        clr_green "Joining Multipart Zip in ${decompress_dir}/binaries_portable_git-master/bin"
        cat ${decompress_dir}/binaries_portable_git-master/bin/PortableGit32* > ${decompress_dir}/binaries_portable_git-master/bin/joined_PortableGit.zip
        add_git_path="c:/PortableGit32/cmd"
    else
        clr_green "Joining Multipart Zip in ${decompress_dir}/binaries_portable_git-master/bin"
        cat ${decompress_dir}/binaries_portable_git-master/bin/PortableGit64* > ${decompress_dir}/binaries_portable_git-master/bin/joined_PortableGit.zip
        add_git_path="c:/PortableGit64/cmd"
    fi

clr_green "Unzip Git Portable Binaries to ${wine_drive_c_dir}"
unzip -qq ${decompress_dir}/binaries_portable_git-master/bin/joined_PortableGit.zip -d ${wine_drive_c_dir}

prepend_path_to_wine_registry ${add_git_path}

banner "FINISHED installing Git Portable on Wine Machine ${WINEPREFIX}"

