# TensorFlow Custom Ops
A collection of experiments demonstrating how to build, test, and install custom TensorFlow operations.

## Heatmap Operation
Demonstrates how to build, test, and install a TensorFlow custom operation which has a third party dependency.  The operation itself will create a heatmap of the input image.

### Usage
The custom operations can be built, tested, and installed inside a docker container by running one of the three commands:
```
sh run-docker.sh heatmap_test
sh run-docker.sh heatmap_pip_pkg
sh run-docker.sh heatmap_pkg_test
```
