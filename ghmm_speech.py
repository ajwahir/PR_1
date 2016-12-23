# -*- coding: utf-8 -*-
"""
@author: Ajwahir
"""
import numpy as np
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

datapath = '/home/ajwahir/acads/pr/assignment/codes/Team16/'
for f in listdir(datapath):
    classpath.append(join(datapath,f))
number_of_classes = len(listdir(datapath))

for f in classpath:
    train_path.append(join(f,'Train'))
    val_path.append(join(f,'Train'))    
    test_path.append(join(f,'Train'))

for i in range(0,len(train_path)):   
    intermediate=[]
    for f in listdir(train_path[i]):
        intermediate.append(join(train_path[i],f))
    train_data.append(intermediate)
    
for i in range(0,len(val_path)):   
    intermediate=[]
    for f in listdir(val_path[i]):
        intermediate.append(join(val_path[i],f))
    val_data.append(intermediate)

for i in range(0,len(test_path)):   
    intermediate=[]
    for f in listdir(test_path[i]):
        intermediate.append(join(test_path[i],f))
    test_data.append(intermediate)

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
            words = line.split()
            if len(words)==2:
                gen.append(map(float,words))
            else:
                intermediate.append(map(float,words))
        interline.append(intermediate)
    train.append(interline)

for i in range(0,len(val_data)):   
    interline=[]
    for f in val_data[i]:
        file=open(f,'r')
        intermediate=[]
        for line in file:
            words = line.split()
            if len(words)==2:
                gen.append(map(float,words))
            else:
                intermediate.append(map(float,words))
        interline.append(intermediate)
    val.append(interline)

for i in range(0,len(test_data)):   
    interline=[]
    for f in test_data[i]:
        file=open(f,'r')
        intermediate=[]
        for line in file:
            words = line.split()
            if len(words)==2:
                gen.append(map(float,words))
            else:
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
            words = line.split()
            if len(words)==2:
                gen.append(map(float,words))
            else:
                interline.append(map(float,words))
        # interline.append(intermediate)
    train.append(interline)

for i in range(0,len(val_data)):   
    interline=[]
    for f in val_data[i]:
        file=open(f,'r')
        # intermediate=[]
        for line in file:
            words = line.split()
            if len(words)==2:
                gen.append(map(float,words))
            else:
                interline.append(map(float,words))
        # interline.append(intermediate)
    val.append(interline)

for i in range(0,len(test_data)):   
    interline=[]
    for f in test_data[i]:
        file=open(f,'r')
        # intermediate=[]
        for line in file:
            words = line.split()
            if len(words)==2:
                gen.append(map(float,words))
            else:
                interline.append(map(float,words))
        # interline.append(intermediate)
    test.append(interline)

# Training the models for 10 
# print train[0]
# print train_lengths[0]
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