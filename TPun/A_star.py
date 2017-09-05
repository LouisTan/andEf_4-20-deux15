#from heapqueue.binary_heap import BinaryHeap
import queue as Q

from Graph import Graph
import Kruskal
from Solution import Solution

SOURCE = 0

class Node(object):
    def __init__(self, v, sol, heuristic_cost=0):
        self.v = v
        self.solution = sol
        self.heuristic_cost = heuristic_cost

    def explore_node(self, heap):
        for node in self.solution.not_visited:    
            Sol = Solution(self.solution)
            v = self.v
            Sol.add_edge(v,node)
            nodeToAdd = Node(node,Sol,self.heuristic_cost)
            heap.put(nodeToAdd)


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
    f1 = N1.solution.cost + N1.heuristic_cost
    f2 = N2.solution.cost + N2.heuristic_cost
    return f2 < f1


if __name__ == '__main__':
    main()
