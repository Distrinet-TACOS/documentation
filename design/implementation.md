# Implementation into OP-TEE OS

As shown in the figures in the previous sections, both loadable kernel modules and pseudo trusted applications are part of the architecture and thus they all need to be compiled. This requires multiple compile commands in different directories. These commands need to be executed in order (for QEMU):

1. Init repo with the right manifest in the project root directory:

    ``` sh
    mkdir -p <project-dir>
    cd <project-dir>
    repo init -u https://github.com/Distrinet-TACOS/manifest.git -m tacos-qemu-driver.xml
    repo sync -j4 --no-clone-bundle
    ```

2. In `<project-dir>/build/`:

    ``` sh
    make CFG_CORE_ASLR=n GDBSERVER=y -j`nproc`
    ```

3. In `<project-dir>/optee_client/`:

    ``` sh
    make
    ```

4. In `<project-dir>/optee_os/`:

    ``` sh
    make \
        CFG_TEE_BENCHMARK=n \
        CFG_TEE_CORE_LOG_LEVEL=3 \
        CROSS_COMPILE=arm-linux-gnueabihf- \
        CROSS_COMPILE_core=arm-linux-gnueabihf- \
        CROSS_COMPILE_ta_arm32=arm-linux-gnueabihf- \
        CROSS_COMPILE_ta_arm64=aarch64-linux-gnu- \
        DEBUG=1 \
        O=out/arm \
        PLATFORM=vexpress-qemu_virt
    ```

5. In `<project-dir>/optee_examples/`:

    ``` sh
    make \
        --no-builtin-variables \
        TA_DEV_KIT_DIR=<project-dir>/optee_os/out/arm/export-ta_arm32/ \
        CROSS_COMPILE=arm-linux-gnueabihf- \
        TEEC_EXPORT=<project-dir>/optee_client/out/export/usr \
        PLATFORM=vexpress-qemu_virt \
        HOST_CROSS_COMPILE=<project-dir>/toolchains/aarch32/bin/arm-linux-gnueabihf-
    ```

    It might be necessary to first go into specific directories in `<project-dir>/optee_examples/` because of module dependencies. The parent modules should thus be build first using the same command.

6. Finally, in `<project-dir>/build/`:

    ``` sh
    make run CFG_CORE_ASLR=n GDBSERVER=y -j`nproc`
    ```
