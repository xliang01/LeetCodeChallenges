//
//  88_ClassSchedule.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/20/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ClassSchedule: Runnable {
    func runTests() {
        let solution = SolutionTopologicalSort()
        print(solution.canFinish(2, [[1, 0]]))
        print(solution.canFinish(2, [[1, 0], [0, 1]]))
        print(solution.canFinish(6, [[5, 4], [4, 3], [3, 2], [2, 1], [1, 0]]))
        print(solution.canFinish(4, [[3, 2], [2, 1], [1, 3]]))
    }
    
    private class SolutionTopologicalSort {
        func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
            if numCourses == 0 { return false }
            if numCourses == 1 { return prerequisites[0] != prerequisites[1] }
            
            var classes = [[Int]](repeating: [Int](), count: numCourses)
            var visiting = Set<Int>()
            var visited = Set<Int>()
            
            for preq in prerequisites {
                classes[preq[0]].append(preq[1])
            }
            
            for (classToTake, _) in classes.enumerated() {
                if !checkCycle(classToTake: classToTake,
                               classes: classes,
                               visiting: &visiting,
                               visited: &visited) {
                    return false
                }
            }
            return true
        }
        
        func checkCycle(classToTake: Int,
                        classes: [[Int]],
                        visiting: inout Set<Int>,
                        visited: inout Set<Int>) -> Bool {
            
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
                                   visited: &visited) {
                        return false
                    }
                }
                visiting.remove(classToTake)
                visited.insert(classToTake)
            }
            return true
        }
    }
}
