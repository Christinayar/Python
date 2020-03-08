with open('text2.txt', 'w') as f:
    line = input('Введите цифры через пробел \n')
    f.writelines(line)
    numbers = line.split()

    print(sum(map(int, numbers)))
