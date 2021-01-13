class Road:
    __length = None
    __width = None
    weight = None
    thickness = None

    def __init__(self, length, width):
        self.length = length
        self.width = width

    def mass(self):
        self.weigth = 25
        self.thickness = 0.05
        mass = self.length * self.width * self.weigth * self.thickness / 1000
        print(f'Требуется: {mass:.0f} тонн для создания дороги ')


road = Road(60000, 10)
road.mass()
