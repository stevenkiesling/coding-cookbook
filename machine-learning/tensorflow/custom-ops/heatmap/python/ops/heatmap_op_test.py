from tensorflow.python.platform import test
import tensorflow as tf
import numpy as np
try:
  from heatmap_op.python.ops.heatmap_op import heatmap
except ImportError:
  from heatmap_op import heatmap


class HeatMapTest(test.TestCase):
  def testHeatMap(self):
    image = np.zeros((225, 225, 3))
    rgb_array = np.zeros((225, 225, 3), np.uint8)
    rgb_array[0:225, 0:225 , 0] = 128
    with self.test_session():
      result = heatmap(image=image, should_overlay=False, opacity=1.0).eval()
      self.assertEqual(result.shape, (225, 225, 3))
      self.assertAllEqual(result, rgb_array)


if __name__ == '__main__':
  test.main()
