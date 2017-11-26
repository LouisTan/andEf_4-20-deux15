import numpy as np
import itertools as it

from Graph import Graph
from Solution import Solution
import random

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

        # S'il ne reste plus qu'une ville a visiter, on visite celle-ci
        if (len(sol.not_visited) == 1):
            return sol.not_visited[0]

        # On recupere la ville actuelle
        # S'il n'y a aucune ville deja visitée, on considere la ville "0" comme ville actuelle"    
        if (len(sol.visited) == 0):
            actualCity = sol.not_visited[0]
        # Si au moins une ville a deja étée visitée, alors la derniere ville dans la liste des villes visitées est la ville actuelle
        else :
            actualCity = sol.visited[len(sol.visited)-1]

        q = random.random()

        # on Crée une matrice dont la 1ere ligne est l'identifiant des villes non visitées (on ne considere pas la 1ere ville des villes non visitées)
        # La seconde ligne est le taux pheromone/(cout^beta)
        a = np.zeros((4,len(sol.not_visited)-1))
        totalProb = 0
        for i in range (0,len(sol.not_visited)-1):
            a[0][i] = sol.not_visited[i+1]
            a[1][i] = self.pheromone[actualCity][int(a[0][i])] / ( (sol.g.get_edge(actualCity,int(a[0][i])).cost) **self.parameter_beta)
            totalProb = totalProb + a[1][i]

        # cas ou q <= q0
        if q <= self.parameter_q0 :
            return a[0][np.argmax(a[1])]

        else :
        # La troisieme ligne est le taux probVille/totalProbas
        # La quatrieme ligne est le taux sums probVille/totalProbas
            randNumb = random.random()  
            a[2][0] = a[1][0]/totalProb
            a[3][0] = a[2][0]
            if a[3][0] >= randNumb:
                    return a[0][0]
            for i in range (1,len(a[0])):
                a[2][i] = a[1][i]/totalProb
                a[3][i] = a[3][i-1] + a[2][i]
                if a[3][i] >= randNumb:
                    return a[0][i]

    def heuristic2opt(self, sol):
        best_distance = sol.cost
        #print('> Best distance so far is %d ' % sol.cost)

        for values in it.permutations(sol.visited[:-1]):
            sol.visited = list(values)
            sol.visited.append(SOURCE)
            new_distance = sol.get_cost(SOURCE)
            if new_distance < best_distance:
                sol.cost = new_distance
                best_distance = new_distance
                #print('> Best distance so far is %d ' % sol.cost)

    def global_update(self, sol):
        for length in range(0, self.graph.N):
            for height in range(0, self.graph.N):
                self.pheromone[length, height] = (1-self.parameter_rho) * self.pheromone[length, height]

        self.pheromone[sol.visited[len(sol.visited)-1], sol.visited[0]] = self.pheromone[sol.visited[len(sol.visited)-1], sol.visited[0]] + self.parameter_rho/sol.cost
        self.pheromone[sol.visited[0], sol.visited[len(sol.visited)-1]] = self.pheromone[sol.visited[0], sol.visited[len(sol.visited)-1]] + self.parameter_rho/sol.cost

        for ville in range (0,len(sol.visited)-1):
            self.pheromone[sol.visited[ville], sol.visited[ville+1]] = self.pheromone[sol.visited[ville], sol.visited[ville+1]] + self.parameter_rho/sol.cost
            self.pheromone[sol.visited[ville+1], sol.visited[ville]] = self.pheromone[sol.visited[ville+1], sol.visited[ville]] + self.parameter_rho/sol.cost

    def local_update(self, sol):
        raise NotImplementedError()

    def runACO(self, maxiteration):
        raise NotImplementedError()

# if __name__ == '__main__':
#     aco = ACO(0.9, 2, 0.1, 0.1, 10, 'N12.data')
#     aco.runACO(50)
