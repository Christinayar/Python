#Даны два произвольные списка. Удалите из первого списка элементы присутствующие во втором списке.

my_list_1 = [1, 2, 10, 11, 25, 100, 132]
my_list_2 = [1, 3, 10, 14]

my_list_1 = set(my_list_1)
my_list_2 = set(my_list_2)

same_numbers = (my_list_1 & my_list_2)

print(my_list_1 - same_numbers)

#-----------------------------------------------------------------------

a = [1, 1, 1, 2, 3, 4]
b = [2, 3]

result = set(a) - set(b)
print(list(result))

#-----------------------------------------------------------------------

a = [1, 1, 1, 2, 3, 3, 3, 10]
b = [3, 10, 14]

for number in a[:]:
    if number in b:
        a.remove(number)

print(a)
