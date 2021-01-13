import math

old_list = [1, -1, 2, -2, 4, 5, 6, 7, 8, 9]


def new_sqrt_list(input_list):
    input_list = input_list.copy()
    for i in range(len(input_list)):
        number = input_list[i]
        if number > 0:
            input_list[i] = math.sqrt(number)

    return input_list


result = new_sqrt_list(old_list)
print(result)
print(old_list)



def new_sqrt_list(input_list):
    result = [math.sqrt(number) if number > 0 else number for number in input_list]
    return result

result = new_sqrt_list(old_list)
print(result)
print(old_list)

