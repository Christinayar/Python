fruits1 = ['банан', 'яблоко', 'виноград', 'апельсин']
fruits2 = ['арбуз', 'киви', 'банан', 'мандарин', 'виноград']

result = []

for fruit in fruits1:
    if fruit in fruits2:
        result.append(fruit)

print(result)

#------
result = [fruit for fruit in fruits1 if fruit in fruits2]

print(result)

#------
new_result = list(set(fruits1) & set(fruits2))

print(new_result)