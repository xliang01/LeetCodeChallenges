//
//  63_KClosestPointToOrigin.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/8/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class KClosestPoint: Runnable {
    func runTests() {
        let solution = SolutionPriorityQueue()
        print(solution.kClosest([[1,3],[-2,2]], 1))
        print(solution.kClosest([[3,3],[5,-1],[-2,4]], 2))
    }
    
    private class SolutionPriorityQueue {
        func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
            var priorityQueue = PriorityQueue<Int> { index1, index2 -> Bool in
                let p1 = points[index1]
                let p2 = points[index2]
                let p1Distance = sqrt(Double(p1[0] * p1[0] + p1[1] * p1[1] ))
                let p2Distance = sqrt(Double(p2[0] * p2[0] + p2[1] * p2[1] ))
                // Returns the max distance.
                return p1Distance > p2Distance
            }
    
            for i in 0..<points.count {
                priorityQueue.enqueue(i)
                if priorityQueue.count > K {
                    _ = priorityQueue.dequeue()
                }
            }
    
            var answers = [[Int]]()
            while !priorityQueue.isEmpty {
                answers.append(points[priorityQueue.dequeue()!])
            }
            return answers
        }
    }
}
