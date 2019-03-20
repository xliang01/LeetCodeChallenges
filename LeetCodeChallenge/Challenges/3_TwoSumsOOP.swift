//
//  3_TwoSumsOOP.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/19/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class TwoSumsOOP: Runnable {
    func runTests() {
        print("Solution 1: Two Sum Array")
        let twoSum1 = TwoSumArray()
        twoSum1.add(5)
        twoSum1.add(3)
        twoSum1.add(1)
        print(twoSum1.find(4))
        print(twoSum1.find(7))

        print("\nSolution 2: Two Sum Set")
        var twoSum2 = TwoSumSet()
        twoSum2.add(5)
        twoSum2.add(3)
        twoSum2.add(1)
        print(twoSum2.find(4))
        print(twoSum2.find(7))
        
        print("\nSolution 2: Two Sum Set Exception Case")
        twoSum2 = TwoSumSet()
        twoSum2.add(0)
        twoSum2.add(0)
        twoSum2.add(0)
        print(twoSum2.find(0))
    }
}

class TwoSumArray {
    private var list = [Int]()
    private var hash = [Int: Int]()
    
    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Add the number to an internal data structure.. */
    func add(_ number: Int) {
        list.append(number)
    }
    
    /**
        Find if there exists any pair of numbers which sum is equal to the value.
     
        Runtime Complexity: O(n)
        Space Complexity: O(n)
     */
    func find(_ value: Int) -> Bool {
        // Clear the hash of previous values.
        hash.removeAll()
        // GUARD: Base case 1 with only 1 item.
        guard list.count > 1 else {
            return false
        }
        // GUARD: Base case 2 with only 2 items.
        guard list.count > 2 else {
            return list[0] + list[1] == value
        }
        // Two Sum Algorithm
        for (index, num) in list.enumerated() {
            let difference = value - num
            if let foundIndex = hash[difference], foundIndex != index {
                return true
            }
            hash[num] = index
        }
        return false
    }
}

// MARK: Using HashSet

class TwoSumSet {
    private var countHash = [Int: Int]()
    
    //  Initialize your data structure here.
    init() { }
    
    // Add the number to an internal data structure.
    func add(_ value: Int) {
        // Keep track of the number of times the value is added. Used later to determine the solution.
        if let count = countHash[value] {
            countHash[value] = count + 1
        }
        else {
            countHash[value] = 1
        }
    }
    
    func find(_ value: Int) -> Bool {
        // GUARD: If the dictionary is empty, just return.
        guard !countHash.isEmpty else {
            return false
        }
        /*
             Solution:
         
             For all the numbers and their respective counts, check if the difference
             is found in the dictionary. If the difference is found, it means the complement
             number has already been added in a previous "add" call. Therefore, there exists
             a possible solution of two numbers that can be added together to form the find value.
         
             Exception Case:
         
             If there is only 1 unique number in the list, and the target value (passed from the find(...))
             is 2x the unique number, then the difference will equal the original added number. For example,
             if a list contains just [1] and we call find(2), then 2 - 1 = 1. The difference (1) is still in the
             dictionary, but the solution is incorrect because we need two values. Therefore, we must use
             the count in the dictionary to differentiate when unique numbers are present, versus when
             single numbers are found that can still be found in the dictionary...
         
            Another edge case to consider is adding 0, and calling find(0) immediately
            after. This produces a similar problem like the case above, where 0 - 0 is still 0.
         
            Performance:
         
            Time Complexity: O(n) - It's possible to traverse the entire list without finding the value.
            Space Complexity: O(n) - It's possible to add all unique values inside the dictionary.
         */
        for addedNumber in countHash.keys {
            // Get the difference and see if it's been added to the list.
            let difference = value - addedNumber
            // If has already been added to the list, check if it's a repeat number.
            if let foundNumberCount = countHash[difference] {
                // If it's not a repeat number, ensure at least one is found.
                if difference != addedNumber && foundNumberCount > 0 {
                    return true
                }
                    // If it is an identical number, ensure at least two is found to verify
                    // two numbers were entered.
                else if (difference == addedNumber) && foundNumberCount > 1 {
                    return true
                }
            }
        }
        return false
    }
}
