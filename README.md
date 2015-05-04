# Compile Static Library for multiple Architectures
Simple bash script to compile a static library for multiple architectures (i.e simulator and device).


# Usage
- Simply move the `build.sh` file into the directory with your `.xcodeproj`, adjust the parameters on top of the file.
- Add all required architectures to your xcode project (xcode -> build settings -> valid architectures). For the device and simulator example, use `arm64 armv7 i386 x86_64`.
- Execute `./build.sh` in your terminal.
- Enjoy.

# License
Licensed under public domain (http://unlicense.org). No attribution or anything required, do whatever you want with this.
