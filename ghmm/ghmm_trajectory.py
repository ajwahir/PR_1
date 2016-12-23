# -*- coding: utf-8 -*-
"""
@author: Ajwahir
"""
import numpy as np
import math
from os import listdir
from os.path import join
import warnings
from hmmlearn import hmm
warnings.filterwarnings("ignore")



classpath=[]
train_path=[]
val_path=[]
test_path=[]
train_data=[]
test_path=[]
val_data=[]
test_data=[]
file_data=[]

datapath = '/home/ajwahir/acads/pr/assignment/Dataset_Assignment1/Dataset-1_2Dimensional/Trajectory Dataset/Trajectory_data/'

classpath.append(join(datapath,'class3/'))
classpath.append(join(datapath,'class7/'))
classpath.append(join(datapath,'class2/'))

for i in range(0,len(classpath)):   
    intermediate=[]
    for f in listdir(classpath[i]):
        intermediate.append(join(classpath[i],f))
    file_data.append(intermediate)

    
for i in range(0,len(classpath)):
    data1=[]
    data2=[]
    data3=[]
    data1=file_data[i][0:int(math.floor(len(file_data[i])*0.75))]
    data2=file_data[i][int(math.floor(len(file_data[i])*0.75)):int(math.floor(len(file_data[i])*0.75))+int(math.floor(len(file_data[i])*0.15))]
    data3=file_data[i][int(math.floor(len(file_data[i])*0.75))+int(math.floor(len(file_data[i])*0.15)):]
    train_data.append(data1)
    val_data.append(data2)
    test_data.append(data3)
 
gen=[]
train=[]
test=[]
val=[]


for i in range(0,len(train_data)):   
    interline=[]
    for f in train_data[i]:
        file=open(f,'r')
        intermediate=[]
        for line in file:
            words = line.split(',')
            intermediate.append(map(float,words))
        interline.append(intermediate)
    train.append(interline)

for i in range(0,len(val_data)):   
    interline=[]
    for f in val_data[i]:
        file=open(f,'r')
        intermediate=[]
        for line in file:
            words = line.split(',')
            intermediate.append(map(float,words))
        interline.append(intermediate)
    val.append(interline)

for i in range(0,len(test_data)):   
    interline=[]
    for f in test_data[i]:
        file=open(f,'r')
        intermediate=[]
        for line in file:
            words = line.split(',')
            intermediate.append(map(float,words))
        interline.append(intermediate)
    test.append(interline)


train_lengths=[]
val_lengths=[]
test_lengths=[]

for i in range(0,len(train)):
    intermediate=[]
    for j in range(0,len(train[i])):
        intermediate.append(len(train[i][j]))
    train_lengths.append(intermediate)

for i in range(0,len(val)):
    intermediate=[]
    for j in range(0,len(val[i])):
        intermediate.append(len(val[i][j]))
    val_lengths.append(intermediate)

for i in range(0,len(test)):
    intermediate=[]
    for j in range(0,len(test[i])):
        intermediate.append(len(test[i][j]))
    test_lengths.append(intermediate)

gen=[]
train=[]
test=[]
val=[]

for i in range(0,len(train_data)):   
    interline=[]
    for f in train_data[i]:
        file=open(f,'r')
        # intermediate=[]
        for line in file:
            words = line.split(',')
            interline.append(map(float,words))
        # interline.append(intermediate)
    train.append(interline)

for i in range(0,len(val_data)):   
    interline=[]
    for f in val_data[i]:
        file=open(f,'r')
        # intermediate=[]
        for line in file:
            words = line.split(',')
            interline.append(map(float,words))
        # interline.append(intermediate)
    val.append(interline)

for i in range(0,len(test_data)):   
    interline=[]
    for f in test_data[i]:
        file=open(f,'r')
        # intermediate=[]
        for line in file:
            words = line.split(',')
            interline.append(map(float,words))
        # interline.append(intermediate)
    test.append(interline)


# Training the models for 3
# print len(train[0])
# print len(train_lengths[0])
hmms=[]
# prob=[]
predict_class=[]
for i in range(0,len(train)):
    hmms.append(hmm.GaussianHMM(n_components=3).fit(train[i],train_lengths[i]))


for j in range(0,len(test)):
    prob=[]
    for i in range(0,len(hmms)):
        prob.append(hmms[i].score(test[j],test_lengths[j]))
    f=np.where(prob==np.max(prob))
    predict_class.append(f[0][0])

# prob=[]
# for i in range(0,len(hmms)):
#         prob.append(hmms[i].score(test[2],test_lengths[2]))
# print prob
print predict_class
# print np.max(pro  b)
# print f[0][0]


    
# X1 = [[0.5], [1.0], [-1.0], [0.42], [0.24]]
# X2 = [[2.4], [4.2], [0.5], [-0.24]]
# X = np.concatenate([X1, X2])
# lengths = [len(X1), len(X2)]
# #X=np.concatenate(([lengths],[X]),axis=0)
# some=hmm.GaussianHMM(n_components=3).fit(X,lengths) 
# # print X
# # print lengths
# # print gen