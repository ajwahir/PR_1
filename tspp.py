import random
import math

def eval_cost(tour_for_cost):
	cost = 0
	for tour_index in range(0,len(coordinates)):
		if tour_index<len(coordinates)-1:
			successor=tour_index+1
		else:
			successor=0
		cost=cost+edges_matrix[tour_for_cost[tour_index]][tour_for_cost[successor]]
	return cost

def sigmoid(detla_e,T):
	P=1/(1+math.exp(detla_e/T))
	return P

def RandomSwap(tour_array):
	i=random.randint(0,len(tour_array)-1)
	j=random.randint(0,len(tour_array)-1)
	child_array=swap(i,j,tour_array)
	return child_array

def swap(i,j,swap_array):
	temp=swap_array[i]
	swap_array[i]=swap_array[j]
	swap_array[j]=temp
	return swap_array

euc100 = open('/home/ajwahir/acads/AI/assignment1/problems/euc_100'	, 'r')
coordinates =[]
edges_matrix=[]
cooling_rate=0.999
T=1*math.pow(10,18)

for line in euc100:
	words = line.split()
	if len(words)==2:
		coordinates.append(map(float,words))
	elif len(words)==len(coordinates):
		edges_matrix.append(map(float,words))

tour = range(0,len(coordinates))
tour = random.sample(tour,len(tour))
best_cost = eval_cost(tour)

while 1:
	epoch=100
	while epoch>0:
		new_node=tour
		tour_cost=eval_cost(tour)
		delta_e=eval_cost(RandomSwap(new_node))-tour_cost
		P=sigmoid(delta_e,T)
		if P>random.random():
			tour=new_node
		if eval_cost(new_node)<best_cost:
			best_cost=eval_cost(new_node)
			print best_cost
		epoch=epoch-1
	T=T*cooling_rate

