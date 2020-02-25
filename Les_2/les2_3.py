# Вариант 1 со списками
m = input('Введите месяц в формате mm : ')

winter = ['12', '01', '02']
spring = ['03', '04', '05']
sum = ['06', '07', '08']
fall = ['09', '10', '11']

if m in spring:
    print('Это весна!')
elif m in winter:
    print('Это зима!')
elif m in sum:
    print('Это лето! ')
else:
    print('Это осень! ')

m = int(input('Введите месяц в формате mm : '))

# Вариант 2 со словарями

m = input('Введите месяц в формате mm : ')
weather = {
    ('12', '01', '02'): 'зима',
    ('09', '10', '11'): 'осень'
}
for i in weather:
    if m in i:
        print(weather.get(i))
