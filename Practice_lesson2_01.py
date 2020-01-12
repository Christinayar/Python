#Даны два произвольные списка. Удалите из первого списка элементы присутствующие во втором списке.

my_list_1 = [1, 2, 10, 11, 25, 100, 132]
my_list_2 = [1, 3, 10, 14]

my_list_1 = set(my_list_1)
my_list_2 = set(my_list_2)

same_numbers = (my_list_1 & my_list_2)
print(same_numbers)

print(my_list_1 - same_numbers)
