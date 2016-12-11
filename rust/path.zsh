TOOLCHAIN=`rustup show|sed -n 's/^\(.\+\) (default)$/\1/p'`

export RUST_SRC_PATH=$HOME/.multirust/toolchains/$TOOLCHAIN/lib/rustlib/src/rust/src/
export PATH=$PATH:$HOME/.cargo/bin

unset TOOLCHAIN
