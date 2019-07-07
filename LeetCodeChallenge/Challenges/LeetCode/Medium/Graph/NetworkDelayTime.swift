//
//  NetworkDelayTime.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/6/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class NetworkDelayTime: Runnable {
    func runTests() {
        let solution = SolutionMap()
        print(solution.networkDelayTime([[1,2,1], [2,3,2], [1,3,4]], 3, 1))
    }
    
    private class SolutionMap {
        func networkDelayTime(_ times: [[Int]], _ N: Int, _ K: Int) -> Int {
            var graph: [Int: [Int: Int]] = [:]
            
            /* Build graph: [source: [destination: weight]] */
            for t in times {
                graph[t[0], default: [:]][t[1]] = t[2]
            }
            
            /* Distance map: [node: distance from K to here] */
            var distMap: [Int: Int] = [:]
            distMap[K] = 0
            var q: [(node: Int, dist: Int)] = []
            
            q.append((node: K, dist: 0))
            
            while !q.isEmpty {
                let curr = q.removeLast()
                
                /* Get all neighbors of current node from graph */
                guard let nexts = graph[curr.node] else { continue }
                
                for (dest, weight) in nexts {
                    if let distToNext = distMap[dest], curr.dist + weight >= distToNext {
                        /* If there already exists a shorter distance to this neighbor,
                         we do not update distance to this neighbor */
                        continue
                    }
                    /* Update the distance to this neighbor
                     / Add this neighbor in the queue */
                    distMap[dest] = curr.dist + weight
                    q.append((node: dest, dist: curr.dist + weight))
                }
            }
            return distMap.count == N ? distMap.values.max() ?? -1 : -1
        }
    }
    
    // Solution doesn't work
    private class SolutionBFS {
        struct NodeItem {
            let node: Int
            let time: Int
        }
        
        struct QueueItem {
            let nodeItem: NodeItem
            let accumalatedTime: Int
        }
        
        func networkDelayTime(_ times: [[Int]], _ N: Int, _ K: Int) -> Int {
            let graph = toGraph(times, N)
            var visited = [Bool](repeating: false, count: N + 1)
            var queue = [QueueItem]()
            
            var maxTime = 0
            let startingNode = NodeItem(node: K, time: 0)
            let queueItem = QueueItem(nodeItem: startingNode, accumalatedTime: 0)
            queue.append(queueItem)
            
            while !queue.isEmpty {
                let queueItem = queue.removeFirst()
                let nodeItem = queueItem.nodeItem
                let accTime = queueItem.accumalatedTime
                
                let node = nodeItem.node
                if visited[node] { continue }
                visited[node] = true
                maxTime = max(accTime, maxTime)
                
                for nodeItem in graph[node] {
                    let queueItem = QueueItem(nodeItem: nodeItem, accumalatedTime: nodeItem.time + accTime)
                    queue.append(queueItem)
                }
            }
            
            let totalVisited = visited.filter { $0 }.count
            return totalVisited != N ? -1 : maxTime
        }
        
        private func toGraph(_ times: [[Int]], _ N: Int) -> [[NodeItem]] {
            var graph = [[NodeItem]](repeating: [NodeItem](), count: N + 1)
            for time in times {
                graph[time[0]].append(NodeItem(node: time[1], time: time[2]))
            }
            return graph
        }
    }
}
