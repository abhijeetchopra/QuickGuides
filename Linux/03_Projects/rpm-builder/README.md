# rpm-builder

## Intro

This repository contains the source code and specifications for building a simple "Hello" RPM package. The RPM package, when installed, deploys a script that prints "Hello, World!" to the console.

The `Dockerfile` included in this repository sets up an environment for building and testing the RPM package. It uses `rpmbuild` to compile the source code and build the RPM package, and `rpmlint` to check the spec file for errors. The resulting RPM package is then installed and tested within the Docker container.

This project is a great starting point if you're learning about RPM packaging or if you need a basic template for creating your own RPM packages.

## Usage

```bash
# build the container
make build

# start the container in detatched mode
make start

# start an interactive shell into the container
make exec

# stop and remove running container and image
make clean
```

## References

- <https://www.redhat.com/sysadmin/create-rpm-package>
- <https://rpm-packaging-guide.github.io/>
