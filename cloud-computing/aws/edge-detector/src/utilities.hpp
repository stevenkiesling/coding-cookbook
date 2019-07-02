#pragma once
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <vector>
#include <cryptopp/base64.h>
#include "image.pb.h"

using namespace CryptoPP;
using cv::Mat;
using std::string;

namespace utilities {
  inline Image getImage(const cv::Mat &mat) {
    Image image;
    image.set_width(mat.cols);
    image.set_height(mat.rows);
    image.set_channels(mat.channels());
    image.set_data(mat.data, (mat.rows*mat.cols*mat.channels())*sizeof(unsigned char));
    image.set_format(Image_ColorFormat_BGR);
    return image;
  }

  inline Mat getMat(const Image &image, bool copyData=false) {
    auto type = CV_8UC3;
    if(image.channels() == 1) {
        type = CV_8U;
    } else if(image.channels() == 4) {
        type = CV_8UC4;
    }
    Mat mat(image.height(), image.width(), type, const_cast<char*>(image.data().data()), copyData=copyData);
    return mat;
  }

  inline std::string encode(const std::vector<CryptoPP::byte> &buffer) {
    std::string encoded;
    StringSource ss(buffer.data(), buffer.size(), true, new Base64Encoder(new StringSink(encoded), false));
    return encoded;
  }

  inline std::string decode(const std::string &encoded) {
    string decoded;
    StringSource ss(encoded, true, new Base64Decoder(new StringSink(decoded)));
    return decoded;
  }
}