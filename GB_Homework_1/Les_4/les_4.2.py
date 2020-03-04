l = [5, 10, 2, 3, 60, 59]
new_list = [el for i, el in range(len(l)) if l[i] > l[i - 1]]
print(new_list)
