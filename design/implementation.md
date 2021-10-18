# Implementation into OP-TEE OS

As shown in the figures in the previous sections, both loadable kernel modules and pseudo trusted applications are part of the architecture and thus they all need to be compiled. This requires multiple compile commands in different directories. These commands need to be executed in order (for QEMU):

1. In `build/`:

    ``` sh
    make CFG_CORE_ASLR=n GDBSERVER=y -j`nproc`
    ```

1. In `optee_client/`:

    ``` sh
    make
    ```

1. In `optee_os/`:

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

1. In `optee_examples/`:

    ``` sh
    make \
        --no-builtin-variables \
        TA_DEV_KIT_DIR=/optee/optee_os/out/arm/export-ta_arm32/ \
        CROSS_COMPILE=arm-linux-gnueabihf- \
        TEEC_EXPORT=/optee/optee_client/out/export/usr \
        PLATFORM=vexpress-qemu_virt \
        HOST_CROSS_COMPILE=/optee/toolchains/aarch32/bin/arm-linux-gnueabihf-
    ```

    It might be necessary to first go into specific directories in `optee_examples/` because of module dependencies. The parent modules should thus be build first using the same command.

1. Finally, in `build/`:

    ``` sh
    make run CFG_CORE_ASLR=n GDBSERVER=y -j`nproc`
    ```
