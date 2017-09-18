import Queue as Q
import time

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

    node.solution.fast_generate_solution()

    node.solution.printSol()


if __name__ == '__main__':
    main()
