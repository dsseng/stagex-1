set -eux
. /env.sh
mkdir -p /build-musl-${TARGET_ARCH}
cd /build-musl-${TARGET_ARCH}
ARCH="${TARGET_ARCH}" \
CC="${TARGET}-gcc" \
CROSS_COMPILE="${TARGET}-" \
LIBCC="${SYSROOT}/lib/gcc/${TARGET}/${GCC_VERSION}/libgcc.a" \
/musl-${MUSL_VERSION}/configure \
    --host="${TARGET}" \
    --prefix="" \
    --disable-wrapper
make \
    -j$(nproc) \
    AR="${TARGET}-ar" \
    RANLIB="${TARGET}-ranlib"
make \
    -j$(nproc) \
    AR="${TARGET}-ar" \
    RANLIB="${TARGET}-ranlib" \
    DESTDIR="${SYSROOT}" \
    install-libs
rm -f "${SYSROOT}"/lib/ld-musl-${TARGET_ARCH}.so.1
cp -af \
    "${SYSROOT}/usr/lib/libc.so" \
    "${SYSROOT}/lib/ld-musl-${TARGET_ARCH}.so.1"
