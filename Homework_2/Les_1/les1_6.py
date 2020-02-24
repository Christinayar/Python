count = int(input('В первый день спортсмен пробежал (км): '))
new_count = int(input('Он должен пробежать (км): '))

day = 1
while count < new_count:
    count = (count * 0.1) + count
    day += 1
    print(f"Спортсмен пробежит {(count):.2f} км на {day} день")