//
//  88_ClassSchedule.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/20/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ClassSchedulePart2: Runnable {
    func runTests() {
        let solution = SolutionTopologicalSort()
        print(solution.findOrder(2, [[1, 0]]))
        print(solution.findOrder(2, [[1, 0], [0, 1]]))
        print(solution.findOrder(6, [[5, 4], [4, 3], [3, 2], [2, 1], [1, 0]]))
        print(solution.findOrder(4, [[3, 2], [2, 1], [1, 3]]))
    }
    
    private class SolutionTopologicalSort {
        func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
            if numCourses == 0 { return [] }
            if numCourses == 1 { return prerequisites[0] }
            
            var classes = [[Int]](repeating: [Int](), count: numCourses)
            var visiting = Set<Int>()
            var visited = Set<Int>()
            var order = Array<Int>()
            
            for preq in prerequisites {
                classes[preq[0]].append(preq[1])
            }
            
            for (classToTake, _) in classes.enumerated() {
                if !checkCycle(classToTake: classToTake,
                               classes: classes,
                               visiting: &visiting,
                               visited: &visited,
                               order: &order) {
                    return []
                }
            }
            return order
        }
        
        func checkCycle(classToTake: Int,
                        classes: [[Int]],
                        visiting: inout Set<Int>,
                        visited: inout Set<Int>,
                        order: inout Array<Int>) -> Bool {
            
            if visiting.contains(classToTake) {
                return false
            }
            else if !visited.contains(classToTake) {
                visiting.insert(classToTake)
                let prereqs = classes[classToTake]
                
                for prereq in prereqs {
                    if !checkCycle(classToTake: prereq,
                                   classes: classes,
                                   visiting: &visiting,
                                   visited: &visited,
                                   order: &order) {
                        return false
                    }
                }
                visiting.remove(classToTake)
                visited.insert(classToTake)
                order.append(classToTake)
            }
            return true
        }
    }
}
