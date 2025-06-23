#
#   This file is part of the OrangeFox Recovery Project
#   Copyright (C) 2021-2025 The OrangeFox Recovery Project
#
#   OrangeFox is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   any later version.
#
#   OrangeFox is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU General Public License for more details.
#
#   This software is released under GPL version 3 or any later version.
#   See <http://www.gnu.org/licenses/>.
#
#   Please maintain this if you use this script or any part of it
#

FDEVICE="sweet"

# Debugging (optional)
# set -o xtrace

fox_get_target_device() {
    local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
    if [ -n "$chkdev" ]; then 
        FOX_BUILD_DEVICE="$FDEVICE"
    else
        chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
        [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" ] && [ -z "$FOX_BUILD_DEVICE" ]; then
    fox_get_target_device
fi

if [ "$1" = "$FDEVICE" ] || [ "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

    # General Environment
    export LC_ALL="C"
    export TARGET_ARCH=arm64
    export ALLOW_MISSING_DEPENDENCIES=true
    export TW_DEFAULT_LANGUAGE="en"

    # Device
    export TARGET_DEVICE_ALT="sweetin"
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

    # Build Tools
    export FOX_USE_BASH_SHELL=1
    export FOX_ASH_IS_BASH=1
    export FOX_USE_NANO_EDITOR=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_SED_BINARY=1
    export FOX_USE_GREP_BINARY=1
    export FOX_USE_LZ4_BINARY=1
    export FOX_USE_ZSTD_BINARY=1
    export FOX_USE_XZ_UTILS=1
    export FOX_USE_DATE_BINARY=1
    export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-v29.0.zip

    # Features
    export FOX_ENABLE_APP_MANAGER=1
    export FOX_DELETE_AROMAFM=1
    export FOX_BUGGED_AOSP_ARB_WORKAROUND="1546300800"  # Jan 1, 2019 GMT
    export OF_ENABLE_LPTOOLS=1
    export OF_ENABLE_FS_COMPRESSION=1

    # Version Info
    export FOX_MAINTAINER_PATCH_VERSION=1
    export OF_MAINTAINER="galadriel"

    # OrangeFox-specific settings
    export OF_USE_GREEN_LED=0
    export OF_IGNORE_LOGICAL_MOUNT_ERRORS=1
    export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
    export OF_NO_MIUI_PATCH_WARNING=1
    export OF_UNBIND_SDCARD_F2FS=1
    export OF_QUICK_BACKUP_LIST="/boot;/data;"

    # AVB 2.0
    export OF_PATCH_AVB20=1

    # OTA Settings
    export OF_KEEP_DM_VERITY=1
    export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
    export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
    export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1

    # Splash image size (maximum in KB)
    export OF_SPLASH_MAX_SIZE=130

    # Screen settings
    export OF_SCREEN_H=2400
    export OF_STATUS_H=100
    export OF_STATUS_INDENT_LEFT=50
    export OF_STATUS_INDENT_RIGHT=50
    export OF_HIDE_NOTCH=1
    export OF_CLOCK_POS=1

else
    if [ -z "$FOX_BUILD_DEVICE" ] && [ -z "$BASH_SOURCE" ]; then
        echo "I: This script requires bash. Not processing the $FDEVICE $(basename $0)"
    fi
fi
