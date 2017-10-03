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
    def __init__(self, v, sol, kruskal, heuristic_cost=0):
        self.v = v
        self.solution = sol
        self.heuristic_cost = heuristic_cost
        self.kruskal = kruskal
        global NUMBER_NODE_CREATED
        NUMBER_NODE_CREATED = NUMBER_NODE_CREATED + 1

        use_heuristique_1 = True # Kruskal
        use_heuristique_2 = True # La distance de la ville actuelle a la ville la plus proche
        use_heuristique_3 = True # La plus petite distance entre une ville non visitee et le point de depart

        self.h = self.solution.cost

        if use_heuristique_1 :
            self.heuristic_cost = self.kruskal.getMSTCost(self.solution, self.v)
            self.h = self.h + self.heuristic_cost
    
        if use_heuristique_2 :
            self.h = self.h + self.closest_unexplored_city_from_current()

        if use_heuristique_3 :
            self.h = self.h + self.closest_unexplored_city_to_source()
    
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

    def closest_unexplored_city_from_current(self):
        if len(self.solution.not_visited)==0:
            return 0
        for edge in self.solution.g.get_sorted_edges():
            if edge.source == self.v and edge.destination in self.solution.not_visited:
                return edge.cost
            elif edge.destination == self.v and edge.source in self.solution.not_visited:
                return edge.cost
        return 0

    def closest_unexplored_city_to_source(self):
        global SOURCE
        if len(self.solution.not_visited)==0:
            return 0
        for edge in self.solution.g.get_sorted_edges():
            if edge.source in self.solution.not_visited and edge.destination == SOURCE:
                return edge.cost
            elif edge.destination in self.solution.not_visited and edge.source == SOURCE:
                return edge.cost
        return 0

def main():
    debut = time.time()
    g = Graph("N10.data")
    Kruskal.kruskal = Kruskal.Kruskal(g)
    heap = Q.PriorityQueue()
    Sol = Solution(g)
    node = Node(SOURCE,Sol,Kruskal.kruskal)
    heap.put(node)

    while not heap.empty():
        node = heap.get()
        if len(node.solution.not_visited) == 0 :
            fin = time.time()
            node.solution.printSol()
            print("number of nodes created :", NUMBER_NODE_CREATED)
            print("number of nodes explored :", NUMBER_NODE_EXPLORED)
            print("duration :", fin-debut, "seconds")
            print("number of comparison :", NUMBER_OF_COMPARISIONS)
            return
        node.explore_node(heap)


def isN2betterThanN1(N1, N2):
    #f1 = N1.solution.cost + 0.8*N1.heuristic_cost + 0.2*N1.closest_unexplored_city_from_current()
    #f2 = N2.solution.cost + 0.8*N2.heuristic_cost + 0.2*N2.closest_unexplored_city_from_current()
    global NUMBER_OF_COMPARISIONS
    NUMBER_OF_COMPARISIONS += 1
    return N2.h < N1.h


if __name__ == '__main__':
    main()
