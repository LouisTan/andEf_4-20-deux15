#from heapqueue.binary_heap import BinaryHeap
import queue as Q

from Graph import Graph
import Kruskal
from Solution import Solution

SOURCE = 0

class Node(object):
    def __init__(self, v, sol, heuristic_cost=0):
        self.v = None
        self.solution = None
        self.heuristic_cost = None

    def explore_node(self, heap):
        raise NotImplementedError()


def main():
    g = Graph("N15.data")
    Kruskal.kruskal = Kruskal.Kruskal(g)
    heap = Q.PriorityQueue()
    Sol = Solution(g)
    Sol.add_edge(0,5)
    Sol.add_edge(5,2)
    Sol.add_edge(2,3)
    Sol.add_edge(3,0)
    Sol.print()


def isN2betterThanN1(N1, N2):
    raise NotImplementedError


if __name__ == '__main__':
    main()
