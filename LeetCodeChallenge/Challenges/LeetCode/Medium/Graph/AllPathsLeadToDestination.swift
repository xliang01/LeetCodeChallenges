//
//  AllPathsLeadToDestination.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/6/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AllPathsLeadToDesination: Runnable {
    func runTests() {
        let solution = SolutionDFS()
        print(solution.leadsToDestination(3, [[0,1],[0,2]], 0, 2))
    }
    
    // T: O(V + E)
    // S: O(V + E)
    private class SolutionDFS {
        func leadsToDestination(_ n: Int, _ edges: [[Int]], _ source: Int, _ destination: Int) -> Bool {
            // Transform graph into edges.
            let graph = getGraph(edges)
            // Get visited nodes.
            var visited = Set<Int>()
            // Remember traversal.
            var memo = [Int: Bool]()
            return dfs(source, graph, &visited, destination, &memo)
        }
        
        private func dfs(_ node: Int,
                         _ graph: [Int: [Int]],
                         _ visited: inout Set<Int>,
                         _ destination: Int,
                         _ memo: inout [Int: Bool]) -> Bool {
            if visited.contains(node) { return false }
            let neighbors = graph[node] ?? []
            
            if !neighbors.isEmpty && destination == node { return false }
            else if neighbors.isEmpty && destination != node { return false }
            if let canLeadToDest = memo[node] { return canLeadToDest }
            
            visited.insert(node)
            
            if let neighbors = graph[node] {
                for neighbor in neighbors {
                    if !dfs(neighbor, graph, &visited, destination, &memo) {
                        memo[node] = false
                        return memo[node]!
                    }
                }
            }
            
            visited.remove(node)
            memo[node] = true
            return memo[node]!
        }
        
        private func getGraph(_ edges: [[Int]]) -> [Int: [Int]] {
            var graph = [Int: [Int]]()
            
            for e in edges {
                graph[e[0], default: [Int]()].append(e[1])
            }
            
            return graph
        }
    }
}
