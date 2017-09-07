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
    
    def __lt__(self, other):
        return isN2betterThanN1(other,self)

    def explore_node(self, heap):
        for node in self.solution.not_visited:
            if len(self.solution.not_visited) == 1 or node != SOURCE :   
                Sol = Solution(self.solution)
                v = self.v
                Sol.add_edge(v,node)
                nodeToAdd = Node(node,Sol,self.heuristic_cost)
                heap.put(nodeToAdd)


def main():
    g = Graph("N12.data")
    Kruskal.kruskal = Kruskal.Kruskal(g)
    heap = Q.PriorityQueue()
    Sol = Solution(g)
    node = Node(SOURCE,Sol,0)
    heap.put(node)

    while not heap.empty():
        node = heap.get()
        if len(node.solution.not_visited) == 0 :
            node.solution.print()
            return
        node.explore_node(heap)


def isN2betterThanN1(N1, N2):
    f1 = N1.solution.cost + N1.heuristic_cost
    f2 = N2.solution.cost + N2.heuristic_cost
    return f2 < f1


if __name__ == '__main__':
    main()
