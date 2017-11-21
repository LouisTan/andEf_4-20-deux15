import numpy as np
import itertools as it

from Graph import Graph
from Solution import Solution

SOURCE = 0


class ACO(object):
    def __init__(self, q0, beta, rho, phi, K, data):
        self.parameter_q0 = q0
        self.parameter_beta = beta
        self.parameter_rho = rho
        self.parameter_phi = phi
        self.parameter_K = K

        self.graph = Graph(data)
        self.best = Solution(self.graph)
        self.best.cost = 99999999999999
        self.pheromone_init = np.ones((self.graph.N, self.graph.N))
        f = open(data + '_init', 'r')
        self.pheromone_init *= float(f.readline())
        self.pheromone = np.ones((self.graph.N, self.graph.N))

    def get_next_city(self, sol):
        raise NotImplementedError()

    def heuristic2opt(self, sol):
        best_distance = sol.cost
        print('> Best distance so far is %d ' % sol.cost)

        for values in it.permutations(sol.visited[:-1]):
            sol.visited = list(values)
            sol.visited.append(SOURCE)
            new_distance = sol.get_cost(SOURCE)
            if new_distance < best_distance:
                sol.cost = new_distance
                best_distance = new_distance
                print('> Best distance so far is %d ' % sol.cost)

    def global_update(self, sol):
        raise NotImplementedError()

    def local_update(self, sol):
        raise NotImplementedError()

    def runACO(self, maxiteration):
        raise NotImplementedError()

# if __name__ == '__main__':
#     aco = ACO(0.9, 2, 0.1, 0.1, 10, 'N12.data')
#     aco.runACO(50)
