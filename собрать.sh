#!/bin/sh

set -xe

mkdir -p ./сборка/
rustc -o ./сборка/хуяк -g исходники/хуяк.rs

mkdir -p ./сборка/примеры/
./сборка/хуяк комп -вывод ./сборка/примеры/01-привет    ./примеры/01-привет.хуя
./сборка/хуяк комп -вывод ./сборка/примеры/02-цикл      ./примеры/02-цикл.хуя
./сборка/хуяк комп -вывод ./сборка/примеры/03-имя       ./примеры/03-имя.хуя
./сборка/хуяк комп -вывод ./сборка/примеры/04-физз-базз ./примеры/04-физз-базз.хуя
./сборка/хуяк комп -вывод ./сборка/примеры/05-фибоначчи ./примеры/05-фибоначчи.хуя

mkdir -p ./сборка/тесты/
./сборка/хуяк комп -пуск -вывод ./сборка/тесты/тест ./тесты/тест.хуя
