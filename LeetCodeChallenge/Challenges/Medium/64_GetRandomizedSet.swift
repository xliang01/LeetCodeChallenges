//
//  64_GetRandomizedSet.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/8/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class GetRandomizedSet: Runnable {
    func runTests() {
        let solution = RandomizedSet()
        print(solution.insert(0))
        print(solution.insert(1))
        print(solution.remove(0))
        print(solution.insert(2))
        print(solution.remove(1))
        print(solution.getRandom())
    }
    
    private class RandomizedSet {
        var numberArray = [Int]()
        var numberIndexMap = [Int: Int]()
        
        /** Initialize your data structure here. */
        init() { }
        
        /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
        func insert(_ val: Int) -> Bool {
            if numberIndexMap[val] != nil { return false }
            numberArray.append(val)
            numberIndexMap[val] = numberArray.count - 1
            return true
        }
        
        /** Removes a value from the set. Returns true if the set contained the specified element. */
        func remove(_ val: Int) -> Bool {
            if numberIndexMap[val] == nil { return false }
            let removedIndex = numberIndexMap.removeValue(forKey:val)!
            let removedNumber = numberArray.popLast()!
            if removedNumber != val {
                numberArray[removedIndex] = removedNumber
                numberIndexMap[removedNumber] = removedIndex
            }
            return true
        }
        
        /** Get a random element from the set. */
        func getRandom() -> Int {
            return numberArray[Int.random(in: 0..<numberArray.count)]
        }
    }
    
    /**
     * Your RandomizedSet object will be instantiated and called as such:
     * let obj = RandomizedSet()
     * let ret_1: Bool = obj.insert(val)
     * let ret_2: Bool = obj.remove(val)
     * let ret_3: Int = obj.getRandom()
     */
}
