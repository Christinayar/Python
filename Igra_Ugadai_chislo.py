# coding=utf-8
# Шаг 1. Загадать случайное число
import random


number = random.randint(1, 100)
#print(number)


while True:
    user_number = int(input('Введите число: '))
    if number == user_number:
        print('Победа')
        break
    elif number < user_number:
        print('Ваше число больше загаданного')
    else:
        print('Ваше число меньше загаданного')