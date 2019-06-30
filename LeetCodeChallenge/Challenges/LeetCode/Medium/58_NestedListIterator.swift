//
//  58_NestedListIterator.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/8/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

// This is the interface that allows for creating nested lists.
// You should not implement it, or speculate about its implementation
public protocol NestedInteger {
    // Return true if this NestedInteger holds a single integer, rather than a nested list.
    func isInteger() -> Bool
    
    // Return the single integer that this NestedInteger holds, if it holds a single integer
    // The result is undefined if this NestedInteger holds a nested list
    func getInteger() -> Int
    
    // Set this NestedInteger to hold a single integer.
    func setInteger(value: Int)
    
    // Set this NestedInteger to hold a nested list and adds a nested integer to it.
    func add(elem: NestedInteger)
    
    // Return the nested list that this NestedInteger holds, if it holds a nested list
    // The result is undefined if this NestedInteger holds a single integer
    func getList() -> [NestedInteger]
}

class NestedIterator: Runnable {
    func runTests() {
        
    }
    
    private class SolutionIteratorStack {
        var stack = [NestedInteger]()
        
        init(_ nestedList: [NestedInteger]) {
            guard !nestedList.isEmpty else { return }
            for ni in nestedList {
                stack.insert(ni, at: 0)
            }
        }
        
        func next() -> Int {
            return stack.popLast()!.getInteger()
        }
        
        func hasNext() -> Bool {
            if let nextNI = stack.last {
                if nextNI.isInteger() { return true }
                else {
                    stack.removeLast()
                    for (index, ni) in nextNI.getList().enumerated() {
                        stack.insert(ni, at: stack.count - index)
                    }
                    return hasNext()
                }
            }
            return false
        }
    }
    
    private class SolutionUnpack {
        var nestedListInts: [Int] = []
        var index: Int = 0
        lazy var count: Int = nestedListInts.count
        
        init(_ nestedList: [NestedInteger]) {
            nestedListInts = unpack(nestedList)
        }
        
        func next() -> Int {
            let nextVal = nestedListInts[index]
            index += 1
            return nextVal
        }
        
        func hasNext() -> Bool {
            return index < count
        }
        
        private func unpack(_ nestedList: [NestedInteger]) -> [Int] {
            var ints = [Int]()
            
            for nestedInteger in nestedList {
                if nestedInteger.isInteger() {
                    ints.append(nestedInteger.getInteger())
                }
                else {
                    ints.append(contentsOf: unpack(nestedInteger.getList()))
                }
            }
            return ints
        }
    }
}

/**
 * Your NestedIterator object will be instantiated and called as such:
 * let obj = NestedIterator(nestedList)
 * let ret_1: Int = obj.next()
 * let ret_2: Bool = obj.hasNext()
 */
