TERMUX_PKG_HOMEPAGE=https://github.com/Genymobile/scrcpy
TERMUX_PKG_DESCRIPTION="Scrcpy Dev (SDL3)"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@twoj_nick"
TERMUX_PKG_VERSION="3.4.0-dev"
TERMUX_PKG_SRCURL=https://github.com/Genymobile/scrcpy/archive/master.tar.gz
TERMUX_PKG_SHA256="SKIP_CHECKSUM"
TERMUX_PKG_AUTO_UPDATE=false

# TU BYŁ BŁĄD. Teraz jest poprawnie:
TERMUX_PKG_DEPENDS="android-tools, ffmpeg, libusb, sdl3"

TERMUX_PKG_ANTI_BUILD_DEPENDS="android-tools, sdl2, sdl2-compat"

LATEST_STABLE_SERVER="3.3.4"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dprebuilt_server=$TERMUX_PKG_SRCDIR/scrcpy-server-v${LATEST_STABLE_SERVER}
-Dcompile_server=false
-Dcompile_app=true
"

termux_step_post_get_source() {
    local _url="https://github.com/Genymobile/scrcpy/releases/download/v${LATEST_STABLE_SERVER}/scrcpy-server-v${LATEST_STABLE_SERVER}"
    termux_download ${_url} $(basename ${_url}) SKIP_CHECKSUM
}
