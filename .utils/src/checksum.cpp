#include "result.hpp"
#include <fstream>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

constexpr size_t CHECKSUM_DEFAULT_LENGHT = 32;

typedef struct Args
{
    std::string filename;
    size_t checksumSize;
} Args;

const Result<const Args> parseArgs(int argc, char* argv[])
{
    if (argc != 2) // TODO getopts
    {
        std::cerr << "Usage: " << argv[0] << " <file>\n";
        return {};
    }
    return Args{argv[1], CHECKSUM_DEFAULT_LENGHT}; // TODO param hash-len
}

const Result<const std::string> checksum(const std::string& filename, const size_t checksumSize)
{
    std::ifstream file(filename, std::ios::binary);
    if (!file)
    {
        std::cerr << "ERROR FILE" << std::endl; // TODO readable assert
        return {};
    }

    std::vector<unsigned char> checksumBytes(checksumSize, 0);
    char buffer{0};
    size_t i = 0;
    while (file.read(&buffer, 1)) // TODO read bigger buffer
    {
        checksumBytes[i++ % checksumSize] ^= static_cast<unsigned char>(buffer);
    }

    std::ostringstream checksumString;
    checksumString << std::hex << std::setfill('0');
    for (const auto c : checksumBytes)
    {
        checksumString << std::setw(2) << static_cast<int>(c);
    }
    return checksumString.str();
}

int main(int argc, char* argv[])
{
    const Args args{parseArgs(argc, argv).get()}; // TODO check Result
    const std::string hash{checksum(args.filename, args.checksumSize).get()}; // TODO checksum of many files. use fnmatch
    std::cout << args.filename << "\t" << hash << std::endl;
    return EXIT_SUCCESS;
}
