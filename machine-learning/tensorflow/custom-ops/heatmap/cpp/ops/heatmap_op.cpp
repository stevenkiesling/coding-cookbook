#include "tensorflow/core/framework/op.h"
#include "tensorflow/core/framework/shape_inference.h"

using namespace tensorflow;

REGISTER_OP("HeatMap")
  .Input("image: uint8")
  .Input("should_overlay: bool")
  .Input("opacity: float")
  .Output("heatmap: uint8")
  .SetShapeFn([](::tensorflow::shape_inference::InferenceContext* c) {
    c->set_output(0, c->input(0));
    return Status::OK();
  });
