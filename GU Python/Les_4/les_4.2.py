l = [55, 10, 2, 3, 60, 59, 61, 90, 0]
new_list = [l[i] for i in range(len(l)) if l[i] > l[i - 1]]
print(new_list)
