//
//  65_GetRandomizedSetWithDuplicates.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/8/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class GetRandomizedSetWithDuplicates: Runnable {
    func runTests() {
        var solution = RandomizedSet()
//        print(solution.insert(4))
//        print(solution.insert(3))
//        print(solution.insert(4))
//        print(solution.insert(2))
//        print(solution.insert(4))
//        print(solution.remove(4))
//        print(solution.remove(3))
//        print(solution.remove(4))
//        print(solution.remove(4))
        
        solution = RandomizedSet()
        print(solution.insert(1))
        print(solution.insert(1))
        print(solution.insert(2))
        print(solution.insert(2))
        print(solution.insert(2))
        print(solution.remove(1))
        print(solution.remove(1))
        print(solution.remove(2))
        print(solution.insert(1))
        print(solution.remove(2))
    }
    
    private class RandomizedSet {
        var numberArray = [Int]()
        var numberIndexMap = [Int: Set<Int>]()
        
        /** Initialize your data structure here. */
        init() { }
        
        /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
        func insert(_ val: Int) -> Bool {
            numberArray.append(val)
            let newCount = numberArray.count - 1
            
            if var indexes = numberIndexMap[val] {
                indexes.insert(newCount)
                numberIndexMap[val] = indexes
                return false
            }
            else {
                numberIndexMap[val] = [newCount]
                return true
            }
        }
        
        /** Removes a value from the set. Returns true if the set contained the specified element. */
        func remove(_ val: Int) -> Bool {
            if var indexes = numberIndexMap[val] {
                let removedIndex = indexes.popFirst()!
                let removedNumber = numberArray.popLast()!
                let lastIndex = numberArray.count
                
                if removedNumber != val {
                    numberArray[removedIndex] = removedNumber
                    numberIndexMap[removedNumber]?.remove(lastIndex)
                    numberIndexMap[removedNumber]?.insert(removedIndex)
                }
                
                if indexes.isEmpty {
                    numberIndexMap[val] = nil
                }
                else {
                    numberIndexMap[val] = indexes
                }
                
                return true
            }
            return false
        }
        
        /** Get a random element from the set. */
        func getRandom() -> Int {
            return numberArray[Int.random(in: 0..<numberArray.count)]
        }
    }
}
