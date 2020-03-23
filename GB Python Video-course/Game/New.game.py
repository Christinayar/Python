# coding=utf-8
import random

min_number = 1
max_number = 100
result = None
while result != '=':
    number = random.randint(min_number, max_number)
    print(number)
    result = input('= > (загаданное число больше вашего) < ')
    if result == '>':
        min_number = number + 1
    elif result == '<':
        max_number = number - 1
print('Победа')
