my_list = [60, 5, 10, 10, 5, 2, 3, 2, 60, 59]
new_list = [el for el in my_list if my_list.count(el) == 1]
print(new_list)