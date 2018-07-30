n = 0

for i in range(16):
    a = (n + 6) % 16 
    b = (a + 7) % 16
    c = (b + 6) % 16

    result = (n + a + b + c) * 4
    print(result)
    n = (c + 1) % 16