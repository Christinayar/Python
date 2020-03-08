with open('salary.txt', 'r') as f:
    sum_salary = []
    min = []
    line = f.read().split('\n')
    for i in line:
        i = i.split()
        if int(i[1]) < 20000:
            min.append(i[0])
        sum_salary.append(i[1])

print(f'Оклад меньше 20.000 {min}, средний оклад {sum(map(int, sum_salary)) / len(sum_salary)}')
