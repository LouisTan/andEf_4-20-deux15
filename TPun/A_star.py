#from heapqueue.binary_heap import BinaryHeap
import queue as Q
import time

from Graph import Graph
import Kruskal
from Solution import Solution

SOURCE = 0

NUMBER_NODE_CREATED = 0
NUMBER_NODE_EXPLORED = 0

class Node(object):
    def __init__(self, v, sol, kruskal, heuristic_cost=0):
        self.v = v
        self.solution = sol
        self.heuristic_cost = heuristic_cost
        self.kruskal = kruskal
        global NUMBER_NODE_CREATED
        NUMBER_NODE_CREATED = NUMBER_NODE_CREATED + 1

        self.heuristic_cost = self.kruskal.getMSTCost(self.solution, self.v)
    
    def __lt__(self, other):
        return isN2betterThanN1(other,self)

    def explore_node(self, heap):
        global NUMBER_NODE_EXPLORED
        NUMBER_NODE_EXPLORED = NUMBER_NODE_EXPLORED + 1
        for node in self.solution.not_visited:
            if len(self.solution.not_visited) == 1 or node != SOURCE :   
                Sol = Solution(self.solution)
                v = self.v
                Sol.add_edge(v,node)
                nodeToAdd = Node(node,Sol, self.kruskal)
                heap.put(nodeToAdd)

def main():
    debut = time.time()
    g = Graph("N17.data")
    Kruskal.kruskal = Kruskal.Kruskal(g)
    heap = Q.PriorityQueue()
    Sol = Solution(g)
    node = Node(SOURCE,Sol,Kruskal.kruskal)
    heap.put(node)

    while not heap.empty():
        node = heap.get()
        if len(node.solution.not_visited) == 0 :
            fin = time.time()
            node.solution.print()
            print("number of nodes created :", NUMBER_NODE_CREATED)
            print("number of nodes explored :", NUMBER_NODE_EXPLORED)
            print("duration :", fin-debut, "secondes")
            return
        node.explore_node(heap)


def isN2betterThanN1(N1, N2):
    f1 = N1.solution.cost + N1.heuristic_cost
    f2 = N2.solution.cost + N2.heuristic_cost
    return f2 < f1


if __name__ == '__main__':
    main()
