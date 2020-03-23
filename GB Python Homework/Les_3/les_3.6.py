def int_func():
    word = (input('Введите слово из маленьких латинских букв: '))
    return word.title()


print(int_func())



# Вариант 2 ------------------------------------

int_func = lambda w: print(w.title())
int_func(input('Введите слово: '))

# Вариант 3 ------------------------------------

def int_func(word):
    words, result = [], []
    if len(word) > 0:
        for i in word.split():
            words.append(i[0].upper() + i[1:])
        result = ' '.join(words)
    return result

print(int_func(input('Введите строку: ')))
