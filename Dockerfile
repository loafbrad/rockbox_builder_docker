# Rockbox Source builder
FROM ubuntu:18.04

# Install dependencies
RUN apt-get update
RUN apt-get install -y build-essential git gcc-arm-none-eabi zip vim
RUN apt-get install -y libsdl2-dev libsdl2-2.0-0
RUN apt-get install -y x11-apps

# Rockbox expects arm-elf-eabi-* with GCC version 4.something
# Just make symlinks from arm-none-eabi-* this seems to work...
RUN ln -s /usr/bin/arm-none-eabi-cpp /usr/local/bin/arm-elf-eabi-cpp && \
    ln -s /usr/bin/arm-none-eabi-gcc /usr/local/bin/arm-elf-eabi-gcc && \
    ln -s /usr/bin/arm-none-eabi-ld /usr/local/bin/arm-elf-eabi-ld && \
    ln -s /usr/bin/arm-none-eabi-gcc-ar /usr/local/bin/arm-elf-eabi-gcc-ar && \
    ln -s /usr/bin/arm-none-eabi-objcopy /usr/local/bin/arm-elf-eabi-objcopy

ARG REPOSITORY_DIR=/rockbox
RUN git clone git://git.rockbox.org/rockbox.git ${REPOSITORY_DIR}
WORKDIR ${REPOSITORY_DIR}

# Use these commands to build a Rockbox zip.
# Extract the zip file onto root directory of FAT32 formatted iPod
# The configure command will ask which target you are building for.
# Example, iPod Video (5th gen) is option 22, followed by (N)ormal.
# CMD ["../tools/configure"]
# CMD ["make", "-j4"]
# CMD ["make", "zip"]

CMD ["bash"]
