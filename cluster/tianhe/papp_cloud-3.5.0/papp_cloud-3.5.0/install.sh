#!/bin/bash
# AUTHOR: WangHui <wanghui@paratera.com>
# updated: 07/11/2017
# created: 05/06/2016
# Description: A tool to install 、 update & remove papp_cloud on Linux or Drawin

readonly PROGNAME=$(basename $0)
readonly MATHINE_ARCH=$(uname -sm)
readonly INPUT_OPERA=$1
readonly BASHRC="${HOME}/.bashrc"
readonly BASHPROFILE="${HOME}/.bash_profile"
readonly ZSHRC="${HOME}/.zshrc"

readonly INSTALL_PATH="${HOME}/bin"
readonly PAPP_BIN="${INSTALL_PATH}/papp_cloud"
readonly PASSH_BIN="${INSTALL_PATH}/passh"
readonly PAPP_CONFIG_DIR="${HOME}/.config/papp_cloud"
readonly PAPP_OLD_BIN="${INSTALL_PATH}/papp_cli"

readonly SCRIPT_PATH=$(pwd)
readonly PAPP_LINUX_amd64="${SCRIPT_PATH}/papp_cloud_linux_amd64"
readonly PASSH_LINUX_amd64="${SCRIPT_PATH}/passh_linux_amd64"
readonly PAPP_LINUX_armv71="${SCRIPT_PATH}/papp_cloud_linux_armv7"
readonly PAPP_LINUX_32="${SCRIPT_PATH}/papp_cloud_linux_i686"
readonly PAPP_MAC_amd64="${SCRIPT_PATH}/papp_cloud_darwin_amd64"
readonly PASSH_MAC_amd64="${SCRIPT_PATH}/passh_darwin_amd64"
readonly PASSH_MAC_arm64="${SCRIPT_PATH}/passh_darwin_arm64"
readonly PAPP_MAC_arm64="${SCRIPT_PATH}/papp_cloud_darwin_arm64"
readonly PAPP_SCCS="${SCRIPT_PATH}/sccs.yml"

usage(){
    cat <<- EOF
Usage: $PROGNAME  [options]

OPTIONS:
     install       install papp_cloud
     remove        remove papp_cloud
     update        update papp_cloud

Examples:

    $PROGNAME  install
EOF
}

papp_install(){
    [[ -d $INSTALL_PATH ]] || mkdir -p $INSTALL_PATH
    [[ -d $PAPP_CONFIG_DIR ]] || mkdir -p $PAPP_CONFIG_DIR
    cp -f $PAPP_SCCS $PAPP_CONFIG_DIR

    case $SHELL in
        "/bin/bash" | "/usr/bin/bash" | "/bin/sh" | "/usr/bin/sh")
            echo -e "\033[32mSet 'PATH' successfully!\033[0m"
            grep '^export PATH' $BASHRC | grep "${INSTALL_PATH}" &>/dev/null
            MACHLINE1=$?
            grep '^export PATH' $BASHPROFILE | grep "${INSTALL_PATH}" &>/dev/null
            MACHLINE2=$?
            if [[ ${MACHLINE1} -ne 0 ]];then
                echo "export PATH=${INSTALL_PATH}:\$PATH" >> $BASHRC
            fi
            if [[ ${MACHLINE2} -ne 0 ]];then
                echo "export PATH=${INSTALL_PATH}:\$PATH" >> $BASHPROFILE
            fi
            ;;
        "/bin/zsh" | "/usr/bin/zsh")
            echo -e "\033[32mSet 'PATH' successfully!\033[0m"
            grep '^export PATH' $ZSHRC | grep ${INSTALL_PATH} &>/dev/null
            MACHLINE=$?
            if [[ MACHLINE -ne 0 ]];then
                echo "export PATH=${INSTALL_PATH}:\$PATH" >> $ZSHRC
            fi
            ;;
        *)
            echo -e "\033[31mFaild to set 'PATH'!\033[0m"
            echo -e "\033[31mShell: $SHELL\033[0m"
            exit 1
            ;;
    esac
    
    case $MATHINE_ARCH in
        "Linux x86_64")
            echo -e "\033[32mInstall succeeded!\033[0m"
            cp -f $PAPP_LINUX_amd64 $PAPP_BIN
            cp -f $PASSH_LINUX_amd64 $PASSH_BIN
            chmod +x $PAPP_BIN
            chmod +x $PASSH_BIN
            ;;
        "Linux i686")
            echo -e "\033[32mInstall succeeded!\033[0m"
            cp -f $PAPP_LINUX_32 $PAPP_BIN
            chmod +x $PAPP_BIN
            ;;
        "Linux arm64")
            echo -e "\033[32mInstall succeeded!\033[0m"
            cp -f $PAPP_LINUX_arm64 $PAPP_BIN
            chmod +x $PAPP_BIN
            ;;
        "Linux armv71")
            echo -e "\033[32mInstall succeeded!\033[0m"
            cp -f $PAPP_LINUX_armv71 $PAPP_BIN
            chmod +x $PAPP_BIN
            ;;
        "Darwin x86_64")
            echo -e "\033[32mInstall succeeded!\033[0m"
            cp -f $PAPP_MAC_amd64 $PAPP_BIN
            cp -f $PASSH_MAC_amd64 $PASSH_BIN
            chmod +x $PAPP_BIN
            chmod +x $PASSH_BIN
            ;;
        "Darwin arm64")
            echo -e "\033[32mInstall succeeded!\033[0m"
            cp -f $PAPP_MAC_arm64 $PAPP_BIN
            cp -f $PASSH_MAC_arm64 $PASSH_BIN
            chmod +x $PAPP_BIN
            chmod +x $PASSH_BIN
            ;;
        *)
            echo -e "\033[31mInstall Failed!\033[0m"
            echo -e "\033[31mTarget system OS not supported!\033[0m"
            exit 1
            ;;
    esac
    $SHELL
}

papp_remove(){
    if [[ -e "${PAPP_BIN}" ]]; then
        echo -e "\033[32mRemove succeeded!\033[0m"
        rm -f $PAPP_BIN &> /dev/null
        rm -f $PASSH_BIN &> /dev/null
        rm -f $PAPP_OLD_BIN &> /dev/null
    else
         echo -e "\033[31mpapp_cloud is not exsists!\033[0m"
    fi
}

case $INPUT_OPERA in
    install)
        papp_install
        ;;
    remove)
        papp_remove
        ;;
    update)
        papp_remove
        papp_install
        ;;
    *)
        usage
        ;;
esac
