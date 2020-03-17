class Date:
    def __init__(self, day_month_year):
        self.day_month_year = str(day_month_year)

    @classmethod
    def class_method(cls, day_month_year):
        my_date = []

        for i in day_month_year.split():
            if i != '-': my_date.append(i)

        return int(my_date[0]), int(my_date[1]), int(my_date[2])

    @staticmethod
    def valid(day, month, year):

        if 1 <= day <= 31:
            if 1 <= month <= 12:
                if 2019 >= year >= 0:
                    return f'Все верно'
                else:
                    return f'Неправильная дата года'
            else:
                return f'Неправильная дата месяца'
        else:
            return f'Неправильная дата дня'

    def __str__(self):
        return f'Текущая дата {Date.class_method(self.day_month_year)}'


today = Date('17 - 3 - 2020')
print(today)
print(Date.class_method('11 - 11 - 2011'))
print(Date.valid(38, 11, 2000))