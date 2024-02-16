#!/bin/sh

set -xe

./собрать.sh
mkdir -p ./сборка/примеры/
mkdir -p ./сборка/тесты/

test_fasm() {
    ./сборка/хуяк комп -вывод ./сборка/примеры/01-привет-фазм    ./примеры/01-привет.хуя
    ./сборка/хуяк комп -вывод ./сборка/примеры/02-цикл-фазм      ./примеры/02-цикл.хуя
    ./сборка/хуяк комп -вывод ./сборка/примеры/03-имя-фазм       ./примеры/03-имя.хуя
    ./сборка/хуяк комп -вывод ./сборка/примеры/04-физз-базз-фазм ./примеры/04-физз-базз.хуя
    ./сборка/хуяк комп -вывод ./сборка/примеры/05-фибоначчи-фазм ./примеры/05-фибоначчи.хуя
    ./сборка/хуяк комп -вывод ./сборка/примеры/06-рейлиб-фазм    ./примеры/06-рейлиб.хуя

    ./сборка/примеры/01-привет-фазм
    ./сборка/примеры/02-цикл-фазм
    echo 'Алексей' | ./сборка/примеры/03-имя-фазм
    ./сборка/примеры/04-физз-базз-фазм
    ./сборка/примеры/05-фибоначчи-фазм
    #./сборка/примеры/06-рейлиб-фазм

    ./сборка/хуяк комп -пуск -вывод ./сборка/тесты/тест-фазм ./тесты/тест.хуя
}

test_inter() {
    ./сборка/хуяк интер ./примеры/01-привет.хуя
    ./сборка/хуяк интер ./примеры/02-цикл.хуя
    echo 'Алексей' | ./сборка/хуяк интер ./примеры/03-имя.хуя
    ./сборка/хуяк интер ./примеры/04-физз-базз.хуя
    ./сборка/хуяк интер ./примеры/05-фибоначчи.хуя
    #./сборка/хуяк интер ./примеры/06-рейлиб.хуя

    ./сборка/хуяк интер ./тесты/тест.хуя
}

test_fasm
test_inter
