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
# WINEARCH=""       for 64 Bit Wine
# WINEPREFIX defaults to ${HOME}/.wine   or you need to pass it via environment variable

# if running headless, the xvfb service needs to run

banner "Install Python 3.7 on WINE"
get_and_export_wine_prefix_or_default_to_home_wine  # @lib_bash_wine
get_and_export_wine_arch_or_default_to_win64        # @lib_bash_wine


wine_drive_c_dir=${WINEPREFIX}/drive_c
decompress_dir=${HOME}/bitranox_decompress
mkdir -p ${decompress_dir}

python_version_short=python37
python_version_doc="Python 3.7"

clr_green "Download ${python_version_doc} Binaries from https://github.com/bitranox/binaries_${python_version_short}_wine/archive/master.zip"
retry sudo wget -nc --no-check-certificate -O ${decompress_dir}/binaries_${python_version_short}_wine-master.zip https://github.com/bitranox/binaries_${python_version_short}_wine/archive/master.zip

clr_green "Unzip ${python_version_doc} Master to ${HOME}"
unzip -nqq ${decompress_dir}/binaries_${python_version_short}_wine-master.zip -d ${decompress_dir}

if [[ "${WINEARCH}" == "win32" ]]
    then
        clr_green "Joining Multipart Zip in ${decompress_dir}/binaries_${python_version_short}_wine-master/bin"
        cat ${decompress_dir}/binaries_${python_version_short}_wine-master/bin/python*_wine_32* > ${decompress_dir}/binaries_${python_version_short}_wine-master/bin/joined_${python_version_short}.zip
        add_pythonpath="c:/Python37-32;c:/Python37-32/Scripts"
    else
        clr_green "Joining Multipart Zip in ${decompress_dir}/binaries_${python_version_short}_wine-master/bin"
        cat ${decompress_dir}/binaries_${python_version_short}_wine-master/bin/python*_wine_64* > ${decompress_dir}/binaries_${python_version_short}_wine-master/bin/joined_${python_version_short}.zip
        add_pythonpath="c:/Python37-64;c:/Python37-64/Scripts"
    fi

clr_green "Unzip ${python_version_doc} to ${wine_drive_c_dir}"
unzip -qq ${decompress_dir}/binaries_${python_version_short}_wine-master/bin/joined_${python_version_short}.zip -d ${wine_drive_c_dir}

prepend_path_to_wine_registry ${add_pythonpath}


banner "FINISHED installing Python 3.7 on Wine Machine ${WINEPREFIX}"
