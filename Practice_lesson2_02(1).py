# coding=utf-8
date = '02.11.2013'

d, m, y = date.split ('.')

print(d, m, y)

months = {
    '01': 'января',
    '11': 'ноября'
}

days = {
    '01': 'первое',
    '02': 'второе',
}

result = f'{days[d]} {months[m]} {y} года.'
print (result)