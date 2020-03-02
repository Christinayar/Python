def new_():
    try:
        n = int(input('Введите число: '))
        m = int(input('Введите число: '))
        return round(n / m, 2)
    except ZeroDivisionError:
        print('На 0 делить нельзя!')


print(new_())
