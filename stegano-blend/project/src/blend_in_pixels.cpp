#include <blend_in_pixels.hpp>

#include <iostream>

#include <SFML/Graphics.hpp>

template <typename PixelType, typename ChanelType>
PixelType bland_chanel_in_pixel(const PixelType & src, const ChanelType & chanel)
{
    PixelType res = src;

    res.r -= res.r % 10;
    res.g -= res.g % 10;
    res.b -= res.b % 10;

    res.r += (chanel / 100) % 10;
    res.g += (chanel / 10 ) % 10;
    res.b += (chanel / 1  ) % 10;

    return res;
}

int blend_in_pixels(const std::string & origin, const std::string & sectret, const std::string & result)
{
    sf::Image sectret_image, result_image;

    if (!sectret_image.loadFromFile(sectret)) {
        std::cerr << "Cannot open " << sectret << " to read" << std::endl;
        return 2;
    }

    if (!result_image.loadFromFile(origin)) {
        std::cerr << "Cannot open " << origin << " to read" << std::endl;
        return 2;
    }

    if (result_image.getSize().x < sectret_image.getSize().x * 3) {
        std::cerr << "Secret image is too big (width)" << std::endl;
        return 2;
    }

    if (result_image.getSize().y < sectret_image.getSize().y) {
        std::cerr << "Secret image is too big (height)" << std::endl;
        return 2;
    }

    for (unsigned y = 0; y < sectret_image.getSize().y; ++y) {
        for (unsigned x = 0; x < sectret_image.getSize().x; ++x) {
            auto pixel = sectret_image.getPixel(x, y);

            auto r = result_image.getPixel(x*3 + 0, y);
            auto g = result_image.getPixel(x*3 + 1, y);
            auto b = result_image.getPixel(x*3 + 2, y);

            result_image.setPixel(x*3 + 0, y, bland_chanel_in_pixel(r, pixel.r));
            result_image.setPixel(x*3 + 1, y, bland_chanel_in_pixel(g, pixel.g));
            result_image.setPixel(x*3 + 2, y, bland_chanel_in_pixel(b, pixel.b));
        }
    }

    if (!result_image.saveToFile(result)) {
        std::cerr << "Cannot open " << result << " to write" << std::endl;
        return 2;
    }

    return 0;
}

int blend_in_pixels_reverse(const std::string & source, const std::string & result)
{
    sf::Image source_image, result_image;

    if (!source_image.loadFromFile(source)) {
        std::cerr << "Cannot open " << source << " to read" << std::endl;
        return 2;
    }

    result_image.create(source_image.getSize().x/3, source_image.getSize().y);

    for (unsigned y = 0; y < source_image.getSize().y; ++y) {
        for (unsigned x = 0; x < source_image.getSize().x; x += 3) {
            auto r = (x < source_image.getSize().x) ? source_image.getPixel(x + 0, y) : sf::Color(0, 0, 0);
            auto g = (x < source_image.getSize().x) ? source_image.getPixel(x + 1, y) : sf::Color(0, 0, 0);
            auto b = (x < source_image.getSize().x) ? source_image.getPixel(x + 2, y) : sf::Color(0, 0, 0);

            sf::Color pixel(
                (r.r % 10) * 100 + (r.g % 10) * 10 + (r.b % 10) * 1,
                (g.r % 10) * 100 + (g.g % 10) * 10 + (g.b % 10) * 1,
                (b.r % 10) * 100 + (b.g % 10) * 10 + (b.b % 10) * 1
            );

            result_image.setPixel(x/3, y, pixel);
        }
    }

    if (!result_image.saveToFile(result)) {
        std::cerr << "Cannot open " << result << " to write" << std::endl;
        return 2;
    }

    return 0;
}
