set -eux
. /env.sh
cd /musl-${MUSL_VERSION}
make clean distclean
make \
    -j$(nproc) \
    ARCH="${TARGET_ARCH}" \
    prefix="" \
    DESTDIR="${SYSROOT}" \
    install-headers
