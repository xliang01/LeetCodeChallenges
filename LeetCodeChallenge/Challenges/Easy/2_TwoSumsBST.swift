//
//  2_TwoSumBST.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/18/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

/*
    Given a Binary Search Tree and a target number, return true if there exist
    two elements in the BST such that their sum is equal to the given target.
 */
class TwoSumsBST: Runnable {
    // Definition for a binary tree node.
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
          self.val = val
          self.left = nil
          self.right = nil
        }
    }
    
    private var tree: TreeNode {
        /*
             Input:
         
             5
             / \
             3   6
             / \   \
             2   4   7
         
             Target = 9
         
             Output: True
         */
        
        let two = TreeNode(2)
        let three = TreeNode(3)
        let four = TreeNode(4)
        let five = TreeNode(5)
        let six = TreeNode(6)
        let seven = TreeNode(7)
        
        three.left = two
        three.right = four
        six.right = seven
        five.left = three
        five.right = six
        
        return five
    }
    
    private var single: TreeNode {
        return TreeNode(1)
    }
    
    func runTests() {
        print("Two Sum Array:")
        print(findTarget_twoSumArray(tree, 9))
        print(findTarget_twoSumArray(tree, 28))
        print(findTarget_twoSumArray(single, 1))
        
        print("\nPre Order Traversal:")
        print(findTarget_PreOrderTraversal(tree, 9))
        print(findTarget_PreOrderTraversal(tree, 28))
        print(findTarget_PreOrderTraversal(single, 1))
        
        print("\nBFS Traversal:")
        print(findTarget_BFS(tree, 9))
        print(findTarget_BFS(tree, 28))
        print(findTarget_BFS(single, 1))
    }
    
    // MARK: Solution 1 - Turning the BST into an array, and running two sums.

    /*
        Time Complexity: O(n)
        Space Complexity: 2n = O(n)
     */
    func findTarget_twoSumArray(_ root: TreeNode?, _ k: Int) -> Bool {
        let target = k
        var array = [Int]()
        combine(root, k, array: &array)
        return !twoSum(array, target).isEmpty
    }
    
    func combine(_ root: TreeNode?, _ target: Int, array: inout [Int]) {
        guard let root = root else {
            return
        }
        combine(root.left, target, array: &array)
        array.append(root.val)
        combine(root.right, target, array: &array)
    }
    
    /**
        Time Complexity - O(n)
        Space Complexity - O(n)
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // GUARD: Base case of only 1 element.
        guard nums.count > 1 else {
            return []
        }
        
        var hash = [Int: Int]()
        for (index, value) in nums.enumerated() {
            let difference = target - value
            if let foundIndex = hash[difference], foundIndex != index {
                return [foundIndex, index]
            }
            else {
                hash[value] = index
            }
        }
        
        return []
    }
    
    // MARK: Solution 2 - Pre Order Traversal Using HashSet
    
    /**
        Time Complexity - O(n)
        Space Complexity - O(n)
     */
    func findTarget_PreOrderTraversal(_ root: TreeNode?,
                                      _ k: Int) -> Bool {
        var set = Set<Int>()
        
        // GUARD: Base case
        guard let root = root else {
            return false
        }
        // GUARD: Base case
        guard root.left != nil || root.right != nil else {
            return false
        }
        
        return traverse(root, k, &set)
    }
    
    // Traverses in Pre-Order
    func traverse(_ root: TreeNode?,
                  _ target: Int,
                  _ set: inout Set<Int>) -> Bool {
        guard let root = root else {
            return false
        }
        let value = root.val
        let difference = target - value
        
        if set.contains(difference) {
            return true
        }
        
        set.insert(value)
        return traverse(root.left, target, &set) || traverse(root.right, target, &set)
    }
    
    // MARK: Solution 3 - BreadthDepthSearch
    
    struct Queue<T> {
        fileprivate var array = [T]()
        
        public var isEmpty: Bool {
            return array.isEmpty
        }
        
        public var count: Int {
            return array.count
        }
        
        public mutating func enqueue(_ element: T) {
            array.append(element)
        }
        
        public mutating func dequeue() -> T? {
            if isEmpty {
                return nil
            }
            else {
                return array.removeFirst()
            }
        }
        
        public var front: T? {
            return array.first
        }
    }
    
    /**
        Time Complexity - O(n)
        Space Complexity - O(n)
     */
    func findTarget_BFS(_ root: TreeNode?,
                        _ target: Int) -> Bool {
        var set = Set<Int>()
        var queue = Queue<TreeNode>()
        
        // GUARD: Base case
        guard let root = root else {
            return false
        }
        // GUARD: Base case
        guard root.left != nil || root.right != nil else {
            return false
        }
        
        queue.enqueue(root)
        
        while(!queue.isEmpty) {
            if let node = queue.dequeue() {
                let value = node.val
                let difference = target - value
                if set.contains(difference) {
                    return true
                }
                set.insert(value)
                
                if let left = node.left {
                    queue.enqueue(left)
                }
                if let right = node.right {
                    queue.enqueue(right)
                }
            }
        }
        
        return false
    }
}
