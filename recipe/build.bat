set "CRT_TESTS=OFF"
if "%target_platform%" == "win-arm64" set "CRT_TESTS=ON"

mkdir "%SRC_DIR%"\build
pushd "%SRC_DIR%"\build

cmake -G "Ninja" ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      -DCMAKE_INSTALL_LIBDIR=lib ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DBUILD_SHARED_LIBS=ON ^
      -DBUILD_DEPS=OFF ^
      -DBUILD_TESTING=%CRT_TESTS% ^
      -DENABLE_NET_TESTS=OFF ^
      ..
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1

if "%target_platform%" == "win-arm64" (
    set "PATH=%CD%;%LIBRARY_BIN%;%PATH%"
    ctest --output-on-failure -C Release
    if errorlevel 1 exit /b 1
)
