my_list = [7, 5, 3, 3, 2]
number = int(input('Введите число: '))
i = 0
while i < len(my_list) and my_list[i] >= number:
    i = +1
my_list.insert(i, number)
print(my_list)

#---------------------------------------------

my_list = [7, 5, 3, 3, 2]
number = int(input('Введите число: '))
i = 0
for n in my_list:
    if number <= n:
        i = +1
my_list.insert(i, number)
print(my_list)
