class ZeroError(Exception):
    def __init__(self, txt):
        self.txt = txt


try:
    a = input('Введите число: ')
    b = input('Введите второе число: ')

    a, b = int(a), int(b)
    if b == 0:
        raise ZeroError('Ошибка - на ноль делить нельзя!')
except ZeroError as err:
    print(err)
except ValueError:
    print('Ошибка - вы ввели не число, а текст!')
else:
    res = a / b
    print('Все в порядке!')
finally:
    print('Программа завершена')


#Var2---------------------------------------------
try:
    a = input('Введите число: ')
    b = input('Введите второе число: ')
    a, b = int(a), int(b)
    res = a / b
except ZeroDivisionError:
    print('На ноль делить нельзя!')
except ValueError:
    print('Вы ввели не число, а текст!')
else:
    print('Все в порядке!')
finally:
    print('Программа завершена')
