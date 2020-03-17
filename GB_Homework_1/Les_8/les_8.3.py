class Error(Exception):
    def __init__(self, *args):
        self.my_list = []

    def my_input(self):

        while True:
            try:
                a = int(input('Введите число: '))
                self.my_list.append(a)
                print(f'Список: {self.my_list} \n ')
            finally:
                print('Конец')
    #             if a == 'str':
    #                 raise Error('Вы ввели недопустимое значение - строку')
    #         except Error as err:
    #             print(err)
    #
    # if input('Для выхода из программы нажмите "Stop", для продолжения "Enter": '):
    #     break
