class Stationery:
    _attr = 'title'
    def draw(self):
        print('Запуск отрисовки.')


class Pen(Stationery):
    def draw(self):
        print('Отрисовка ручкой')


class Pencil(Stationery):
    def draw(self):
        print('Отрисовка карандашом')


class Handle(Stationery):
    def draw(self):
        print('Отрисовка маркером')

pen = Pen()
pencil = Pencil()
handle = Handle()
pen.draw()
pencil.draw()
handle.draw()