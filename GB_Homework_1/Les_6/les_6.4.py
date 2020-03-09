class Car:

    def __init__(self, speed, color, name, is_police=False):
        self.speed = speed
        self.color = color
        self.name = name
        self.is_police = is_police

    def go(self):
        return f'{self.name} is started'

    def stop(self):
        return f'{self.name} is stopped'

    def turn_right(self):
        return f'{self.name} is turned right'

    def turn_left(self):
        return f'{self.name} is turned left'

    def show_speed(self):
        return f'Current speed {self.name} is {self.speed}'
    
    def police(self):
        if self.is_police:
            return f'{self.name} is from police department'
        else:
            return f'{self.name} is not from police department'


class TownCar(Car):
    def __init__(self, speed, color, name):
        super().__init__(speed, color, name)

    def show_speed(self):
        print(f'Current speed of town car {self.name} is {self.speed}')

        if self.speed > 40:
            return f'Speed of {self.name} is higher than allow for town car'
        else:
            return f'Speed of {self.name} is normal for town car'


class SportCar(Car):
    def __init__(self, speed, color, name):
        super().__init__(speed, color, name)


class WorkCar(Car):
    def __init__(self, speed, color, name):
        super().__init__(speed, color, name)

    def show_speed(self):
        print(f'Current speed of work car {self.name} is {self.speed}')

        if self.speed > 60:
            return f'Speed of {self.name} is higher than allow for work car'


class PoliceCar(Car):
    def __init__(self, speed, color, name):
        super().__init__(speed, color, name, True)
        

#Cars
mazda = TownCar(60, 'White', 'Mazda')
peugeot = WorkCar(90, 'Orange', 'Peugeot')
aston = SportCar(180, 'Blue', 'Aston Martin')
ford = PoliceCar(100, 'White',  'Ford')

# Speed
print(mazda.show_speed() + '\n')
print(aston.show_speed() + '\n')
print(ford.show_speed() + '\n')
print(peugeot.show_speed() + '\n')
print(ford.police() + '\n')


print(f'{peugeot.go()} from City,then {mazda.turn_right()}, and {peugeot.stop()} immediately')
