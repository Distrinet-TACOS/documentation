# Normal world callback on secure world interrupt

Now we know how to register interrupts in the secure world, it would be interesting to notify the normal world of some event. This would allow us to register a callback in the normal world, making it possible to react to these events from the secure world.

The mechanism that is used to notify the normal world is aptly called *asynchronous notifications*. This is a feature that is added to the Linux kernel, but it is still in the middle of the review process. This feature is thus not yet generally available. To check out this feature, you can clone the `tacos-qemu-callback.xml` manifest file as explained earlier in the [Download of repositories](#download-of-repositories) section. This section will cover the implementation details of this feature.

## Feature state

This notification feature is explained in the OP-TEE documentation in the section about [asynchronous notifications](https://optee.readthedocs.io/en/latest/architecture/core.html#notifications). It consists of two active RFCs, one on the [optee_os](https://github.com/OP-TEE/optee_os) repository and on the [linaro-swg linux](https://github.com/linaro-swg/linux) repository. Because the changes to the linux repository are actually changes to the Linux kernel itself, these changes need to be upstreamed to the actual Linux kernel. Although this feature is generally well received by the kernel maintainers, this review process is lengthy, with multiple back and forths between the Linaro developers and the maintainers. It generally takes a few months until the changes are accepted. The changes to optee_os are on hold until the upstreaming process is finished.

## Using asynchronous notifications

Luckily, the mechanism that is currently being reviewed is in a working state, which means we can pull it in our working copy and use it to our hearts content. The changes have already been applied to our fork of the linux kernel, and can be pulled from git as explained in the introduction of this section.

### Secure world to normal world

The notification to the normal world is achieved through triggering a non-secure interrupt. The triggering of this interrupt is platform specific and done via `itr_raise_pi()`. This call is wrapped in a function called `notif_send_async`, which can be called in an interrupt handler in the secure world. An example implementation can be found in `optee_os/core/arch/arm/plat-vexpress/main.c`. When this non-secure interrupt has been triggered, the Linux kernel in the normal world launches the normal interrupt handling process. At system startup, a handler for this kind of notification interrupt has been registered, so that handler is used.

The *hard* interrupt handler `notif_irq_handler`^[`/drivers/tee/optee/notif.c`] of a threaded interrupt with the name `optee_notification` is registered during the initialization of the kernel. This handler is responsible for deciding what to do with the interrupt thrown, based on the value of the notification. This value is collected by the function called `get_async_notif_value`. The only value that is currently implemented is `OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`, but the implementation could easily be extended to allow for different notifications.

Because the interrupt handler in the Linux kernel is a *threaded interrupt* it is also possible to do further handling in the interrupt handler thread called `notif_irq_thread_fn`. This is the appropriate way to execute more complex interrupt handling that could block the kernel for quite some time.

### Normal world to secure world

On the secure side, a *notification driver* can be registered, should you want to use the asynchronous notification feature as intended. An example implementation can be found in the file `optee_os/core/arch/arm/plat-vexpress/main.c`. However, to write some kind of split driver over the two worlds, we are not fully using this feature, but just using half of the communication channel: from the secure to the normal world.
