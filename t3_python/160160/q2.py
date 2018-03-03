import numpy as np
from matplotlib import pyplot as plt

def file_len(fname):
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return i

def step1():
    data = np.genfromtxt('train.csv', dtype=float, delimiter=',', names=True)
    data = data.view(np.float64).reshape(len(data), -1)
    data = np.hsplit(data,2)
    x_train = data[0]
    y_train = data[1]
    x_train = np.insert(x_train,0,1,axis=1)
    return [x_train,y_train]

def step2():
    random = np.random.rand(2,1)
    return random

def step3():
    data = step1()
    x_train = np.hsplit(data[0],2)[1]
    y_train = data[1]
    plt.title("Matplotlib step3")
    plt.xlabel("x features")
    plt.ylabel("y label")
    plt.plot(x_train,y_train)

    x_ = data[0].transpose()
    w = step2()
    y_plot = np.matmul(w.transpose(),x_).transpose()
    x_plot = x_train
    plt.plot(x_plot,y_plot)

    plt.show()

def step4():
    data = step1()
    x_train = data[0]
    x_feature = np.hsplit(data[0],2)[1]
    y_train = data[1]
    p=np.matmul(x_train.transpose(),x_train)
    inverse = np.linalg.inv(p)
    w_direct = np.matmul(inverse,np.matmul(x_train.transpose(),y_train))

    plt.title("Matplotlib step4")
    plt.xlabel("x axis")
    plt.ylabel("y axis")
    plt.plot(x_feature,y_train)

    x_ = data[0].transpose()
    y_plot = np.matmul(w_direct.transpose(),x_).transpose()
    x_plot = x_feature
    plt.plot(x_plot,y_plot,'yellow')

    plt.show()

def step5(mode):
    w = step2()
    data = step1()
    x_feature = np.hsplit(data[0],2)[1]
    y_label = data[1]
    plt.title("Matplotlib step5")
    plt.xlabel("x axis")
    plt.ylabel("y axis")
    for k in range(2):
        for j in range(file_len('train.csv')):
            x_ = np.array([[1,x_feature[j]]]).transpose()
            eta =  0.00000001
            w = np.subtract(w, ((eta * (np.matmul(w.transpose(),x_)[0] - y_label[j])) * x_))

            if j% 100 ==0:
                #print("this is x")
                #print(x_)
                #print("lsgfd")
                #print(   ((eta * (np.matmul(w.transpose(),x_)[0] - y_lebel[j])) * x_) )
                #print(w)
                x_ = data[0].transpose()
                y_plot = np.matmul(w.transpose(),x_).transpose()
                x_plot = x_feature
                if k==1:
                    plt.plot(x_plot,y_plot,'red')
                else:
                    plt.plot(x_plot,y_plot,'yellow')

    if mode=="PLOT":
        plt.show()
    if mode=="API":
        return w

def step6():
    w = step5("API")

    data = step1()
    x_feature = np.hsplit(data[0],2)[1]
    y_label = data[1]
    plt.clf()
    plt.title("Matplotlib step6")
    plt.xlabel("x axis")
    plt.ylabel("y axis")

    plt.plot(x_feature,y_label)

    x_ = data[0].transpose()
    y_plot = np.matmul(w.transpose(),x_).transpose()
    x_plot = x_feature
    plt.plot(x_plot,y_plot,'yellow')
    plt.show()


def step7_1():
    data = np.genfromtxt('test.csv', dtype=float, delimiter=',', names=True)
    data = data.view(np.float64).reshape(len(data), -1)
    data = np.hsplit(data,2)
    x_test = data[0]
    y_test = data[1]
    x_test = np.insert(x_test,0,1,axis=1)
    return [x_test,y_test]

def step7():
    test = step7_1()
    x_test = test[0]
    y_test = test[1]
    w = step5("API")
    y_pred1 = np.matmul(x_test,w)
    mse1 = np.sqrt(((y_pred1 - y_test) ** 2).mean(axis=0))
    print("mse-regression")
    print(mse1)

    data = step1()
    x_train = data[0]
    y_train = data[1]
    p=np.matmul(x_train.transpose(),x_train)
    inverse = np.linalg.inv(p)
    w_direct = np.matmul(inverse,np.matmul(x_train.transpose(),y_train))
    y_pred2 = np.matmul(x_test,w_direct)
    mse2 = np.sqrt(((y_pred2 - y_test) ** 2).mean(axis=0))
    print("mse-direct")
    print(mse2)


print("running step1")
step1()
print("running step2")
step2()
print("running step3")
step3()
print("running step4")
step4()
print("running step5")
step5("PLOT")
print("running step6")
step6()
print("running step7")
step7()
