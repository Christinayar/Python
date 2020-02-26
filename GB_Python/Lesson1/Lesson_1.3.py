# Создайте программу “Медицинская анкета”, где вы запросите у пользователя следующие данные: имя, фамилия, возраст и вес.

name = input('Введите ваши имя и фамилию ')
age = int(input('Сколько вам лет '))
weight = int(input('Введите ваш вес '))


if age < 30 and (weight > 50 and weight < 120):
    print(name, '- Ты красавчик!')

elif (age > 30 and age < 40) and (weight < 50 and weight < 120):
    print(name, '- Займись собой!')

else:
    print(name, '- Все плохо,бегом к врачу!')

print('Конец осмотра!')
