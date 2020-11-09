with open("new.txt", "r") as file_obj:
    content = file_obj.readlines()
    for ind, el in enumerate(content):
        words = len(el.split())
        print(f'В строке {ind + 1} - {words} слов')
    lines = 0
    for line in content:
        lines += line.count('\n')

    print(f'Всего строк: {lines}')


#Variant 2

with open("new.txt") as file_obj:
    lines = 0
    letters = 0
    for line in file_obj:
        lines += line.count("\n")
        letters = len(line)-1
        print(f"{letters} букв в строке {lines}")
    print(f"Всего строк: {lines}")