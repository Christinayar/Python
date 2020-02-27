def int_func():
    word = (input('Введите слово из маленьких латинских букв: '))
    return word.title()


print(int_func())



# Варианты 2 и 3 до конца не вышли -----------------------------------

int_func = lambda w: w.title
print(int_func("hello"))

print((lambda word: word.title)("hello"))