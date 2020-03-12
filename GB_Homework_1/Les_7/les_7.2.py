class Clothes:
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def get_square_c(self):
        return str(f'Необходимо ткани на одно пальто: {round(self.width / 6.5 + 0.5)}')

    def get_square_s(self):
        return str(f'Необходимо ткани на один костюм: {round(self.height * 2 + 0.3)}')

    @property
    def get_sq_full(self):
        return str(f'Всего требуется ткани: {round((self.width / 6.5 + 0.5) + (self.height * 2 + 0.3))}')


class Coat(Clothes):
    def __init__(self, width, height):
        super().__init__(width, height)
        self.square_c = round(self.width / 6.5 + 0.5)


class Suit(Clothes):
    def __init__(self, width, height):
        super().__init__(width, height)
        self.square_j = round(self.height * 2 + 0.3)


coat = Coat(13, 2)
suit = Suit(9, 19)

print(coat.get_sq_full)
print(coat.get_square_c())

print(suit.get_sq_full)
print(suit.get_square_s())
