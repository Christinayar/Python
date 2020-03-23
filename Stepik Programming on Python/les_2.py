# 1-------------------------------------------------------

i = 0
while i <= 10:
    i = i + 1
    print('+', end='  ')
    if i > 7:
        i = i + 2
        print('-')
print(i)

# 2-------------------------------------------------------

i = 0
while i < 5:
    print('*', end='  ')
    if i % 2 == 0:
        print('**', end='  ')
    if i > 2:
        print('***', end='  ')
    i = i + 1

# 3-------------------------------------------------------

number = 1
sum = 0
while number:
    number = int(input())
    sum += number
print(sum)

# 4-------------------------------------------------------

a = int(input())
b = int(input())
d = 1
while d % a != 0 or d % b != 0:
    d += 1
else:
    print(d)

# 5-------------------------------------------------------

a = 0
while a <= 100:
    a = int(input())
    if a > 100:
        break
    if a < 10:
        continue
    print(a)

# 6-------------------------------------------------------

a = int(input())
b = int(input())
s = 0
c = 0
for j in range(a, b + 1):
    if j % 3 == 0:
        s = s + j
        c = c + 1
    j += 1
print(s / c)

# 7-------------------------------------------------------

a, b, c, d = int(input('V ')), int(input('V ')), int(input('V ')), int(input('V '))
for i in range(c, d + 1):
    print('\t', i, end='')
print()
for j in range(a, b + 1):
    print(j, end='\t')
    for k in range(c, d + 1):
        print(j * k, end='\t')
    print()

a = int(input('V '))
b = int(input('V '))
c = int(input('V '))
d = int(input('V '))
print(' ', end='\t')
for i in range(c, d + 1):
    print(i, end='\t')
print()
for j in range(a, b + 1):
    print(j, end='\t')
    for i in range(c, d + 1):
        print(j * i, end='\t')
    print()

# 8-------------------------------------------------------

s = input()
l = len(s)
cnt = 1
for i in range(l):
    if i == (l - 1):
        print(s[i] + str(cnt), end='')
    else:
        if s[i] == s[i + 1]:
            cnt = cnt + 1
        else:
            print(s[i] + str(cnt), end='')
            cnt = 1

dna = input()
print(dna[0], end='')
cnt = 1
for i in range(0, len(dna) - 1):
    if dna[i] == dna[i + 1]:
        cnt += 1
    else:
        print(cnt, end='')
        print(dna[i + 1], end='')
        cnt = 1
print(cnt)

# 9-------------------------------------------------------

students = ['Ivan', 'Masha', 'Sasha']
students += ['Olga']
print(students)
students += 'Olga'
print(students)

# 10-------------------------------------------------------

a = [1, 2, 3]
b = a
print(b)

a[1] = 10
print(b)

b[0] = 20
print(a)

a = [5, 6]
print(b)

# 11-------------------------------------------------------

a = [int(i) for i in input().split()]
s = 0
for i in a:
    s += i
print(s)

print(sum(int(i) for i in input().split()))

# 12-------------------------------------------------------

a = input()
s1 = a.upper().count('c'.upper())
s2 = a.upper().count('g'.upper())
S = s1 + s2
print(S / len(a) * 100)


m = input().lower()
print((m.count('g')+m.count('c'))*100 / len(m))

# 13-------------------------------------------------------

a = [int(i) for i in input('V ').split()]
if len(a) > 1:
    for i in range(len(a)):
        print(a[i - 1] + a[i + 1 - len(a)], end=' ')
else:
    print(a[0])

# 14-------------------------------------------------------

ls = [int(i) for i in input().split()]
for i in set(ls):
    if ls.count(i) > 1:
        print(i, end=' ')


a, b = [int(i) for i in input().split()], ''
a.sort()
for i in range(len(a) - 1):
    if a[i] == a[i + 1] and a[i] != b:
        print(a[i], end=' ')
        b = a[i]

# 15-------------------------------------------------------

s, d = 0, 0
while True:
    a = int(input())
    s += a
    d += a * a
    if s == 0:
        break
print(d)


sum = int(input('V '))
sqr = sum ** 2
while sum != 0:
    a = int(input('W '))
    sum += a
    sqr += a ** 2
print(sqr)


# 16-------------------------------------------------------

lst = [int(i) for i in input('W ').split()]
x = int(input('V '))

for i in range(len(lst)):
    if x == lst[i]:
        print(i, end=' ')

if x not in lst:
    print('Отсутствует')

# 17-------------------------------------------------------

a = []
b = input()
while b != "end":
    a.append(b.split())
    b = input()
for i in range(len(a)):
    for j in range(len(a[i])):
        print(int(a[i - 1][j]) + int(a[i - len(a) + 1][j]) + int(a[i][j - 1]) + int(a[i][j - len(a[i]) + 1]), end=" ")
    print()
