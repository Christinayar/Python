
while True:
    number = int(input('Введите число'))
    if number > 0 and number < 10:
        print (number**2)
        break
    else:
        print ('Число должно быть > 0 и < 10')
