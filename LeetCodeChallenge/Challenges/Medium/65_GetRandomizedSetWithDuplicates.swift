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
        let solution = RandomizedSet()
        print(solution.insert(1))
        print(solution.insert(1))
        print(solution.insert(2))
        print(solution.getRandom())
        print(solution.remove(1))
        print(solution.getRandom())
    }
    
    private class RandomizedSet {
        var numberArray = [Int]()
        var numberIndexMap = [Int: [Int]]()
        
        /** Initialize your data structure here. */
        init() { }
        
        /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
        func insert(_ val: Int) -> Bool {
            numberArray.append(val)
            let newCount = numberArray.count - 1
            
            if var indexes = numberIndexMap[val] {
                indexes.append(newCount)
                numberIndexMap[val] = indexes
            }
            else {
                numberIndexMap[val] = [newCount]
            }
            return true
        }
        
        /** Removes a value from the set. Returns true if the set contained the specified element. */
        func remove(_ val: Int) -> Bool {
            if var indexes = numberIndexMap[val] {
                let removedIndex = indexes.popLast()!
                numberIndexMap[val] = indexes
                
                let removedNumber = numberArray.popLast()!
                if removedNumber != val {
                    numberArray[removedIndex] = removedNumber
                    numberIndexMap[removedNumber]!.removeLast()
                    numberIndexMap[removedNumber]!.append(removedIndex)
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
