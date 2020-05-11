rus = {'One': 'Один', 'Two': 'Два', 'Three': 'Три', 'Four': 'Четыре'}

with open('numbers.txt', 'a') as new:
    with open('numbers.txt', 'r') as f:
        line = f.read().split('\n')
        for i in line:
            i = i.split(' - ')
            new.writelines(rus[i[0]] + ' - ' + i[1] + '\n')