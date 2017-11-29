import numpy as np
import itertools as it

from Graph import Graph
from Solution import Solution
import random
import time

SOURCE = 0
DEBUG_GENERAL = True
DEBUG_PRECISE = False

def log_gen(s):
    if DEBUG_GENERAL:
        print("   "+s)

def log_pre(s):
    if DEBUG_PRECISE:
        print("   "+s)

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
        l= float(f.readline())
        self.pheromone_init *= l
        self.pheromone = np.ones((self.graph.N, self.graph.N))*l

    def get_next_city(self, sol):
        log_pre("getting next city ... (visited : " + str(len(sol.visited)) + " - not visited : " +str(len(sol.not_visited))+")")

        # S'il ne reste plus qu'une ville a visiter, on visite celle-ci
        if (len(sol.not_visited) == 1):
            log_pre("   done getting next city")
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
            log_pre("   done getting next city")
            return a[0][np.argmax(a[1])]

        else :
        # La troisieme ligne est le taux probVille/totalProbas
        # La quatrieme ligne est le taux sums probVille/totalProbas
            randNumb = random.random()  
            a[2][0] = a[1][0]/totalProb
            a[3][0] = a[2][0]
            if a[3][0] >= randNumb:
                log_pre("   done getting next city")
                return a[0][0]
            for i in range (1,len(a[0])):
                a[2][i] = a[1][i]/totalProb
                a[3][i] = a[3][i-1] + a[2][i]
                if a[3][i] >= randNumb:
                    log_pre("   done getting next city")
                    return a[0][i]

    def heuristic2opt(self, sol):

        log_pre("heuristic 2 opt ...")

        permutationhappened = True
        #print('> Best distance so far 1 is %d ' % sol.cost)
        while permutationhappened :
            permutationhappened = False
            for i in range (0,len(sol.visited)-2):
                #log_pre("      i = " + str(i))
                for j in range (i+2,len(sol.visited)):
                    #log_pre("      j = " + str(j))
                    #tempSol = Solution(sol)
                    #tempSol.inverser_ville(i,j)
                    J = j+1
                    if j == len(sol.visited)-1 :
                        J = 0
                    priceCurrent = sol.g.get_edge(sol.visited[i],sol.visited[i+1]).cost + sol.g.get_edge(sol.visited[j],sol.visited[J]).cost
                    priceChanged = sol.g.get_edge(sol.visited[i],sol.visited[j]).cost + sol.g.get_edge(sol.visited[i+1],sol.visited[J]).cost
                    if priceChanged < priceCurrent :
                        log_pre("      better result found")
                        permutationhappened = True
                        #sol.visited = tempSol.visited
                        #sol.cost = tempSol.cost
                        sol.inverser_ville(i,j)
                        #print('> Best distance so far 2 is %d ' % sol.cost)
                        break
                        break
        
        log_pre("   done heuristic 2 opt")
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

        log_pre("global update ...")

        for length in range(0, self.graph.N):
            for height in range(0, self.graph.N):
                self.pheromone[length, height] = (1-self.parameter_rho) * self.pheromone[length, height]

        self.pheromone[sol.visited[len(sol.visited)-1], sol.visited[0]] = self.pheromone[sol.visited[len(sol.visited)-1], sol.visited[0]] + self.parameter_rho/sol.cost
        self.pheromone[sol.visited[0], sol.visited[len(sol.visited)-1]] = self.pheromone[sol.visited[0], sol.visited[len(sol.visited)-1]] + self.parameter_rho/sol.cost

        for ville in range (0,len(sol.visited)-1):
            self.pheromone[sol.visited[ville], sol.visited[ville+1]] = self.pheromone[sol.visited[ville], sol.visited[ville+1]] + self.parameter_rho/sol.cost
            self.pheromone[sol.visited[ville+1], sol.visited[ville]] = self.pheromone[sol.visited[ville+1], sol.visited[ville]] + self.parameter_rho/sol.cost

        log_pre("   done global update")

    def local_update(self, sol):
        log_pre("local update ...")

        self.pheromone[sol.visited[len(sol.visited)-1], sol.visited[0]] = ((1-self.parameter_phi)*self.pheromone[sol.visited[len(sol.visited)-1], sol.visited[0]]) + (self.parameter_phi*self.pheromone_init[sol.visited[len(sol.visited)-1], sol.visited[0]])
        self.pheromone[sol.visited[0], sol.visited[len(sol.visited)-1]] = ((1-self.parameter_phi)*self.pheromone[sol.visited[0], sol.visited[len(sol.visited)-1]]) + (self.parameter_phi*self.pheromone_init[sol.visited[0], sol.visited[len(sol.visited)-1]])
        
        for ville in range (0,len(sol.visited)-1):
            self.pheromone[sol.visited[ville], sol.visited[ville+1]] = ((1-self.parameter_phi)*self.pheromone[sol.visited[ville], sol.visited[ville+1]]) + (self.parameter_phi*self.pheromone_init[sol.visited[ville], sol.visited[ville+1]])
            self.pheromone[sol.visited[ville+1], sol.visited[ville]] = ((1-self.parameter_phi)*self.pheromone[sol.visited[ville+1], sol.visited[ville]]) + (self.parameter_phi*self.pheromone_init[sol.visited[ville+1], sol.visited[ville]])

        log_pre("   done local update")

    def runACO(self, maxiteration):

        log_pre("running ACO ...")

        for iteration in range (0, maxiteration):
            ants = []
            if iteration%10 == 0 :
                log_gen("iteration : %s, current best cost is : %s" % (iteration, self.best.cost))
            for k in range (0, self.parameter_K) :
                ant = self.build_sol()
                self.heuristic2opt(ant)
                #log_gen("   fourmis : "+str(k)+" cost : "+str(ant.cost))
                ants.append(ant)
                if ant.cost < self.best.cost :
                    self.best = ant

            self.global_update(self.best)
            for k in range (0, len(ants)) :
                self.local_update(ants[k])

            log_pre("   done running ACO")

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

def printResultsACO(aco, time, bestCost):
    print("(%s,%s,%s,%s,%s)" % (aco.parameter_q0, aco.parameter_beta, aco.parameter_rho, aco.parameter_phi, aco.parameter_K))
    print("   mean execution time in seconds : %s" % (time))
    print("   mean best cost : %s" % (bestCost))

if __name__ == '__main__':

    # Paremetres a modifier
    q0 = 0.8 # entre 0 et 1 par paliers de 0.1
    Beta = 4 # entre 0 et ? par paliers de ?
    rho = 0.5 # entre 0 et 1 par paliers de 0.1
    phi = 0.3 # entre 0 et 1 par paliers de 0.1
    K = 5 # entre 1 et ? par paliers de ?

    executionTime = []
    bestValue = []

    for x in range (0,5) :
        print("Running ACO number : %s" % (x + 1))
        debut = time.time()
        aco = ACO(q0, Beta, rho, phi, K, 'qatar')
        bestCost = aco.runACO(250).cost
        fin = time.time()
        executionTime.append(fin-debut)
        bestValue.append(bestCost)
    
    printResultsACO(aco,np.mean(executionTime),np.mean(bestValue))
