TERMUX_PKG_HOMEPAGE=https://github.com/Genymobile/scrcpy
TERMUX_PKG_DESCRIPTION="Scrcpy Dev (SDL3 Version)"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@twoj_nick"

# Wersja deweloperska - nadpisujemy, aby była 'najnowsza'
TERMUX_PKG_VERSION="3.4.0-dev-sdl3"

# Pobieramy kod z brancha master (który teraz używa SDL3)
TERMUX_PKG_SRCURL=https://github.com/Genymobile/scrcpy/archive/master.tar.gz
TERMUX_PKG_SHA256="SKIP_CHECKSUM"

TERMUX_PKG_AUTO_UPDATE=false

# KLUCZOWA ZMIANA: Zmieniamy sdl2 na libsdl3
# Usuwamy też sdl2-compat
TERMUX_PKG_DEPENDS="android-tools, ffmpeg, libusb, libsdl3"

# Usuwamy stare zabezpieczenia przed sdl2
TERMUX_PKG_ANTI_BUILD_DEPENDS="android-tools"

# Serwer: Nadal musimy "pożyczyć" najnowszy stabilny serwer, 
# chyba że masz własny plik .jar zbudowany ręcznie.
# UWAGA: Jeśli protokół w dev (SDL3) zmienił się drastycznie, 
# stary serwer v2.4/v3.x może nie zadziałać poprawnie.
LATEST_STABLE_SERVER="3.3.4"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dprebuilt_server=$TERMUX_PKG_SRCDIR/scrcpy-server-v${LATEST_STABLE_SERVER}
-Dcompile_server=false
-Dcompile_app=true
"

termux_step_post_get_source() {
    # Pobieranie serwera (workaround dla braku buildera Java w Termux Docker)
    local _server_ver="${LATEST_STABLE_SERVER}"
    local _url="https://github.com/Genymobile/scrcpy/releases/download/v${_server_ver}/scrcpy-server-v${_server_ver}"
    
    echo "Pobieranie serwera v${_server_ver}..."
    termux_download ${_url} $(basename ${_url}) SKIP_CHECKSUM
}
