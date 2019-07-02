#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <iostream>
#include <vector>
#include "image.pb.h"
#include "utilities.hpp"

using namespace cv;
using namespace std;
class EdgeDetector {
public:
  EdgeDetector() = default;
  ~EdgeDetector() = default;
  inline bool init(const Image &img) {
    auto tmp = utilities::getMat(img);
    if(tmp.empty()) {
      return false;
    }
    if(img.channels() != 1) {
      auto fmt = CV_BGR2GRAY;
      if(img.format() == Image_ColorFormat_RGB) {
          fmt = CV_RGB2GRAY;
      }
      cvtColor(tmp, _grayScaleMat, fmt);
    } else {
      _grayScaleMat = tmp.clone();
    }
    return true;
  }
  EdgeDetector(const EdgeDetector &rhs) = delete;
  EdgeDetector(EdgeDetector &&rhs) = delete;
  EdgeDetector& operator=(EdgeDetector &rhs) = delete;
  EdgeDetector operator=(EdgeDetector &&rhs) = delete;
  inline Image runCanny(double threshold1, double threshold2,
                        int apertureSize = 3, bool L2gradient = false) {
    Mat detected_edges;
    Canny(_grayScaleMat, detected_edges, threshold1, threshold2, apertureSize, L2gradient);
    return utilities::getImage(detected_edges);
  }
private:
  cv::Mat _grayScaleMat;
};
