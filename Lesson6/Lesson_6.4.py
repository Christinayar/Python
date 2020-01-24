def unlucky_number(number):
    if number == 13:
        raise ValueError('Несчастливое число')
    else:
        return number**2


number = int(input('Введите число'))

try:
    result = unlucky_number(number)
except ValueError:
    print('У нас несчастливое число')
else:
    print(result)