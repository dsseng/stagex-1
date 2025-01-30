set -eux
. /env.sh
mkdir -p ${SYSROOT}
cd ${SYSROOT}
mkdir -pv bin lib lib32 include usr "${TARGET}/bin"
ln -sfv bin lib lib32 include usr
cd ${SYSROOT}/${TARGET}
ln -sfv ../lib lib
ln -sfv ../lib32 lib32
ln -sfv ../include include
