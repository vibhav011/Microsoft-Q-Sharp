import json

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as colors
import matplotlib.cm as cmx

with open('data7.json') as f:
		data = json.load(f)

ar0 = [[], []]
ar1 = [[], []]

vectors = data['Features']
labels = data['Labels']

# vectors = data['TrainingData']['Features']
# labels = data['TrainingData']['Labels']

for i in range(len(labels)) :
	if labels[i] == 0:
		ar0[0].append(vectors[i][0])
		ar0[1].append(vectors[i][1])
	else :
		ar1[0].append(vectors[i][0])
		ar1[1].append(vectors[i][1])

plt.plot(ar0[0], ar0[1], 'r.', ar1[0], ar1[1], 'b.')
plt.show()
