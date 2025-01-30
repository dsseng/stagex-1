set -eux
. /env.sh
mkdir -p /rootfs/${SYSROOT}
cd /rootfs/${SYSROOT}
mv ${SYSROOT}/* .
mkdir -p /rootfs/usr/bin
for bin_path in $(find bin -name ${TARGET}-*); do
    bin_name=$(basename "$bin_path")
    ln -s ${SYSROOT}/bin/${bin_name} /rootfs/usr/bin/${bin_name}
done
