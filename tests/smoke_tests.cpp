/* Smoke tests for fdlibm */

#include "fdlibm.h"
#include <cstdint>
#include <fstream>

#include "gtest/gtest.h"

namespace {

    class FDLIBMTest : public ::testing::Test { };

    TEST(FDLIBMTest , smoke_test_exp )
    {
        uint64_t max_ulp = 2;
        std::ifstream ref;
        ref.open("smoke_test_exp.txt",std::ifstream::in);
        while (ref.good() && ! ref.eof()) {
            uint64_t ix,iy,iz,ulp_error;
            double x,z;
            ref >> std::hex >> ix;
            ref >> std::hex >> iy;
            ref.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            __setBits(x,ix);
            z=exp(x);
            __getBits(iz,z);
            ulp_error = std::abs((int64_t)(iy-iz));
            ASSERT_LE(ulp_error,max_ulp);
        }
        ref.close();
    }

    TEST(FDLIBMTest , smoke_test_ln )
    {
        uint64_t max_ulp = 2;
        std::ifstream ref;
        ref.open("smoke_test_ln.txt",std::ifstream::in);
        while (ref.good() && ! ref.eof()) {
            uint64_t ix,iy,iz,ulp_error;
            double x,z;
            ref >> std::hex >> ix;
            ref >> std::hex >> iy;
            ref.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            __setBits(x,ix);
            z=log(x);
            __getBits(iz,z);
            ulp_error = std::abs((int64_t)(iy-iz));
            ASSERT_LE(ulp_error,max_ulp);
        }
        ref.close();
    }
    
    TEST(FDLIBMTest , smoke_test_sin )
    {
        uint64_t max_ulp = 2;
        std::ifstream ref;
        ref.open("smoke_test_sin.txt",std::ifstream::in);
        while (ref.good() && ! ref.eof()) {
            uint64_t ix,iy,iz,ulp_error;
            double x,z;
            ref >> std::hex >> ix;
            ref >> std::hex >> iy;
            ref.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            __setBits(x,ix);
            z=sin(x);
            __getBits(iz,z);
            ulp_error = std::abs((int64_t)(iy-iz));
            ASSERT_LE(ulp_error,max_ulp);
        }
        ref.close();
    }
    
    TEST(FDLIBMTest , smoke_test_cos )
    {
        uint64_t max_ulp = 2;
        std::ifstream ref;
        ref.open("smoke_test_cos.txt",std::ifstream::in);
        while (ref.good() && ! ref.eof()) {
            uint64_t ix,iy,iz,ulp_error;
            double x,z;
            ref >> std::hex >> ix;
            ref >> std::hex >> iy;
            ref.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            __setBits(x,ix);
            z=cos(x);
            __getBits(iz,z);
            ulp_error = std::abs((int64_t)(iy-iz));
            ASSERT_LE(ulp_error,max_ulp);
        }
        ref.close();
    }
    
    TEST(FDLIBMTest , smoke_test_tan )
    {
        uint64_t max_ulp = 2;
        std::ifstream ref;
        ref.open("smoke_test_tan.txt",std::ifstream::in);
        while (ref.good() && ! ref.eof()) {
            uint64_t ix,iy,iz,ulp_error;
            double x,z;
            ref >> std::hex >> ix;
            ref >> std::hex >> iy;
            ref.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            __setBits(x,ix);
            z=tan(x);
            __getBits(iz,z);
            ulp_error = std::abs((int64_t)(iy-iz));
            ASSERT_LE(ulp_error,max_ulp);
        }
        ref.close();
    }
    
}  // namespace

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
