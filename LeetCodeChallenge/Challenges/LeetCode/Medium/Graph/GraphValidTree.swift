//
//  GraphValidTree.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/29/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class GraphValidTree: Runnable {
    func runTests() {
        let solution = SolutionBFS()
        print(solution.validTree(5, [[0,1], [0,2], [0,3], [1,4]]))
        print(solution.validTree(5, [[0,1], [1,2], [1,4], [3,5]]))
    }
    
    private class SolutionBFS {
        func validTree(_ n: Int, _ edges: [[Int]]) -> Bool {
            // Handle base cases
            guard edges.count < n else { return false }
            guard n > 1 else { return true }
            
            var graph = [Int: [Int]]()
            // Create the graph using edges. Because it is bidirectional, both sides are in.
            // Space complexity for this graph is O(E + 2V - 1)
            for edge in edges {
                graph[edge[0], default: []].append(edge[1])
                graph[edge[1], default: []].append(edge[0])
            }
            
            var visited = [Int](repeating: 0, count: n)
            var queue = [Int]()
            
            // Visit node 0 since this is where we want to begin.
            visited[0] = 1
            queue.append(0)
            
            // Time complexity, we have to visit almost every node for O(2V + E - 1)
            while !queue.isEmpty {
                let node = queue.removeFirst()
                visited[node] = 1
                
                // What are the connecting nodes?
                guard let connectedNodes = graph[node] else { continue }
                
                // For every node in the connecting node, check if it's visited.
                for nextNode in connectedNodes {
                    if visited[nextNode] == 1 { continue }
                    queue.append(nextNode)
                }
            }
            
            return !visited.contains(0)
        }
    }
}
