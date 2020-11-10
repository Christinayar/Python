numbers = [1, 5, -9, 10, 27, 8, 17, 45, 100, 11, -7, 12, -27]

result = [number for number in numbers if number > 0 and number % 3 == 0 and number % 4 != 0]

print(result)