def new_():
    try:
        n = int(input('Введите число: '))
        m = int(input('Введите число: '))
        return round(n / m, 2)
    except ZeroDivisionError:
        print('На 0 делить нельзя!')


print(new_())

#----------------------------------------------------------
def div(s_1, s_2):
    try:
        s_1, s_2 = int(s_1), int(s_2)
        div_num = s_1 / s_2
    except ValueError:
        return "Value Error"
    except ZeroDivisionError:
        return "Division by zero forbidden"
    return div_num


print(div(input('Enter first number - '), input('Enter second - ')))
