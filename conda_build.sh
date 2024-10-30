
## Start of bash preamble
if [ -z ${CONDA_BUILD+x} ]; then
    source /home/ihuicatl/Repos/Packaging/emscripten-forge-recipes/output/bld/rattler-build_r-base_1729252420/work/build_env.sh
fi
# enable debug mode for the rest of the script
## End of preamble

#!/bin/bash

set -eux

export RUN_CONFIGURE=false

export PREFIX="/home/ihuicatl/Repos/Xeus/xeus-r-lite/host-env"

# Skip non-working checks
export r_cv_header_zlib_h=yes
export r_cv_have_bzlib=yes
export r_cv_have_lzma=yes
export r_cv_have_pcre2utf=yes
export r_cv_size_max=yes

# Not supported
export ac_cv_have_decl_getrusage=no
export ac_cv_have_decl_getrlimit=no
export ac_cv_have_decl_sigaltstack=no
export ac_cv_have_decl_wcsftime=no
export ac_cv_have_decl_umask=no

export ac_cv_have_decl_sched_getaffinity=no
export ac_cv_have_decl_sched_setaffinity=no
# export ac_cv_have_decl_sched_cpucount=no

# SIDE_MODULE + pthread is experimental, and pthread_kill is not implemented
export r_cv_search_pthread_kill=no

export OBJDUMP=llvm-objdump

# Otherwise set to .not_implemented and cannot be used
export SHLIB_EXT=".so"

# mkdir -p _build
# cp $RECIPE_DIR/config.site _build/config.site
cd _build

# NOTE: the host and build systems are explicitly set to enable the cross-
# compiling options even though it's not fully supported.
# Otherwise, it assumes it's not cross-compiling.
if [ "$RUN_CONFIGURE" = true ]; then
    echo "😈😈😈 Configuring"
    emconfigure ../configure \
        --prefix=$PREFIX    \
        --build="x86_64-conda-linux-gnu" \
        --host="wasm32-unknown-emscripten" \
        --enable-R-static-lib \
        --without-readline  \
        --without-x         \
        --enable-java=no \
        --enable-R-profiling=no \
        --enable-byte-compiled-packages=no \
        --disable-rpath \
        --disable-openmp \
        --disable-nls \
        --with-internal-tzcode \
        --with-recommended-packages=no

    # NOTE: Remove the -lFortranRuntime from the FLIBS to avoid double-linking
    # when creating the R binary
    echo "FLIBS =" >> Makeconf
fi

echo "😈😈😈 Building"
# emmake make clean
emmake make -j1 VERBOSE=1
echo "😈😈😈 Installing"
emmake make install

# FIXME: The database files for the internal modules are installed in a "help"
# directory, this copies them to the expected location. It also helps avoid
# packaging r-base files in other R packages when using cross-r-base.
pushd $PREFIX/lib/R/library
    for pkg in $(ls); do
        if [ "$pkg" == "datasets" ]; then
            cp -n ${BUILD_PREFIX}/lib/R/library/$pkg/data/* $pkg/data/
        elif [ -d $pkg/help ]; then
            cp -n $pkg/help/$pkg.rd* $pkg/R/
        fi
    done
popd

# Manually copying .wasm files
cp src/main/R.* $PREFIX/lib/R/bin/exec/
cp src/unix/Rscript.wasm $PREFIX/lib/R/bin/
