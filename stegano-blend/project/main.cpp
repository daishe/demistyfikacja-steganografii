
#include <iostream>
#include <string>

#include <blend_in_pixels.hpp>

int main(int argc, const char ** argv)
{
    try
    {
        if (argc > 1) {
            std::string method = argv[1];

            if (method == "pixels" && argc == 5)
                return blend_in_pixels(argv[2], argv[3], argv[4]);
            else if (method == "pixels-reverse"  && argc == 4)
                return blend_in_pixels_reverse(argv[2], argv[3]);
            // else if (method == "colors" && argc == 5)
            //     return blend_in_colors(argv[2], argv[3], argv[4]);
            // else if (method == "colors-reverse" && argc == 4)
            //     return blend_in_colors_reverse(argv[2], argv[3]);
        }

        std::string name = "stegano-blend";
        if (argc != 0)
            name = argv[0];

        std::cout << "Usage" << std::endl;
        std::cout << "   " << name << " pixels ORIGIN SECRET OUTPUT" << std::endl;
        std::cout << "   " << name << " pixels-reverse SOURCE OUTPUT" << std::endl;
        // std::cout << "   " << name << " colors ORIGIN SECRET OUTPUT" << std::endl;
        // std::cout << "   " << name << " colors-reverse SOURCE OUTPUT" << std::endl;
        return 1;
    }
    catch(...)
    {
        std::cerr << "Unexpected exception during execution" << std::endl;
        return 2;
    }
}
