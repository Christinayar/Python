string = input('Введите несколько слов: ')
for n, i in enumerate(string.split(), 1):
    print(n, i) if len(i) <= 10 else print(n, (i[:10]))
