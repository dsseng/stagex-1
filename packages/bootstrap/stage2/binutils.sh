set -eux
. /env.sh
mkdir -p /build-binutils-${TARGET_ARCH}
cd /build-binutils-${TARGET_ARCH}
/binutils-${BINUTILS_VERSION}/configure \
    --target="${TARGET}" \
    --prefix="" \
    --exec-prefix="" \
    --sbindir=/bin \
    --libexecdir=/lib \
    --datarootdir=/_tmp \
    --with-sysroot=/ \
    --with-build-sysroot="${SYSROOT}" \
    --disable-nls \
    --disable-multilib \
    --disable-plugins \
    --disable-gprofng \
    --enable-64-bit-bfd \
    --enable-ld=default \
    --enable-install-libiberty \
    --enable-deterministic-archives
make \
    -j$(nproc) \
    all-binutils \
    all-gas \
    all-ld
make \
    -j$(nproc) \
    DESTDIR="${SYSROOT}" \
    install-strip-binutils \
    install-strip-gas \
    install-strip-ld
