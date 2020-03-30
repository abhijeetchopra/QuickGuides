"""
# Auth: Abhijeet Chopra
# Date: Sat Sep 23, 2017
# Desc: Quick Python Guide
"""
# declaring and initializing variables
name = 'Abhijeet'
height = 5.4
age = 24
alive = True

# displaying data types
type(name)       # string
type(height)     # float
type(age)        # int
type(alive)      # bool

# print the type of name
print(type(name))

# adding two integers
n1 = 4
n2 = 6
n1 + n2

# adding two strings
s1 = 'Abhijeet'
s2 = 'Chopra'
s1 + s2

# printing values
print(n1)
print(s1)

# exponential is **
n3 = 2**3

# string conversion using str()
n4 = 1.23456
s3 = str(n4)
print(s3)

# float conversion using float()
pi_string = "3.1415926"
pi_float = float(pi_string)

# python list
[1.73, 1.68, 1.71, 1.89]

# python list with a name
family = ['Ram Parkash', 'Pushpa', 'Rajan', 'Taruni', 'Abhijeet'. 'Rachna']

# python list with different data types
prices = ['Milk', 5.49 , Onion , 2.29 , Tomato , 3.19]

prices # printing

# python sub-lists
prices_2 = [
    ["Milk", 5.49],
	["Onion",2.29],
	["Tomato",3.19]
]

prices_2 # printing

# python list printing via index (Zero Based Indexing)
prices[0]
prices[1]
prices[2]

# python list negative indexing (element from last)
prices[-1] # prices[-0] is same as prices[0] i.e. first element
prices[-2]
prices[-3]

# python list slicing (selecting multiple elements)
prices[1:4] # prints elements from index 1 to before 4 i.e. at 1,2,3
prices [:4] # prints elements from index 0 to before 4 i.e. at 0,1,2,3

prices[:4]  # first 4 elements i.e. at 0,1,2,3
prices[-4:] # last 4 elements i.e. at -4,-3,-2,-1

# python list adding elements
prices_ext = prices + ["Potato", 1.49]
print(prices_ext)

# python list deleting elements
del(prices_ext[-1])
del(prices_ext[-1])
print(prices_ext)

# python list = is default as pass by reference 
x = ["a","b","c"]
y = x # creates new REFERENCE to the list x

y[1] = "z" # changing second element of list y

y # ['a', 'z', 'c'] 
x # ['a', 'z', 'c']  # even 2nd element of x has changed because it was the same object referenced by both x and y, so if you changed the object referenced by y, that is the same object referenced by x.

# python list list() creates a new list object 
yy = list(x) # creates new list yy with contents of x

# python list slicing also creates new list
yyy = x[:] # creates new list yyy with contents of x

# python semicolons
command1 # Separate lines
command2

command1; command2 # Same line

""" PYTHON METHODS """

# python functions
list_numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
max(list_numbers) # prints maximum value from list
round(pi_float,2) # prints pi rounded to two decimals place
round(pi_float)   # no arguments, prints closest int

# documentation
help(round)

# python list length with len()
print(len(list_numbers))

# python list sorting with sorted()
sorted(list_numbers, reverse = True)

# python list method: list.index()
list_number_names = ["one", "two", "three", "four", "one", "two"]
list_number_names.index("three") # prints index of element with content "three"
# sometimes you have to use print() command in conjunction to print that value

list_number_names.count("three") # prints frequency of occurence of "three"

# python list method: list.append()
list_number_names.append(21)
list_number_names.append(22)

# python list method: reverse() method
list_number_names.reverse() # reverses the list

# python string method: str.capitalize()
string_1 = "i am feeling sleepy"
string_1.capitalize() # "I am feeling sleepy"

# python string method: str.capitalize()
string_1.upper() # "I AM FEELING SLEEPY"

# python string method: str.replace()
string_1.replace("sleepy", "lethargic")


""" PYTHON DATA STRUCTURES

1.  () - tuple
2.  [] - list
3.  {} - dictionary

"""





""" PYTHON PACKAGES

1. Numpy          -   Arrays
2. Matplotlib     -   Data Visualization
3. Scikit-learn   -   Machine Learning

"""
# installing pip (package maintenance system for python)
# URL       http://pip.readthedocs.org/en/stable/installing
# DOWNLOAD  get-pip.py
python3 get-pip.py

# installing numpy
pip3 install numpy

# importing numpy
import numpy

# creating array using numpy
numpy.array([1,2,3]) # package_name.function_name

# selecting package import (note to self: not recommended)
from numpy import array
array([1,2,3]) # now you can directly use array

# math
import math
r = 10
area = math.pi * (r**2) # area = pi*(r^2)

"""
Why use Numpy?

Python is not vectorized, i.e. operations in Python are not performed on vectors. You cannot multipy list and an int (vector * scalar)

So we use Arrays in Numpy that give us this functionality
"""

# python list
py_height = [1.73, 1.68, 1.71, 1.89, 1.79]
py_weight = [65.4, 59.2, 63.6, 88.4, 68.7]

# python list --> numpy array

# numpy array
import numpy as np

# creating numpy array from python list
np_height = np.array(py_height)
np_height

np_weight = np.array(py_weight)
np_weight

# invalid python list operation
bmi = np_weight / np_height ** 2 # you could't do this with python lists
bmi

# python list vs numpy array on +
py_height + py_weight # outputs merged array

np_height + np_weight # outputs array with sum of both

# numpy array selection
bmi > 23 # returns array with boolean true if condition satisfied

bmi[bmi > 23] # returns array with only elements satisfying condition


""" PYTHON CONDITIONAL STATEMENTS """

# inline if else / ternary operator

x = 1
print("true") if x==1 else print("false")
# >> true

x = 2
print("true") if x==1 else print("false")
# >> false


DEGUB = True # imp! True with a capital 'T'
print("true") if(DEBUG) else None # None returns nothing

# multi-line if else
y = 5
if(y==5):
    print("true") # NOTE: indentation of four spaces. Proper indentation required.
else:
    print("false");

# printing multiple variables in one line
print("x : ", x, " y : ", y) # each print command prints in a separate line
print("x : ", x, " y : ", y) # this would print in the next line than previous


""" END OF FILE
-------------------------------------"""