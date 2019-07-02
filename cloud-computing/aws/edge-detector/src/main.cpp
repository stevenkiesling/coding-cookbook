#include <aws/lambda-runtime/runtime.h>
#include <aws/logging/logging.h>
#include "utilities.hpp"
#include "edge_detector.hpp"

using namespace aws::lambda_runtime;

static invocation_response my_handler(invocation_request const& req) {
  if(!req.payload.empty()) {
    auto buffer = utilities::decode(req.payload);
    Image image;
    if(image.ParseFromArray(buffer.data(), buffer.size())) {
      EdgeDetector e;
      if(e.init(image)) {
        auto img = e.runCanny(100, 200);
        std::vector<unsigned char> buffer_(img.ByteSizeLong());
        img.SerializeToArray(buffer_.data(), buffer_.size());
        auto data = utilities::encode(buffer_);
        return invocation_response::success(data, "application/json");
      }
    }
  }
  return invocation_response::failure("could not process request.", "bad input");
}

int main() {
  run_handler(my_handler);
  return 0;
}
