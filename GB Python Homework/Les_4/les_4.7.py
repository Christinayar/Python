from itertools import count
from math import factorial

def fibo_gen():
    for el in count(1):
        yield factorial(el)

fac = fibo_gen()
x = 1
for i in fac:
    if x < 16:
        print(i)
        x += 1
    else:
        break