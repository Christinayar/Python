# 1-------------------------------------------------------

input = int(input())
print(input // 60)
print(input % 60)

# 2-------------------------------------------------------

x = int(input())  # нужные для Кати минуты сна
hours = int(input())  # часы, во сколько Катя ложится спать
minutes = int(input())  # минуты, во сколько Катя ложится спать
print((hours * 60 + x + minutes) // 60)  # часы на будильнике
print((minutes + x) % 60)  # минуты на будильнике

# 3-------------------------------------------------------

x = 5
y = 10
print(y > x * x or y >= 2 * x and x < y)

# 4-------------------------------------------------------

a = True
b = False
print(a and b or not a and not b)

# 5-------------------------------------------------------

A = int(input())  # рекомендация сна
B = int(input())  # не стоит спать больше этого времени
H = int(input())  # Аня спит сейчас
if B >= H >= A:
    print('Это нормально')
elif H < A:
    print('Недосып')
else:
    print('Пересып')

# 6-------------------------------------------------------

A = int(input())
if ((A % 4 == 0 and A % 100 != 0) or (A % 400 == 0)):
    print('Високосный')
else:
    print('Обычный')

# 7-------------------------------------------------------

import math

a = int(input())
b = int(input())
c = int(input())
p = (a + b + c) / 2
S = math.sqrt(p * (p - a) * (p - b) * (p - c))
print(S)

# 8-------------------------------------------------------

n = int(input())
if (-15 < n <= 12) or (14 < n < 17) or (n >= 19):
    print(True)
else:
    print(False)

# 9-------------------------------------------------------

A = float(input())
B = float(input())
C = input()
if C == '+':
    print(A + B)
elif C == '-':
    print(A - B)
elif C == '*':
    print(A * B)
elif C == '/' and B == 0:
    print("Деление на 0!")
elif C == '/' and B != 0:
    print(A / B)
elif C == 'mod' and B == 0:
    print('Деление на 0!')
elif C == 'mod' and B != 0:
    print(A % B)
elif C == 'pow':
    print(A ** B)
elif C == 'div' and B == 0:
    print('Деление на 0!')
elif C == 'div' and B != 0:
    print(A // B)

# 10-------------------------------------------------------

import math

t = input()
if t == 'треугольник':
    a = int(input())
    b = int(input())
    c = int(input())
    p = (a + b + c) / 2
    S = math.sqrt(p * (p - a) * (p - b) * (p - c))
    print(S)
elif t == 'прямоугольник':
    a = int(input())
    b = int(input())
    S = a * b
    print(S)
elif t == 'круг':
    r = int(input())
    S = 3.14 * r ** 2
    print(S)

# 11-------------------------------------------------------

a = int(input())
b = int(input())
c = int(input())
s = a + b + c;
print(max(a, b, c))
print(min(a, b, c))
print(s - max(a, b, c) - min(a, b, c))

# 12-------------------------------------------------------

s = input()
sum1 = int(s[0]) + int(s[1]) + int(s[2])
sum2 = int(s[3]) + int(s[4]) + int(s[5])
if sum1 == sum2:
    print('Счастливый')
else:
    print('Обычный')

# 13-------------------------------------------------------

n = int(input())
if n % 10 == 1 and n % 100 != 11:
    print(str(n) + " программист")
elif n % 10 == 2 and n % 100 != 12 or n % 10 == 3 and n % 100 != 13 or n % 10 == 4 and n % 100 != 14:
    print(str(n) + " программиста")
else:
    print(str(n) + " программистов")
