def my_func(var_1, var_2, var_3):
    if var_1 >= var_3 and var_2 >= var_3:
        return var_1 + var_2
    elif var_1 > var_2 and var_1 > var_3:
        return var_1 + var_3
    else:
        return var_2 + var_3


print(my_func(20, 1, 6))
print(
    f'Сумма наибольших чисел - {my_func(int(input("Введите первое число ")), int(input("Второе ")), int(input("Третье ")))}')
    
#VAR2---------------------------
    
def my_func(num_1, num_2, num_3):
    my_list = [num_1, num_2, num_3]
    try:
        my_list.pop(my_list.index(min(my_list)))
        return sum(my_list)
    except TypeError:
        return "Enter only a number"


print(my_func(2, 20, 5))
    
#VAR3---------------------------
    
def my_f(arg1, arg2, arg3):
    return sum(sorted([arg1, arg2, arg3])[1:])

print(my_f(2000, 10, 3))
