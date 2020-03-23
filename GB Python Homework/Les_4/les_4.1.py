# VAR1
from sys import argv

def salary():
    script_name, t, h, b = argv  # t - выработка в часах, h - ставка в час, b - премия

    print("Имя скрипта: ", script_name)
    print("Выработка в часах: ", t)
    print("Ставка в час: ", h)
    print("Премия: ", b)

    t, h, b = int(t), int(h), int(b)
    sal = t * h + b
    return sal

print(salary())

# VAR2
def salary (t, h, b):
    sal = t * h + b
    print(sal)


salary(8, 20, 1000)
