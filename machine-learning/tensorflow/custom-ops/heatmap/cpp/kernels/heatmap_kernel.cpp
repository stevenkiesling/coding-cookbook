#include "tensorflow/core/framework/op_kernel.h"
#include <opencv2/opencv.hpp>
#include <iostream>

using namespace tensorflow;

class HeatMapOp : public OpKernel {
public:
  explicit HeatMapOp(OpKernelConstruction* context) : OpKernel(context) { }

  void Compute(OpKernelContext* context) override {
    const Tensor& image = context->input(0);
    const Tensor& opacity = context->input(2);
    const Tensor& should_overlay = context->input(1);

    OP_REQUIRES(context, image.dims() == 3,
                errors::InvalidArgument("image must be 3-dimensional",
                                        image.shape().DebugString()));
    OP_REQUIRES(context, opacity.dims() == 0,
                errors::InvalidArgument("opacity must be 1-dimensional",
                                        opacity.shape().DebugString()));
    OP_REQUIRES(context, should_overlay.dims() == 0,
                errors::InvalidArgument("should_overlay must be 1-dimensional",
                                        should_overlay.shape().DebugString()));
    Tensor* output_tensor = { };
    auto source = image.tensor<uint8, 3>();
    const int height = source.dimension(0);
    const int width = source.dimension(1);
    const int channels = source.dimension(2);
    auto type = channels == 1 ? CV_8U : CV_8UC3;
    cv::Mat original(height, width, type, const_cast<uint8*>(source.data()));
    auto heatMap = original.clone();
    if(channels == 3) {
      cv::cvtColor(heatMap, heatMap, CV_RGB2GRAY);
    }
    cv::applyColorMap(heatMap, heatMap, cv::COLORMAP_JET);
    if(*should_overlay.scalar<bool>().data()) {
      auto alpha = *opacity.scalar<float>().data();
      auto beta = (1.0f - alpha);
      if(channels == 1) {
        cv::cvtColor(original, original, CV_GRAY2RGB);
      } else {
        cv::cvtColor(original, original, CV_BGR2RGB);
      }
      cv::addWeighted(heatMap, alpha, original, beta, 0.0, heatMap);
    }
    OP_REQUIRES_OK(context, context->allocate_output(0, { height, width, 3 }, &output_tensor));
    memcpy(output_tensor->tensor<uint8, 3>().data(), heatMap.data, output_tensor->tensor<uint8, 3>().size());
  }
};

REGISTER_KERNEL_BUILDER(Name("HeatMap").Device(DEVICE_CPU), HeatMapOp);
