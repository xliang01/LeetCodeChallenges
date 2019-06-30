//
//  45_MinStack.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MinStack: Runnable {
    func runTests() {
        let solution = MinStackMoreOptimized()
        solution.push(-2)
        solution.push(0)
        solution.push(-3)
        print(solution.getMin())
        solution.pop()
        print(solution.top())
        print(solution.getMin())
    }
    
    private class MinStack {
        private var nums = [Int]()
        private var mins = [Int]()
        
        /** initialize your data structure here. */
        init() { }
        
        func push(_ x: Int) {
            nums.append(x)
            
            if mins.isEmpty || x < mins.last! {
                mins.append(x)
            }
            else {
                mins.append(mins.last!)
            }
        }
        
        func pop() {
            nums.removeLast()
            mins.removeLast()
        }
        
        func top() -> Int {
            return nums.last!
        }
        
        func getMin() -> Int {
            return mins.last!
        }
    }
    
    private class MinStackMoreOptimized {
        private var nums = [Int]()
        private var mins = [Int]()
        
        /** initialize your data structure here. */
        init() { }
        
        func push(_ x: Int) {
            nums.append(x)
            if mins.isEmpty || x <= mins.last! {
                mins.append(x)
            }
        }
        
        func pop() {
            if nums.last == mins.last {
                mins.removeLast()
            }
            
            nums.removeLast()
        }
        
        func top() -> Int {
            return nums.last!
        }
        
        func getMin() -> Int {
            return mins.last!
        }
    }
}
