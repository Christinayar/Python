class Warehouse:
    def __init__(self, area, employee):
        self.area = area
        self.employee = employee
        print(f'Площадь склада Amazon равна - {area} квадртаных метров, количество сотрудников - {employee} \n')


class Equipment:
    def __init__(self, name, price, quantity, doc, *args):
        self.name = name
        self.price = price
        self.quantity = quantity
        self.doc = doc

    def __str__(self):
        return f'Название оборудования - {self.name} \nЦена - {self.price} \nКоличество - {self.quantity} \n'


class Printer(Equipment):
    def to_print(self):
        return f'Печать документа {self.doc} на оборудовании {self.name} запущена \n'


class Scanner(Equipment):
    def to_scan(self):
        return f'Сканирование документа {self.doc}'


class Xerox(Equipment):
    def to_copy(self):
        return f'Копирую документ {self.doc}'


w = Warehouse(50000, 100)
ex_1 = Printer('HP', 2000, 5, 'Бланк заработной платы')
print(ex_1.to_print())
e = Equipment('Принтер', 2000, 10, None)
print(e)
