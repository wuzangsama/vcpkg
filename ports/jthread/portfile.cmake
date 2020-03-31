set(JTHREAD_VER "1.3.3")

vcpkg_download_distfile(ARCHIVE
    URLS "https://research.edm.uhasselt.be/jori/jthread/jthread-${JTHREAD_VER}.tar.gz"
    FILENAME "jthread-${JTHREAD_VER}.tar.gz"
    SHA512 d8d8a909ef165922fa65ab3a1679e8e510b9ebd5b7b9281f2b1229a2fcab6229cad2ffe2b9d9438b9b690f85c3789cf7b7bab6ddec82dd436ad1976674a39ae4
)

vcpkg_extract_source_archive_ex(
    ARCHIVE ${ARCHIVE}
    OUT_SOURCE_PATH SOURCE_PATH
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/JThread)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.MIT DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
