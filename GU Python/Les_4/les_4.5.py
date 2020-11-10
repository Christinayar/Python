from functools import reduce

numbers =[a for a in range(100, 1001) if a % 2 == 0]
print(numbers)
new = reduce(lambda x, y: x * y, numbers)
print(new)