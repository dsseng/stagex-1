set -eux
. /env.sh
mkdir -p /build-gcc-${TARGET_ARCH}
cd /build-gcc-${TARGET_ARCH}
/gcc-${GCC_VERSION}/configure \
--prefix="" \
--exec-prefix="" \
--sbindir=/bin \
--libexecdir=/lib \
--datarootdir=/_tmp \
--target=${TARGET} \
--disable-multilib \
--disable-bootstrap \
--disable-assembly \
--disable-libmudflap \
--disable-libsanitizer \
--disable-gnu-indirect-function \
--disable-libmpx \
--disable-werror \
--enable-languages=c,c++ \
--enable-tls \
--enable-initfini-array \
--enable-libstdcxx-time=rt \
--enable-deterministic-archives \
--with-build-sysroot=${SYSROOT} \
--with-sysroot=/
make \
    -j$(nproc) \
    all-gcc
make \
    -j$(nproc) \
    enable_shared=no \
    all-target-libgcc
make \
    -j$(nproc) \
    DESTDIR="${SYSROOT}" \
    install-strip-gcc \
    install-strip-target-libgcc
