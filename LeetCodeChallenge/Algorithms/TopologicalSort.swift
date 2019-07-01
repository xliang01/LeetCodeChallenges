//
//  TopologicalSort.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/30/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class TopologicalSort: Runnable {
    
    func runTests() {
        let solution = SolutionTPSort<String>()
        let edges: [[String]] = [["A", "C"], ["B", "C"], ["C", "E"], ["B", "D"], ["E", "F"], ["E", "H"], ["F", "G"], ["D", "F"]]
        print(solution.sort(edges))
    }
    
    private class SolutionTPSort<T> where T: Hashable {
        func sort(_ edges: [[T]]) -> [T] {
            var visited = Set<T>()
            var stack = [T]()
            let graph = buildGraph(edges)
            
            for edge in edges {
                // Invalid graph with cyclical cycle.
                // var visiting = Set<T>()
                // if !topologicalSort(edge[0], graph, &visiting,  &visited, &stack) { return [] }
                topologicalSortNoCyclicalCheck(edge[0], graph, &visited, &stack)
            }
            return stack.reversed()
        }
        
        func buildGraph(_ edges: [[T]]) -> [T: [T]] {
            var graph = [T: [T]]()
            for edge in edges { graph[edge[0], default: [T]()].append(edge[1]) }
            return graph
        }
        
        func topologicalSortNoCyclicalCheck(_ edge: T,
                                            _ graph: [T: [T]],
                                            _ visited: inout Set<T>,
                                            _ stack: inout [T]) {
            // If the node is visited, just skip because it's already in the stack.
            if visited.contains(edge) { return }
            
            // Get the neighbors for the edge.
            if let neighbors = graph[edge] {
                for neighbor in neighbors {
                    topologicalSortNoCyclicalCheck(neighbor,
                                                   graph,
                                                   &visited,
                                                   &stack)
                }
            }
            // This edge has no neighbors. Therefore, he's visited.
            visited.insert(edge)
            // Append the edge as the solution in the topological sort
            stack.append(edge)
        }
        
        func topologicalSortCyclicalCheck(_ edge: T,
                                          _ graph: [T: [T]],
                                          _ visiting: inout Set<T>,
                                          _ visited: inout Set<T>,
                                          _ stack: inout [T]) -> Bool {
            // If the node is visited, just skip because it's already in the stack.
            if visited.contains(edge) { return true }
            // Something is wrong here because there's a cycle in the graph.
            else if visiting.contains(edge) { return false }
            // Mark the edge as currently being visited.
            visiting.insert(edge)
            
            // Get the neighbors for the edge.
            if let neighbors = graph[edge] {
                for neighbor in neighbors {
                    if !topologicalSortCyclicalCheck(neighbor,
                                                     graph,
                                                     &visiting,
                                                     &visited,
                                                     &stack) {
                        return false
                    }
                }
            }
            // We are no longer visiting this edge because it's fully visited.
            visiting.remove(edge)
            // This edge has no neighbors. Therefore, he's visited.
            visited.insert(edge)
            // Append the edge as the solution in the topological sort
            stack.append(edge)
            // True because this edge is completely processed.
            return true
        }
    }
}
