set(LIBEXOSIP2_VER "5.1.0")

vcpkg_download_distfile(ARCHIVE
    URLS "https://download.savannah.nongnu.org/releases/exosip/libexosip2-${LIBEXOSIP2_VER}.tar.gz"
    FILENAME "libexosip2-${LIBEXOSIP2_VER}.tar.gz"
    SHA512 9ffddaaf9f62839b8aa1642a5b821d12e7e4d34097f92bcc9c90cabb97200e6a8faa2f0c9a62270f9b4b3ea783a90468e8491b1d5f834b335b4522b524496a19
)

vcpkg_extract_source_archive_ex(
    ARCHIVE ${ARCHIVE}
    OUT_SOURCE_PATH SOURCE_PATH
)

vcpkg_configure_make(
    SOURCE_PATH ${SOURCE_PATH}
    NO_DEBUG
    AUTO_HOST
    AUTO_DST
    PRERUN_SHELL autogen.sh
    OPTIONS
        OSIP_CFLAGS="-I${CURRENT_INSTALLED_DIR}/include"   
        OSIP_LIBS="-L${CURRENT_INSTALLED_DIR}/lib -losip2 -losipparser2"
        --enable-shared=no
        # --with-gnu-ld=yes
        --enable-openssl=no
)

vcpkg_install_make()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(GLOB_RECURSE LIBEXOSIP2_BINARIES ${CURRENT_PACKAGES_DIR}/lib *.so)
foreach(LIBEXOSIP2_BINARY LIBEXOSIP2_BINARIES)
    if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
        file(COPY ${LIBEXOSIP2_BINARY} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
    endif()
    file(REMOVE ${LIBEXOSIP2_BINARY})
endforeach()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
