from time import sleep


class TrafficLight:

    __colors = ['red', 'yellow', 'green']

    def running(self):
        i = 0
        while True:
            for el in TrafficLight.__colors:
                print(el)
                i += 1
                sleep(7)

traffic = TrafficLight()
traffic.running()

#Var2-------------------------------


from time import sleep


class TrafficLight:
    __colors = ['red', 'yellow', 'green']

    def running(self):
        i = 0
        while i < 6:
            print(TrafficLight.__colors[i])
            if i == 0:
                sleep(7)
            elif i == 1:
                sleep(3)
            elif i == 2:
                sleep(7)
            i += 1

traffic = TrafficLight()
traffic.running()

#Var3-------------------------------


class TrafficLight:
    __colors = 'green'

    def running(self):
        while True:
            print('red')
            sleep(7)
            print('yellow')
            sleep(2)
            print('green')
            sleep(7)


traffic = TrafficLight()
traffic.running()
