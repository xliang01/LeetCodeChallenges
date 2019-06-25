//
//  SerializeDeserializeBST.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/24/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SerializeDeserializeBST: Runnable {
    func runTests() {
        let solution = SolutionString()
        let serialized = solution.serialize(TreeNode.root)
        print(serialized)
        print(solution.deserialize(serialized)?.inOrderValues ?? [])
    }
    
    private class Codec {
        static let null = "null"
        static let separator = ","
        
        func serialize(_ root: TreeNode?) -> String {
            guard let root = root else {
                return Codec.null
            }
            
            var list = [String]()
            var stack = [TreeNode]()
            
            stack.append(root)
            while !stack.isEmpty {
                let node = stack.removeLast()
                list.append(String(node.val))
                if let rightNode = node.right {
                    stack.append(rightNode)
                }
                if let leftNode = node.left {
                    stack.append(leftNode)
                }
            }
            
            return list.joined(separator: Codec.separator)
        }
        
        func deserialize(_ data: String) -> TreeNode? {
            if data == Codec.null {
                return nil
            }
            
            let list = data.components(separatedBy: Codec.separator)
            var queue = [Int]()
            
            for item in list {
                if let val = Int(item) {
                    queue.append(val)
                }
            }
            
            return getNode(queue)
        }
        
        func getNode(_ queue: [Int]) -> TreeNode? {
            if queue.isEmpty {
                return nil
            }
            
            var queue = queue
            let root = TreeNode(queue.removeFirst())
            var smallerQueue = [Int]()
            
            while !queue.isEmpty && queue[0] < root.val {
                smallerQueue.append(queue.removeFirst())
            }
            
            root.left = getNode(smallerQueue)
            root.right = getNode(queue)
            
            return root
        }
    }
    
    private class SolutionString {
        func serialize(_ node: TreeNode?) -> String {
            var nums = [Int]()
            postOrder(node, &nums)
            return String(nums.map { String($0) }.joined(separator: ";"))
        }

        func deserialize(_ string: String) -> TreeNode? {
            var nums = string.split(separator: ";").map { Int(String($0))!}
            return deserializeHelper(&nums, Int.min, Int.max)
        }

        private func postOrder(_ node: TreeNode?, _ nums: inout [Int]) {
            guard let node = node else { return }
            postOrder(node.left, &nums)
            postOrder(node.right, &nums)
            nums.append(node.val)
        }

        private func deserializeHelper(_ nums: inout [Int], _ lower: Int, _ upper: Int) -> TreeNode? {
            guard !nums.isEmpty else {
                return nil
            }
            let val = nums.last!

            if val < lower || val > upper {
                return nil
            }
            nums.removeLast()

            let root = TreeNode(val)
            root.right = deserializeHelper(&nums, val, upper)
            root.left = deserializeHelper(&nums, lower, val)
            return root
        }
    }
    
    // Definition for a binary tree node.
    private class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
        
        static var root: TreeNode {
            let four = TreeNode(4)
            let five = TreeNode(5)
            let seven = TreeNode(7)
            let eight = TreeNode(8)
            let nine = TreeNode(9)
            let ten = TreeNode(10)
            let eleven = TreeNode(11)
            
            ten.right = eleven
            eight.left = seven
            nine.left = eight
            nine.right = ten
            five.left = four
            five.right = nine
            return five
        }
        
        var postOrderValues: String {
            return TreeNode.postOrder(self)
        }
        
        var inOrderValues: String {
            return TreeNode.inOrder(self)
        }
        
        private static func postOrder(_ node: TreeNode?) -> String {
            guard let node = node else { return "null" }
            var strings = [String]()
            strings.append(postOrder(node.left))
            strings.append(postOrder(node.right))
            strings.append(String(node.val))
            return strings.joined(separator: ";")
        }
        
        private static func inOrder(_ node: TreeNode?, _ dir: String="") -> String {
            guard let node = node else { return dir + " null"}
            var strings = [String]()
            strings.append(dir + " " + String(node.val))
            strings.append(inOrder(node.left, "L"))
            strings.append(inOrder(node.right, "R"))
            return strings.joined(separator: ";")
        }
    }
    
}
