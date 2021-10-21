# Tips and tricks

## gdbserver

It is possible to debug host applications in the normal world by compiling OP-TEE using the flag `GDBSERVER=y`. However, if OP-TEE was compiled before, the compilation process generates the following error:

``` txt
-- The C compiler identification is unknown
-- Check for working C compiler: <project-dir>/out-br/host/bin/arm-linux-gnueabihf-gcc
-- Check for working C compiler: <project-dir>/out-br/host/bin/arm-linux-gnueabihf-gcc -- broken
CMake Error at /usr/share/cmake-3.16/Modules/CMakeTestCCompiler.cmake:60 (message):
  The C compiler

    "<project-dir>/out-br/host/bin/arm-linux-gnueabihf-gcc"

  is not able to compile a simple test program.

  It fails with the following output:
  ...
```

This problem stems from mixing compilations with and without the gdbserver **activated**. The solution is to completely remove `<project-dir>/out-br` and to start the compilation process again.
