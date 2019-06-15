//
//  79_SerializeAndDeserializeBinaryTree.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/15/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SerializeAndDeserializeBinaryTree: Runnable {
    func runTests() {
        let solutionDFS = SolutionDFS()
        var serialized = solutionDFS.serialize(node: TreeNode.root)
        var tree = solutionDFS.deserialize(strings: serialized)
        
        print(serialized)
        solutionDFS.printPreOrder(node: tree)
        
        let solutionBFS = SolutionBFS()
        serialized = solutionBFS.serialize(node: TreeNode.root)
        tree = solutionBFS.deserialize(strings: serialized)
        
        print(serialized)
        solutionDFS.printPreOrder(node: tree)
    }
    
    private class SolutionBFS {
        func serialize(node: TreeNode?) -> String {
            guard let node = node else { return "null" }
            var queue = Queue<TreeNode?>()
            queue.enqueue(node)
            var strings = [String]()
            
            while !queue.isEmpty {
                let n = queue.dequeue()
                
                if n! == nil {
                    strings.append("null")
                }
                else  if let val = n!?.val {
                    strings.append("\(val)")
                    queue.enqueue(n!?.left)
                    queue.enqueue(n!?.right)
                }
            }
            
            return strings.joined(separator: ",")
        }
        
        func deserialize(strings: String) -> TreeNode? {
            guard !strings.isEmpty else { return nil }
            
            let strings = strings.split(separator: ",")
            let list = strings.reduce(LinkedList<String>()) { (list, string) -> LinkedList<String> in
                list.append(String(string))
                return list
            }
            
            var treeMap = [Int: TreeNode]()
            treeMap[0] = TreeNode(val: Int(list.remove(at: 0))!)
            
            var index = 1
            while !list.isEmpty {
                if let val = Int(list.remove(at: 0)) {
                    let node = TreeNode(val: val)
                    treeMap[index] = node
                    
                    let parentIndex = (index - 1) / 2
                    if index % 2 == 0 {
                        treeMap[parentIndex]?.right = node
                    }
                    else {
                        treeMap[parentIndex]?.left = node
                    }
                    index += 1
                }
            }
            
            return treeMap[0]
        }
    }
    
    private class SolutionDFS {
        func printPreOrder(node: TreeNode?) {
            guard let node = node else { return }
            print (node.val)
            printPreOrder(node: node.left)
            printPreOrder(node: node.right)
        }
        
        func serialize(node: TreeNode?) -> String {
            guard let node = node else { return "null" }
            var strings: [String] = []
            dfsSerialize(node, &strings)
            return strings.joined(separator: ",")
        }
        
        func deserialize(strings: String) -> TreeNode? {
            guard !strings.isEmpty else { return nil }
            let strings = strings.split(separator: ",")
            var linkedList = strings.reduce(LinkedList<String>()) { (list, value) -> LinkedList<String> in
                list.append(String(value))
                return list
            }
            return dfsDeserialize(&linkedList)
        }
        
        func dfsDeserialize(_ list: inout LinkedList<String>) -> TreeNode? {
            guard !list.isEmpty else { return nil }
            let stringVal = list.remove(at: 0)
            guard let val = Int(stringVal) else { return nil }
            
            let root = TreeNode(val: val)
            root.left = dfsDeserialize(&list)
            root.right = dfsDeserialize(&list)
            return root
        }
        
        func dfsSerialize(_ node: TreeNode?, _ strings: inout [String]) {
            guard let node = node else {
                strings.append("null")
                return
            }
            
            strings.append("\(node.val)")
            dfsSerialize(node.left, &strings)
            dfsSerialize(node.right, &strings)
        }
    }
    
    private class TreeNode {
        var left: TreeNode? = nil
        var right: TreeNode? = nil
        var val: Int
        
        init(val: Int) {
            self.val = val
        }
        
        static var root: TreeNode {
            let one = TreeNode(val: 1)
            let two = TreeNode(val: 2)
            let three = TreeNode(val: 3)
            let four = TreeNode(val: 4)
            let five = TreeNode(val: 5)
            
            two.left = three
            two.right = four
            one.left = two
            one.right = five
            
            return one
        }
    }
}
