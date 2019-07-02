#include <stdio.h>
#include <curl/curl.h>
#include <vector>
#include <iostream>
#include <opencv2/opencv.hpp>
#include <opencv2/core.hpp>
#include "../src/image.pb.h"
#include "../src/utilities.hpp"

int main(int argc, char *argv[]) {
  std::string url;
  std::string key = "x-api-key:";
  std::string image_path;
  std::string edge_image_path;
  auto ret_code = EXIT_SUCCESS;
  if(argc != 5) {
    return EXIT_FAILURE;
  } else {
    url = argv[1];
    key.append(argv[2]);
    image_path = argv[3];
    edge_image_path = argv[4];
  }
  CURL *curl;
  CURLcode res;
  curl_global_init(CURL_GLOBAL_ALL);
  curl = curl_easy_init();
  if(curl) {
    struct curl_slist *list = nullptr;
    std::vector<char> post_buffer;
    auto src = cv::imread(image_path, CV_LOAD_IMAGE_COLOR);
    auto img = utilities::getImage(src);
    post_buffer.resize(img.ByteSizeLong());
    img.SerializeToArray(post_buffer.data(), img.ByteSizeLong());
    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
    list = curl_slist_append(list, key.c_str());
    list = curl_slist_append(list, "Content-Type:application/x-protobuf");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, list);
    // request
    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, post_buffer.data());
    curl_easy_setopt(curl, CURLOPT_POSTFIELDSIZE, post_buffer.size());
    // response
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION,
                    +[](char *contents, size_t size, size_t nmemb, void *userdata) {
        auto buffer = static_cast<std::vector<char>*>(userdata);
        auto len = size*nmemb;
        std::copy_n(contents, len, back_inserter(*buffer));
        return len;
    });
    std::vector<char> response_buffer;
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response_buffer);
    res = curl_easy_perform(curl);
    if(res != CURLE_OK) {
      fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
    } else {
      long response_code;
      curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &response_code);
      if(response_code == 200) {
        Image image;
        image.ParseFromArray(response_buffer.data(), response_buffer.size());
        auto mat = utilities::getMat(image);
        cv::imwrite(edge_image_path, mat);
        std::cout << "Sucessfully created: " << edge_image_path << "\n";
      } else {
        std::cout << "Failed with status code: " << response_code << "\n";
        ret_code = EXIT_FAILURE;
      }
    }
    curl_easy_cleanup(curl);
  }
  curl_global_cleanup();
  return ret_code;
}
