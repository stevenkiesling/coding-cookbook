CXX := g++
PYTHON_BIN_PATH = python

HEATMAP_SRCS = $(wildcard heatmap/cpp/kernels/*.cpp) $(wildcard heatmap/cpp/ops/*.cpp)

TF_CFLAGS := $(shell $(PYTHON_BIN_PATH) -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))')
TF_LFLAGS := $(shell $(PYTHON_BIN_PATH) -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))')

OPENCV_CFLAGS :=
OPENCV_LFLAGS :=
ifdef OPENCV_PATH
OPENCV_CFLAGS := -I$(OPENCV_PATH)/include
OPENCV_LFLAGS := -L$(OPENCV_PATH)/lib
endif

CFLAGS = $(TF_CFLAGS) -fPIC -O2 -std=c++14 $(OPENCV_CFLAGS)
LDFLAGS = -shared $(TF_LFLAGS) $(OPENCV_LFLAGS) -lopencv_core -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc

HEATMAP_TARGET_LIB = heatmap/python/ops/libheatmap_op.so

heatmap_op: $(HEATMAP_TARGET_LIB)

$(HEATMAP_TARGET_LIB): $(HEATMAP_SRCS)
	$(CXX) $(CFLAGS) -o $@ $^ ${LDFLAGS}

heatmap_test: heatmap/python/ops/heatmap_op_test.py heatmap/python/ops/heatmap_op.py $(HEATMAP_TARGET_LIB)
	$(PYTHON_BIN_PATH) heatmap/python/ops/heatmap_op_test.py

heatmap_view_test: heatmap/python/ops/heatmap_op_test.py heatmap/python/ops/heatmap_op.py $(HEATMAP_TARGET_LIB)
	$(PYTHON_BIN_PATH) heatmap/python/ops/heatmap_op.py $(TEST_IMAGE_PATH)

heatmap_pip_pkg: $(HEATMAP_TARGET_LIB)
	./build_pip_pkg.sh artifacts

heatmap_pkg_test: heatmap_pip_pkg
	pip install artifacts/*.whl
	python -c "import tensorflow as tf;from heatmap.python.ops.heatmap_op import heatmap;import numpy as np;print(heatmap(image=np.zeros((225, 225, 3)), should_overlay=False, opacity=1.0).eval(session=tf.Session()).shape)"
clean:
	rm -f $(HEATMAP_TARGET_LIB)
