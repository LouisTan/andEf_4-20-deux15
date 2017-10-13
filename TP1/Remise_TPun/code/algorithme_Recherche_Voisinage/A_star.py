import queue as Q
import time
import random
from math import exp

from Graph import Graph
import Kruskal
from Solution import Solution
#from heapqueue.binary_heap import BinaryHeap

SOURCE = 0

NUMBER_NODE_CREATED = 0
NUMBER_NODE_EXPLORED = 0

NUMBER_OF_COMPARISIONS = 0

class Node(object):
    def __init__(self, v, sol):
        self.v = v
        self.solution = sol
        global NUMBER_NODE_CREATED
        NUMBER_NODE_CREATED = NUMBER_NODE_CREATED + 1

    def explore_node(self, heap):
        global NUMBER_NODE_EXPLORED
        NUMBER_NODE_EXPLORED = NUMBER_NODE_EXPLORED + 1
        for node in self.solution.not_visited:
            if len(self.solution.not_visited) == 1 or node != SOURCE :   
                Sol = Solution(self.solution)
                v = self.v
                Sol.add_edge(v,node)
                nodeToAdd = Node(node,Sol)
                heap.put(nodeToAdd)

def main():
    debut = time.time()
    g = Graph("N17.data")

    Sol = Solution(g)
    node = Node(SOURCE,Sol)

    node.solution.random_generate_solution()

    #print("initial random solution : ")

    #node.solution.printSolConsideringEdges()

    T = 1000
    betterSolutions = 0
    randomChange = 0

    while T > 1:
        Sol2 = node.solution.generate_random_neighbor()
        diffCost = node.solution.cost - Sol2.cost
        if (diffCost >= 0) :
            node.solution = Sol2
            betterSolutions = betterSolutions + 1
            #print("better solution found")
        else :
            random_number = random.random()
            probability_to_change = exp(diffCost/T)
            if (random_number < probability_to_change):
              node.solution = Sol2  
              randomChange = randomChange + 1
              #print("random change")

        T = 0.999*T

    #print("final solution : ")

    node.solution.printSolConsideringEdges()

    fin = time.time()

    print("number of better solutions found : ", betterSolutions)
    print("number of random changes : ", randomChange)
    print("duration :", fin-debut, "seconds")

if __name__ == '__main__':
    main()
