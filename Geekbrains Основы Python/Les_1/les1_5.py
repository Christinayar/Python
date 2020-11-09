revenue = int(input('Оборот в рублях за месяц: '))
expense = int(input('Расходы в рублях за месяц: '))

if revenue > expense:
    print('Батюшка, мы растем!')

    profit = revenue / expense
    print('Наш доходность равна показателю {}'.format(profit))

else:
    print('Надо пересчитать экономику - что-то у нас не сходится')

# Revenue Per Employee считается как оборот (не прибыль) деленное на количество сотрудников

employee = int(input('Сколько в компании сотрудников: '))

profit_by_person = revenue // employee
print(profit_by_person)
