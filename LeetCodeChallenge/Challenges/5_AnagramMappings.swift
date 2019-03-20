//
//  5_AnagramMappings.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/19/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AnagramMappings: Runnable {
    func runTests() {
        print("Solution 1: Regular Set with Index")
        let solution1 = SolutionSet()
        print(solution1.anagramMappings([12, 28, 46, 32, 50], [50, 12, 32, 46, 28]))
        
        print("Solution 2: Simplified Set with Index")
        let solution2 = SolutionNoDuplicatesSet()
        print(solution2.anagramMappings([12, 28, 46, 32, 12], [12, 12, 32, 46, 28]))
    }
    
    private class SolutionSet {
        /**
            Store all values of B with its index in a map. Then find the index of value A from map B
            to get the solution.
         
            Time Complexity: O(N)
            Space Complexity: O(N)
         */
        func anagramMappings(_ A: [Int], _ B: [Int]) -> [Int] {
            var solution = [Int]()
            var indexMap = [Int: Int]()
            
            for (index, value) in B.enumerated() {
                indexMap[value] = index
            }
            
            A.forEach { (value) in
                if let index = indexMap[value] {
                    solution.append(index)
                }
            }
            return solution
        }
    }

    private class SolutionNoDuplicatesSet {
        /**
            Solution:
         
            The problem states that if there are duplicates in the list,  we can return ANY index. Therefore,
            the optimized solution is to use a dictionary to store the first index of the duplicated value. All
            other duplicated values are discarded because their positions are irrelevant.
         
            Then we just return the first found index in B when it matches a value in A.
         
            Performance:
         
            Time Complexity: O(N) because we have to iterate through the entire list in order to assign the first found index.
            Space Complexity: O(N) because we could store no duplicate values for the first index found for all of N.
         */
        func anagramMappings(_ A: [Int], _ B: [Int]) -> [Int] {
            var solution = [Int]()
            var indexMap = [Int: Int]()
            
            for (index, value) in B.enumerated() {
                if indexMap[value] == nil {
                    indexMap[value] = index
                }
            }
            
            A.forEach { (value) in
                if let index = indexMap[value] {
                    solution.append(index)
                }
            }
            return solution
        }
    }
}
