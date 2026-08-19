#include <fstream>
#include <iostream>

int main(int argc, char* argv[])
{
    if (argc != 2)
    {
        std::cerr << "Usage: " << argv[0] << " <file>\n";
        return EXIT_FAILURE;
    }

    std::ifstream file(argv[1], std::ios::binary);
    if (!file)
    {
        std::cerr << "Error: cannot open file\n";
        return EXIT_FAILURE;
    }

    unsigned char counter = 0;
    char buffer;

    while (file.read(&buffer, 1))
    {
        counter ^= static_cast<unsigned char>(buffer);
    }

    std::cout << std::hex << static_cast<int>(counter) << std::dec << std::endl;
    return EXIT_SUCCESS;
}
