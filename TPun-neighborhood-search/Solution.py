import copy
import random

from Graph import Graph


class Solution(object):
    def __init__(self, s):
        if isinstance(s, Graph):
            self.g = s
            self.cost = 0
            self.visited = []
            self.not_visited = []
            self.edges = []
            for i in range(0, s.N):
                self.not_visited.append(i)
        elif isinstance(s, Solution):
            self.g = s.g
            self.cost = s.cost
            self.visited = list(s.visited)
            self.not_visited = list(s.not_visited)
            self.edges = list(s.edges)
        else:
            raise ValueError('you should give a graph or a solution')

    def add_edge(self, v, u):
        self.edges.append(self.g.get_edge(u, v))
        self.cost = self.cost + self.g.get_edge(u, v).cost
        self.visited.append(u)
        self.not_visited.remove(u)

    def add_edge_2(self, v, u):
        self.edges.append(self.g.get_edge(u, v))
        self.cost = self.cost + self.g.get_edge(u, v).cost

    def remove_edge(self, v, u):
        for edge in self.edges :
            if (edge.source==u and edge.destination==v) or (edge.source==v and edge.destination==u) :
                self.edges.remove(edge)
                self.cost = self.cost - edge.cost
                break

    def replace_edges(self, u, v, x, y):
        tempSol = Solution(self)
        tempSol.remove_edge(u,v)
        tempSol.remove_edge(x,y)
        tempSol.add_edge_2(u,x)
        tempSol.add_edge_2(v,y)

        if tempSol.is_valid() :
            self.remove_edge(u,v)
            self.remove_edge(x,y)
            self.add_edge_2(u,x)
            self.add_edge_2(v,y)
        else :
            tempSol.remove_edge(u,x)
            tempSol.remove_edge(v,y)
            tempSol.add_edge_2(u,y)
            tempSol.add_edge_2(v,x)
            if tempSol.is_valid() :
                self.remove_edge(u,v)
                self.remove_edge(x,y)
                self.add_edge_2(u,y)
                self.add_edge_2(v,x)
                a=5
            
    def replace_edges_2(self, edge1, edge2):
        self.replace_edges(edge1.source, edge1.destination, edge2.source, edge2.destination)

    def is_valid(self):
        import A_star
        lastPrinted = A_star.SOURCE
        edges = list(self.edges)
        change = True
        while change :
            change = False
            for edge in edges :
                if edge.source == lastPrinted :
                    lastPrinted = edge.destination
                    edges.remove(edge)
                    change = True
                    break
                elif edge.destination == lastPrinted :
                    lastPrinted = edge.source
                    edges.remove(edge)
                    change = True
                    break
        return len(edges) == 0

    def printSol(self):
        import A_star
        print (A_star.SOURCE)
        for i in self.visited:
            print(i)
        print("COST -", self.cost)

    def printSolConsideringEdges(self):
        import A_star
        print (A_star.SOURCE)
        lastPrinted = A_star.SOURCE
        edges = list(self.edges)
        while len(edges) > 0 :
            for edge in edges :
                if edge.source == lastPrinted :
                    print(edge.destination)
                    lastPrinted = edge.destination
                    edges.remove(edge)
                    break
                elif edge.destination == lastPrinted :
                    print(edge.source)
                    lastPrinted = edge.source
                    edges.remove(edge)
                    break
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
                    if edge.source == self.visited[-1] and edge.destination not in self.visited and edge.destination != 0 :
                        self.add_edge(edge.source,edge.destination)
                        break
                    elif edge.destination == self.visited[-1] and edge.source not in self.visited and edge.source != 0 :
                        self.add_edge(edge.destination,edge.source)
                        break
            elif len(self.not_visited) == 1 :  
                self.add_edge(self.visited[-1],0)

    def random_generate_solution(self):
        while len(self.not_visited) > 0 :
            if len(self.visited) == 0 :
                vertex = random.choice(self.not_visited)
                while (vertex==0) :
                    vertex = random.choice(self.not_visited)
                self.add_edge(0,vertex)
            elif len(self.not_visited) > 1 :
                vertex = random.choice(self.not_visited)
                while (vertex==0) :
                    vertex = random.choice(self.not_visited)
                self.add_edge(self.visited[-1],vertex)
            elif len(self.not_visited) == 1 :  
                self.add_edge(self.visited[-1],0)

    def generate_random_neighbor(self):
        tempSol = Solution(self)
        edge_1 = random.choice(tempSol.edges)
        edge_2 = random.choice(tempSol.edges)
        while (edge_1.source == edge_2.source and edge_1.destination == edge_2.destination) :
            edge_2 = random.choice(tempSol.edges)
        tempSol.replace_edges_2(edge_1,edge_2)
        return tempSol
