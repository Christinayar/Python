def my_func():
    x = int(input('Введите любое положительное число: '))
    y = int(input('Введите любое отрицательное число: '))
    return x ** y


print(my_func())

#Вариант 2 --------------------------------------------------------------

print((lambda x, y: x ** y)(2, -3))


#Вариант 3 --------------------------------------------------------------

def per(x, y):
    try:
        res = x ** y
    except TypeError:
        return 'Enter a number'
    return res


print(per(2, - 3))
