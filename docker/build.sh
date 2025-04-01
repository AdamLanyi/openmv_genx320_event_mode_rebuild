#!/bin/bash
set -e -x

git config --global --add safe.directory '*'
git submodule update --init --depth=1
make -C src -j$(nproc) TARGET=$TARGET submodules

# Build the firmware.
make -j$(nproc) -C src clean
make -j$(nproc) -C src/lib/micropython/mpy-cross
make -j$(nproc) -C src TARGET=$TARGET LLVM_PATH=/workspace/llvm/bin

rm -fr /workspace/build/$TARGET
mkdir -p /workspace/build/$TARGET
cp -r src/build/bin/* /workspace/build/$TARGET
