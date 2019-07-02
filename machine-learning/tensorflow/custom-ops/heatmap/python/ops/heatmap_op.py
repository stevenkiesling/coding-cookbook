from tensorflow.python.framework import load_library
from tensorflow.python.platform import resource_loader

heatmap_op = load_library.load_op_library(resource_loader.get_path_to_datafile('libheatmap_op.so'))
heatmap = heatmap_op.heat_map


if __name__ == '__main__':
  import tensorflow as tf
  import numpy as np
  import cv2
  import sys
  if len(sys.argv) != 2:
    raise ValueError('usage: python heatmap_op.py <full-path-to-test-image>')
  with tf.gfile.FastGFile(sys.argv[1], mode='rb') as reader:
    image_file = reader.read()
  image = tf.image.decode_jpeg(image_file)
  with tf.Session():
    frame = heatmap(image=image, should_overlay=True, opacity=0.5).eval()
  WINDOW_NAME = 'HeatMap Test'
  while True:
    cv2.imshow(WINDOW_NAME, frame)
    if cv2.waitKey(20) == 27:
      break
