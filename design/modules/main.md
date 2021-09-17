# Linux kernel Modules (aka device drivers)

In the section [Normal world callback on secure world interrupt](#normal-world-callback-on-secure-world-interrupt) a mechanism was explained to notify the normal world of a secure world interrupt. We can now use this mechanism to implement a *split driver* that is responsible for relaying these secure interrupts in the secure world to a device interface in the normal world. It would then be possible to, for instance, write a normal world application that makes use of standardized device interfaces to interact with systems running in the secure world.

On Linux based operating systems, device drivers are called modules. These modules can be *built-in*, meaning they are compiled together with the kernel, or *loadable* at runtime.

## Built-in modules

Built-in modules are easy to make. It suffices to include very little boilerplate code into the `drivers` directory in the Linux repository. The structure of an archetypical module is as follows, and for each file a hello world example is given.

``` txt
drivers
+- ...
+- my-module
|  +- my-module.c
|  +- Makefile
+- ...
+- Makefile
```

``` c
// drivers/my-module/my-module.c
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>

#define AUTHOR  "Hello World author"
#define DESC    "Hello World driver"

static int hello_init(void)
{
   printk(KERN_ALERT "Hello, world\n");
   return 0;
}


static void hello_exit(void)
{
   printk(KERN_ALERT "Goodbye, world\n");
}


module_init(hello_init);
module_exit(hello_exit);

MODULE_LICENSE("Dual BSD/GPL");
MODULE_VERSION("v0.1");
MODULE_AUTHOR(AUTHOR);
MODULE_DESCRIPTION(DESC);
```

``` Makefile
# drivers/my-module/Makefile

obj-y += my-module.o
```

``` Makefile
# drivers/Makefile

...

obj-y += my-module/
```

## Loadable modules
