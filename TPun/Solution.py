import copy

from Graph import Graph


class Solution(object):
    def __init__(self, s):
        if isinstance(s, Graph):
            self.g = s
            self.cost = 0
            self.visited = []
            self.not_visited = []
            for i in range(0, s.N):
                self.not_visited.append(i)
        elif isinstance(s, Solution):
            self.g = s.g
            self.cost = s.cost
            self.visited = list(s.visited)
            self.not_visited = list(s.not_visited)
        else:
            raise ValueError('you should give a graph or a solution')

    def add_edge(self, v, u):
        self.cost = self.cost + self.g.get_edge(u, v).cost
        self.visited.append(u)
        self.not_visited.remove(u)

    def printSol(self):
        import A_star
        print (A_star.SOURCE)
        for i in self.visited:
            print(i)
        print("COST -", self.cost)