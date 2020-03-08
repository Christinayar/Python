while True:
    line = input('Введите любую информацию: ').split()
    if not line:
        break
    with open("text.txt", "w") as file_obj:
        for i in range(len(line)):
            print(line[i], file=file_obj)