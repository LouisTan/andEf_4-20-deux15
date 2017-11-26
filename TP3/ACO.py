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
            actualCity = SOURCE
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

        permutationhappened = True
        #print('> Best distance so far 1 is %d ' % sol.cost)
        while permutationhappened :
            permutationhappened = False
            for i in range (0,len(sol.visited)-1):
                for j in range (i+1,len(sol.visited)):
                    tempSol = Solution(sol)
                    tempSol.inverser_ville(i,j)
                    if tempSol.cost < sol.cost :
                        permutationhappened = True
                        sol.visited = tempSol.visited
                        sol.cost = tempSol.cost
                        #print('> Best distance so far 2 is %d ' % sol.cost)
                        break
                        break

#       best_distance = sol.cost
#        for values in it.permutations(sol.visited[:-1]):
#            sol.visited = list(values)
#            sol.visited.append(SOURCE)
#            new_distance = sol.get_cost(SOURCE)
#            if new_distance < best_distance:
#                sol.cost = new_distance
#                best_distance = new_distance
#                #print('> Best distance so far is %d ' % sol.cost)

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
        self.pheromone[sol.visited[len(sol.visited)-1], sol.visited[0]] = ((1-self.parameter_phi)*self.pheromone[sol.visited[len(sol.visited)-1], sol.visited[0]]) + (self.parameter_phi*self.pheromone_init[sol.visited[len(sol.visited)-1], sol.visited[0]])
        self.pheromone[sol.visited[0], sol.visited[len(sol.visited)-1]] = ((1-self.parameter_phi)*self.pheromone[sol.visited[0], sol.visited[len(sol.visited)-1]]) + (self.parameter_phi*self.pheromone_init[sol.visited[0], sol.visited[len(sol.visited)-1]])
        
        for ville in range (0,len(sol.visited)-1):
            self.pheromone[sol.visited[ville], sol.visited[ville+1]] = ((1-self.parameter_phi)*self.pheromone[sol.visited[ville], sol.visited[ville+1]]) + (self.parameter_phi*self.pheromone_init[sol.visited[ville], sol.visited[ville+1]])
            self.pheromone[sol.visited[ville+1], sol.visited[ville]] = ((1-self.parameter_phi)*self.pheromone[sol.visited[ville+1], sol.visited[ville]]) + (self.parameter_phi*self.pheromone_init[sol.visited[ville+1], sol.visited[ville]])

    def runACO(self, maxiteration):

        for iteration in range (0, maxiteration):
            ants = []
            print("iteration : "+str(iteration))
            for k in range (0, self.parameter_K) :
                ant = self.build_sol()
                self.heuristic2opt(ant)
                print("   fourmis : "+str(k)+" cost : "+str(ant.cost))
                ants.append(ant)
                if ant.cost < self.best.cost :
                    self.best = ant

            self.global_update(self.best)
            for k in range (0, len(ants)) :
                self.local_update(ants[k])

        return self.best

    def build_sol(self) :

        s = Solution(self.graph)

        s.not_visited.remove(SOURCE)

        while (len(s.not_visited) > 0) :
            if (len(s.visited) == 0):
                actualCity = SOURCE
            else :
                actualCity = s.visited[len(s.visited)-1]

            # Loop act as a do-while
            #while True:       
            cityToVisit = self.get_next_city(s)
            #    if cityToVisit != origin or len(s.not_visited) == 1 :
            #        break

            s.add_edge(int(actualCity),int(cityToVisit))

        s.not_visited.append(SOURCE)
        s.add_edge(int(s.visited[len(s.visited)-1]), SOURCE)

        return s


if __name__ == '__main__':
    aco = ACO(0.9, 2, 0.1, 0.1, 10, 'testa')
    print(aco.runACO(50).cost)
