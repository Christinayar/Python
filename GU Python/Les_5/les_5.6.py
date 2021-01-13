new_dict = {}
with open('programme.txt') as f:
    for line in f:
        name, stats = line.split(':')
        name_sum = sum(map(int, ''.join([i for i in stats if i == ' ' or (i >= '0' and i <= '9')]).split()))
        new_dict[name] = name_sum
print(f'{new_dict}')

