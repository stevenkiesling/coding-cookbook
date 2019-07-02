ifndef BIN_NAME
$(error BIN_NAME is not set)
endif
$(BIN_NAME): src/main.cpp proto
	g++ -std=c++14 ./src/main.cpp ./src/image.pb.cc \
	-L/usr/local/lib -L/usr/local/lib64 \
	-lprotobuf /usr/local/lib/libcryptopp.a \
	/usr/local/lib/libaws-lambda-runtime.a -lcurl \
	-lopencv_core -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc -o deploy/$(BIN_NAME)

proto: src/image.proto
	protoc -I=./src --cpp_out=./src src/image.proto
