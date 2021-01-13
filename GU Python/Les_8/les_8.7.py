class ComplexNumbers:
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def __mul__(self, other):
        return ComplexNumbers (self.a * other.a, self.b * other.b)

    def __add__(self, other):
        return ComplexNumbers(self.a + other.a, self.b + other.b)

    def __str__(self):
        return f'({self.a} + {self.b} * i)'


count_1 = ComplexNumbers(7, 5)
count_2 = ComplexNumbers(13, 15)
print(count_1)
print(count_2)
print(count_1 + count_2)
print(count_1 * count_2)