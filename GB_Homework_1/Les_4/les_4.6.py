from itertools import count, cycle

# Task 6.1

for i in count(10):
    print(i)


# Task 6.2

my_list = [1, 'Hello', 555]
for el in cycle(my_list):
    print(el)