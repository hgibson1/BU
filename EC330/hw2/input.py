import random

N = 20

with open('input.txt', 'w') as dataset:
	for _ in range(0, N):
		datastr = " ".join([str(random.randint(-2147483647, 2147483647)) for _ in range(0, 100)])
		dataset.write(datastr + ' -999999\n')
