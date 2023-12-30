FROM amazonlinux:latest

#--------------------------------------
# Setting up the build environment inside the container

# Install RPM build tools
RUN yum install -y rpm-build rpmdevtools rpmlint

# Install build dependencies
RUN yum install -y sudo

# Install userfull tools
RUN yum install -y procps vim tree which

# Create a non-root user to build the RPMs
# -m: create the user's home directory
# -G: add the user to the wheel group
# -p: set the user's password to blank for passwordless sudo
RUN useradd -m builder -G wheel -p ""

# Switch to the new user
USER builder

# Set the working directory to the user's home directory
WORKDIR /home/builder

# Copy the start script into the container
COPY --chown=builder:builder container_start.sh /home/builder/container_start.sh

# Create the RPM build directory structure
RUN rpmdev-setuptree


#--------------------------------------
# Building the RPM

# Copy hello.sh script into the container
COPY --chown=builder:builder hello.sh /home/builder/hello.sh

# Create the source tarball
RUN mkdir hello-0.0.1 \
    && cp hello.sh hello-0.0.1 \
    && tar -czvf hello-0.0.1.tar.gz hello-0.0.1 \
    && rm -rf hello-0.0.1 \
    && mv hello-0.0.1.tar.gz /home/builder/rpmbuild/SOURCES/


# Copy the already created spec file into the container
COPY --chown=builder:builder hello.spec /home/builder/rpmbuild/SPECS/hello.spec

# Alternatively, you can create a boilderplace spec file and edit it away as needed
# Create the RPM spec file and move it to the SPECS directory
# RUN rpmdev-newspec hello \
#     && mv hello.spec /home/builder/rpmbuild/SPECS/


# Check the spec file for errors
RUN rpmlint ~/rpmbuild/SPECS/hello.spec &> ~/hello.spec.lint

# Create the .src rpm package
# -bs: build source
RUN rpmbuild -bs ~/rpmbuild/SPECS/hello.spec

# Create the binary rpm package
# -bb: build binary
RUN rpmbuild -bb ~/rpmbuild/SPECS/hello.spec


#--------------------------------------
# Testing the RPM

# Install the RPM
RUN sudo yum install -y ~/rpmbuild/RPMS/noarch/hello-0.0.1-1.amzn2023.noarch.rpm

# Run the hello.sh script
# 2>&1: redirect stderr to stdout
# tee: redirect stdout to a file and stdout
# /proc/1/fd/1: redirect stdout to the container's stdout
# The reason for this is that the process run inside the container by running this command is not PID 1
RUN hello.sh 2>&1 | tee /proc/1/fd/1

# Set the entrypoint to bash
ENTRYPOINT ["/bin/bash"]

# Run the script when the container launches
CMD ["/home/builder/container_start.sh"]

