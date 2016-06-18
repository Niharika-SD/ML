mport csv

import random

import math

def load_Csv(filename):

lines = csv.reader(open(filename, "rb"))

dataset = list(lines)

for j in range(len(dataset)):

dataset[j] = [float(x) for x in dataset[j]]

return dataset

def split_dataset(dataset, split_Ratio):

lol = lambda lst, sz: [lst[i:i+sz] for i in range(0, len(lst), sz)]

return lol(dataset,split_Ratio)

def separate_By_Class(dataset):

separate = {}

for i in range(len(dataset)):

vector = dataset[i]

if (vector[-1] not in separated):

separate[vector[-1]] = []

separate[vector[-1]].append(vector)

return separate

def mean(num):

return sum(num)/float(len(num))

def stdev(num):

avg = mean(num)

var = sum([pow(x-avg,2) for x in num])/float(len(num)-1)

return math.sqrt(var)

def summarize(dataset):

summaries = [(mean(attribute), stdev(attribute)) for attribute in zip(*dataset)]

del summaries[-1]

return summaries

def summarizeByClass(dataset):

separated = separate_By_Class(dataset)

summaries = {}

for classValue, instances in separated.iteritems():

summaries[classValue] = summarize(instances)

return summaries

def calculateProbability(x, mean, stdev):

expo = math.exp(-(math.pow(x-mean,2)/(2*math.pow(stdev,2))))

return (1 / (math.sqrt(2*math.pi) * stdev)) * expo

def calculateClassProbabilities(summaries, inputVector):

probabilities = {}

for classValue, classSummaries in summaries.iteritems():

probabilities[classValue] = 1

for i in range(len(classSummaries)):

mean, stdev = classSummaries[i]

x = inputVector[i]

probabilities[classValue] *= calculateProbability(x, mean, stdev)

return probabilities

def predict(summaries, inputVector):

probabilities = calculateClassProbabilities(summaries, inputVector)

bestLabel, bestProb = None, -1

for classValue, probability in probabilities.iteritems():

if bestLabel is None or probability > bestProb:

bestProb = probability

bestLabel = classValue

return bestLabel

def getPredictions(summaries, testset):

predictions = []

for i in range(len(testset)):

result = predict(summaries, testset[i])

predictions.append(result)

return predictions

def getError(testset, predictions):

w = 0

for i in range(len(testset)):

if testset[i][-1] != predictions[i]:

wrong += 1

return (w/float(len(testset))) * 100.0

def main():

filename = 'data.csv'

dataset = load_Csv(filename)

Error = 0

for i in range(0,3):

splitRatio = len(dataset)/3

sets= split_dataset(dataset, splitRatio)

#model

train = []

for x in range(0,3):

if(x!=i):

train += sets[x]

summaries = summarizeByClass(train)

test = sets[i]

predictions = getPredictions(summaries, test)

Error += getError(test, predictions)

print('Error for k =3: {0}%').format(Error/3)

Error =0

for i in range(0,5):

splitRatio = len(dataset)/5

sets= split_dataset(dataset, splitRatio)

# prepare model

train = []

for x in range(0,3):

if(x!=i):

train += sets[x]

summaries = summarizeByClass(train)

test = sets[i]

predictions = getPredictions(summaries, test)

Error += getError(test, predictions)

print('Error for k =5: {0}%').format(Error/5)

Error = 0

for i in range(0,10):

splitRatio = len(dataset)/10

sets= split_dataset(dataset, splitRatio)

# prepare model

train = []

for x in range(0,3):

if(x!=i):

train += sets[x]

summaries = summarizeByClass(trainingSet)

test = sets[i]

predictions = getPredictions(summaries, test)

Error += getError(test, predictions)

print('Error for K = 10: {0}%').format(Error/10)

main()
