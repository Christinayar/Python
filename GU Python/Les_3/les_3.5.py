num = 0
try:
    while num != '#':
        for i in map(int, input('Для выхода наберите "#" \nВведите несколько чисел, испольузуя поробел: \n').split()):
            num += i
        print(num)
except ValueError:
    print(num)