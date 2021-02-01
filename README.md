# Nephilim-Kernel-Linux-5.10-ck

BuildADebianKernelPackage
Translation(s): none

This is an obsolete now guide on how to build the Linux Kernel into a .deb package. Don't use this, or take with a grain of salt. Instead, see https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.html#s-common-official



Install the Required Packages
To download and compile the Linux Kernel source we will need the following packages:

build-essential - Essential packages required for compiling.
linux-source - The Linux Kernel Source
libncurses5-dev - Development files for ncurses5. Optional for using curses based menu driven configuration.
To install these packages run the following command as root:

sudo apt-get install build-essential linux-source bc kmod cpio flex libncurses5-dev libelf-dev libssl-dev

Extracting the Kernel Source
Under /usr/src you will find a file looking like linux-source-x.x.tar.xz. Please note that x.x will match the current Linux Kernel source for your release of Debian. In this example we will be using the 4.15 Kernel under Sid.

Extract the Kernel Source with the following command (NOTE: You will need to change 4.15 to match the .tar.xz file in /usr/src):

tar xavf /usr/src/linux-source-4.15.tar.xz

Configuring the Kernel
Change directories to the newly extracted linux source (again, match 4.15 to your version):

cd linux-source-4.15

Create a defconfig with the following command, please change ARCH=i386 to match your target architecture:

make ARCH=i386 defconfig

Using your current Debian kernel configuration as a starting point
Alternatively, you can use the configuration from a Debian-built kernel that you already have installed by copying the /boot/config-* file to .config and then running make oldconfig to only answer new questions.

If you do this, ensure that you modify the configuration to set:


CONFIG_SYSTEM_TRUSTED_KEYS = ""
otherwise the build may fail:


make[4]: *** No rule to make target 'debian/certs/test-signing-certs.pem', needed by 'certs/x509_certificate_list'.  Stop.
make[4]: *** Waiting for unfinished jobs....
Building the Debian Package
Use make bindeb-pkg target to build the kernel. the -j`nproc` argument sets the build to use as many cpu's as you have.

nice make -j`nproc` bindeb-pkg

This will take quite some time and it's worth noting that it doesn't necessarily have to be done on the target machine (or even the target architecture, search in your engine of choice for kernel cross-compiling if you want to set it up). Choosing your most powerful machine may reduce the time of this operation from many hours to under 1.

It's also worth noting that if you're using not much of a deviation from the default configuration that ships with debian, you'll need upwards of about 7GB or so of space to do this operation.

When complete, a number of files get created in the parent directory. Here's the important and perhaps confusing ones:

linux-image-VERSION_ARCH.deb
linux-image-VERSION-dbg_VERSION_ARCH.deb
The first one will replace your current default menulist item in grub upon installation. This means that if you install it then next time you reboot, you'll boot into that kernel.

The second are debug symbols for the first. This is useful if say, you want to do kernel debugging. It's worth noting that when extracted the debug symbols are about 5GB.

See also
The "Compiling a Kernel" section in the Debian Administrator's Guide (WARNING: outdated)
