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

    def fast_generate_solution(self):
        while len(self.not_visited) > 0 :
            if len(self.visited) == 0 :
                for edge in self.g.get_sorted_edges():
                    if edge.source == 0 :
                        self.add_edge(edge.source,edge.destination)
                        break
                    elif edge.destination == 0 :
                        self.add_edge(edge.destination,edge.source)
                        break
            elif len(self.not_visited) > 1 :
                for edge in self.g.get_sorted_edges():
                    test = self.visited[-1]
                    if edge.source == self.visited[-1] and edge.destination not in self.visited and edge.destination != 0 :
                        self.add_edge(edge.source,edge.destination)
                        break
                    elif edge.destination == self.visited[-1] and edge.source not in self.visited and edge.source != 0 :
                        self.add_edge(edge.destination,edge.source)
                        break
            elif len(self.not_visited) == 1 :  
                self.add_edge(self.visited[-1],0)
