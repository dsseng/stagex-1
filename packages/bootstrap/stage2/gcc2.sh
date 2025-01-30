set -eux
. /env.sh
mkdir -p /build-gcc-${TARGET_ARCH}
cd /build-gcc-${TARGET_ARCH}
make \
    -j $(nproc) \
    -C "${TARGET}/libgcc" \
    distclean
make \
    -j$(nproc) \
    enable_shared=yes \
    all-target-libgcc \
    all-target-libstdc++-v3
make \
    -j$(nproc) \
    DESTDIR="${SYSROOT}" \
    install-strip-target-libgcc \
    install-strip-target-libstdc++-v3
