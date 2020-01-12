a = [1, 1, 1, 2, 3, 3, 3, 10]
b = [3, 10, 14]

for number in a[:]:
    if number in b:
        a.remove(number)

print(a)