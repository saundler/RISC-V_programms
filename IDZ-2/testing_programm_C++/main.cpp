#include <iostream>
#include <cmath> // Для функции tan()

int main() {
    double x;
    std::cout << "Input x = ";
    std::cin >> x;

    // Проверка, не попадает ли x в область, где косинус равен 0, потому что тангенс не определен для pi/2 + k*pi
    double pi = 3.14159265358979323846;
    double remainder = fmod(fabs(x), pi); // Взять остаток от деления на π и использовать абсолютное значение для проверки
    if (fabs(remainder - pi/2) < 1e-10) { // Если x близко к (pi/2) + k*pi, где k - целое число, вычисление может быть неопределенным
        std::cerr << "Ошибка: Тангенс не определен для pi/2 + k*pi." << std::endl;
        return 1;
    }

    double tan_result = tan(x); // Вычисление тангенса x
    std::cout << "tan(" << x << ") = " << tan_result << std::endl;

    return 0;
}
