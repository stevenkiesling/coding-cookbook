aws-tester: main.cpp
	g++ -std=c++14 main.cpp ../src/image.pb.cc \
	-L/usr/local/lib -L/usr/local/lib64 \
	-lprotobuf /usr/local/lib/libcryptopp.a \
	-lcurl \
	-lopencv_core -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc -o aws-tester
