#!/bin/bash

# General Config
TARGET="libcocos2d iOS"
PROJECT="cocos2d_libs.xcodeproj"
ACTION="build"
CONFIGURATION=Release

# SDK Config
DEVICE=iphoneos8.1
SIMULATOR=iphonesimulator8.1

# Output Config
OUT_FILE="libcocos2d iOS.a"
OUT_ROOT="Build"




#                          ,     \    /      ,
#                         / \    )\__/(     / \
#                        /   \  (_\  /_)   /   \
#     __________________/_____\__\@  @/___/_____\_________________
#     |                          |\../|                          |
#     |                           \VV/                           |
#     |                                                          |
#     |                      Here be dragons.                    |
#     |          DON'T TOUCH ANYTHING BEYOND THIS DRAGON         |
#     |                                                          |
#     |__________________________________________________________|
#                   |    /\ /      \\       \ /\    |
#                   |  /   V        ))       V   \  |
#                   |/     `       //        '     \|
#                   `              V                '
# Build output.
OUT_DEVICE="${OUT_ROOT}/Products/${CONFIGURATION}-iphoneos"
OUT_SIMULATOR="${OUT_ROOT}/Products/${CONFIGURATION}-iphonesimulator"
OUT_UNIVERSAL="${OUT_ROOT}/Products/${CONFIGURATION}-universal"

# BUILD PROCESS
xcodebuild -configuration $CONFIGURATION \
    -target "${TARGET}" \
    -sdk ${DEVICE} ${ACTION} \
    -project "${PROJECT}" \
    RUN_CLANG_STATIC_ANALYZER=NO \
    BUILD_DIR="${OUT_ROOT}/Products" \
    SYMROOT="${OUT_ROOT}/Intermediates"

xcodebuild -configuration $CONFIGURATION \
    -target "${TARGET}" \
    -sdk ${SIMULATOR} ${ACTION} \
    -project "${PROJECT}" \
    RUN_CLANG_STATIC_ANALYZER=NO \
    BUILD_DIR="${OUT_ROOT}/Products" \
    SYMROOT="${OUT_ROOT}/Intermediates"

# Remove old universal binaries, from previous builds.
rm -rf "${OUT_UNIVERSAL}" &>/dev/null
mkdir "${OUT_UNIVERSAL}" &>/dev/null

# Create universal binaries.
lipo -create -output "${OUT_UNIVERSAL}/${OUT_FILE}" \
    "${OUT_DEVICE}/${OUT_FILE}" \
    "${OUT_SIMULATOR}/${OUT_FILE}"

# Clean Up. Optional.
# rm -rf "${OUT_ROOT}/Intermediates"

# That's all it takes, folks.
