
CPP=clang++
CPPFLAGS=-pthread -std=c++11
LD=$(CPP)
LDFLAGS=$(CPPFLAGS)

GTEST_DIR = ../googletest/googletest

smoke_tests: smoke_tests.cpp $(GTEST_DIR)/include/gtest/gtest.h ../libm.a 
	$(CPP) -c -I$(GTEST_DIR)/include/ -I.. $(CPPFLAGS) smoke_tests.cpp 
	$(CPP) -c -I$(GTEST_DIR)/include/ -I$(GTEST_DIR) $(CPPFLAGS) ${GTEST_DIR}/src/gtest-all.cc
	$(LD) -o smoke_tests $(LDFLAGS) smoke_tests.o gtest-all.o ../libm.a 

libgtest.a: ${GTEST_DIR}/src/gtest-all.cc
	$(CPP) -c -I$(GTEST_DIR)/include/ -I$(GTEST_DIR) $(CPPFLAGS) ${GTEST_DIR}/src/gtest-all.cc
	$(AR) -rv libgtest.a gtest-all.o
