set -eux
. /env.sh
cp -r /linux-${LINUX_VERSION} /linux-build-${TARGET_ARCH}
cd /linux-build-${TARGET_ARCH}
set -eux
make -j$(nproc) ARCH="$(echo ${TARGET_ARCH} | sed 's/aarch64/arm64/')" headers
find usr/include ! -name '*.h' -type f -delete
cp -af usr/include "${SYSROOT}/usr"
cp -Rv usr/include/* "${SYSROOT}/include/"
rm -rf "${SYSROOT}/_tmp"
