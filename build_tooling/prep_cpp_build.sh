#!/bin/bash

pushd $(realpath $(dirname $BASH_SOURCE))/../cpp/vcpkg

if [[ -e "$VCPKG_INSTALLATION_ROOT" ]] ; then
    git fetch --unshallow file://$VCPKG_INSTALLATION_ROOT
elif [[ -n "$VCPKG_INSTALLATION_ROOT" && -e "/host$VCPKG_INSTALLATION_ROOT" ]] ; then
    git fetch --unshallow file:///host$VCPKG_INSTALLATION_ROOT
else
    git fetch --unshallow origin master
fi

function windows_stuff() {
    if [[ -n "$GITHUB_ACTION" ]] ; then
        # Redirect the build directory to the more spacious C:
        pushd ..
        if [[ "$MSYSTEM" != MINGW* ]] ; then echo "Must run $0 with git/MINGW bash" >&2
        elif [[ -e out ]] ; then echo "out directory cannot exist at this point" >&2
        else
            mkdir "${ARCTIC_BUILD_DIR:?environment variable is not set}"
            MSYS=winsymlinks:nativestrict ln -s "${ARCTIC_BUILD_DIR}" out
        fi
        popd
    fi

    mkdir buildtrees packages ../out || true
    cmd.exe /C 'compact.exe /C buildtrees packages "..\\out"'
}

case `uname -a` in
*Microsoft*)
    # Are we in WSL to compile for Linux or is WSL bash merely used to run this script (parent process is `init`)?
    if ps -p $PPID | grep init ; then
        windows_stuff
    fi
    ;;
MINGW*)
    windows_stuff
esac

popd
