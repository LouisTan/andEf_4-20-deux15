import numpy as np

kruskal = None


class UnionFind(object):
    def __init__(self, n):
        self.n = n
        self.parent = np.array(range(n))
        self.rnk = np.zeros(n)

    def reset(self):
        self.parent = np.array(range(self.n))
        self.rnk = np.zeros(self.n)

    def add(self, e):
        x = self.find(e.source)
        y = self.find(e.destination)

        if self.rnk[x] > self.rnk[y]:
            self.parent[y] = x
        else:
            self.parent[x] = y
        if self.rnk[x] == self.rnk[y]:
            self.rnk[y] += 1

    def makes_cycle(self, e):
        return self.find(e.source) == self.find(e.destination)

    def find(self, u):
        if u != self.parent[u]:
            return self.find(self.parent[u])
        else:
            return u


class Kruskal(object):
    def __init__(self, g):
        self.uf = UnionFind(g.N)
        self.g = g

    def getMSTCost(self, sol, source):
        self.uf.reset()
        cost = 0
        MST = []
        sortedEdges = self.g.get_sorted_edges()
        for e in sortedEdges :
            if (e.source in sol.not_visited or e.source==source) and (e.destination in sol.not_visited or e.destination==source):
                if not self.uf.makes_cycle(e) :
                    self.uf.add(e)
                    cost = cost + e.cost
        return cost