import numpy as np
from matplotlib import pyplot as plotter
import math

# STEP 1

mode = 'r'
file = 'train.csv'
fo = open(file, mode)

x = np.zeros((10000, 1))
y = np.zeros((10000, 1))

i = 0

line = fo.readline()
line = fo.readline()

while line:
    (x[i], y[i]) = line.split(',')
    line = fo.readline()
    i += 1

#file = np.genfromtxt("train1.csv", float, delimiter=',', names=True)

new_x = np.insert(x, 0, 1, 1)



# STEP 2

w = np.random.rand(2, 1)



# STEP 3

plotter.title("Step-3")
plotter.xlabel("features")
plotter.ylabel("labels")
plotter.plot(x, y)

plot3_y = np.dot(w.transpose(), new_x.transpose())
plotter.plot(x.transpose(), plot3_y)

plotter.show()



# STEP 4

wd1 = np.dot(new_x.transpose(), new_x)
wd1 = np.linalg.inv(wd1)
wd2 = np.dot(new_x.transpose(), y)
w_direct = np.dot(wd1, wd2)

plotter.title("Step-4")
plotter.xlabel("features")
plotter.ylabel("labels")
plotter.plot(x, y)

plot3_y = np.dot(w_direct.transpose(), new_x.transpose())
plotter.plot(x.transpose(), plot3_y)

plotter.show()




# STEP 5

plotter.title("Step-5")
plotter.xlabel("features")
plotter.ylabel("labels")

w2 = np.random.rand(2, 1)

for j in range(1, 2):
    for i in range(0, 10000):
        x5 = np.concatenate(([[1]], [x[i]]), axis=1).transpose()
        eta = 0.00000001
        w2 = w2 - eta*np.dot(x5, (np.dot(w2.transpose(), x5) - [y[i]]))
        plot5_y = np.dot(w2.transpose(), x5)

        if (i+1) % 100 is 0:
            plotter.plot([x[i]], plot5_y)

plotter.plot(x, y)
plotter.show()




# STEP 6

plotter.title("Step-6")
plotter.xlabel("features")
plotter.ylabel("labels")

plot6_y = np.dot(w2.transpose(), new_x.transpose())
plotter.plot(x.transpose(), plot6_y)

#plotter.plot(x, w2)
plotter.plot(x, y)

plotter.show()

# STEP 7

mode = 'r'
file1 = 'test.csv'
fo1 = open(file1, mode)

x7 = np.zeros((10000, 1))
y7 = np.zeros((10000, 1))

i = 0

line1 = fo1.readline()
line1 = fo1.readline()

while line1:
    (x7[i], y7[i]) = line1.split(',')
    line1 = fo.readline()
    i += 1

#new_file = np.genfromtxt('test.csv', dtype=float, delimiter=',', names=True)

new_x7 = np.insert(x7, 0, 1, 1)

y_pred1 = np.dot(new_x7, w2)
rms_error = ((y_pred1 - y7) ** 2).mean(axis=0)

y_pred2 = np.dot(new_x7, w_direct)
rms_error2 = ((y_pred2 - y7) ** 2).mean(axis=0)

print("Error-1 = %f , Error-2 = %f" % (math.sqrt(rms_error), math.sqrt(rms_error2)))
