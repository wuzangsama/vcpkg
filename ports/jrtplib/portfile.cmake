set(JRTPLIB_VER "3.11.1")

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/fcsl/jrtplib-${JRTPLIB_VER}-edge/archive/v1.1.tar.gz"
    FILENAME "jrtplib-${JRTPLIB_VER}.tar.gz"
    SHA512 d43be9f6b200c822012ed8f61756bad463f84d5243e00eef44036c194ba0816259c4bd2e9a461d5b6e36d18e805fb5ec7d2308cc208c11b79d9c20fd796cfde9
)

vcpkg_extract_source_archive_ex(
    ARCHIVE ${ARCHIVE}
    OUT_SOURCE_PATH SOURCE_PATH
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DJRTPLIB_COMPILE_STATIC:BOOL=ON
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/JRTPLIB)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.MIT DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
