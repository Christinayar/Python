#Дан список заполненный произвольными целыми числами.
#Получите новый список, элементами которого будут только уникальные элементы исходного.

numbers = [1, 1, 2, 3, 3, 4, 4, 4, 4, 5, 7]

result = []
for number in numbers:
    if numbers.count(number) == 1:
        result.append(number)

print(result)