//
//  TreeNode.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

typealias TreeNode = CustomTreeNode<Int>

class CustomTreeNode<T> where T: Hashable {
    public var val: T
    public var left: CustomTreeNode?
    public var right: CustomTreeNode?
    
    public init(_ val: T) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    var postOrder: String {
        return CustomTreeNode.postOrder(self)
    }
    
    var inOrder: String {
        return CustomTreeNode.inOrder(self)
    }
    
    var preOrder: String {
        return CustomTreeNode.preOrder(self)
    }
    
    var bfs: String {
        return CustomTreeNode.bfs(self)
    }
}

extension CustomTreeNode {
    static func postOrder(_ node: CustomTreeNode?) -> String {
        guard let node = node else { return "null" }
        var strings = [String]()
        strings.append(postOrder(node.left))
        strings.append(postOrder(node.right))
        strings.append("\(node.val)")
        return strings.joined(separator: ", ")
    }
    
    static func inOrder(_ node: CustomTreeNode?) -> String {
        guard let node = node else { return "null"}
        var strings = [String]()
        strings.append(inOrder(node.left))
        strings.append("\(node.val)")
        strings.append(inOrder(node.right))
        return strings.joined(separator: ", ")
    }
    
    static func preOrder(_ node: CustomTreeNode?) -> String {
        guard let node = node else { return "null"}
        var strings = [String]()
        strings.append("\(node.val)")
        strings.append(preOrder(node.left))
        strings.append(preOrder(node.right))
        return strings.joined(separator: ", ")
    }
    
    static func bfs(_ node: CustomTreeNode?) -> String {
        guard let node = node else { return "" }
        var string = ""
        var queue = [(CustomTreeNode, Int)]()
        queue.append((node, 1))
        
        var prevLevel = 1
        while !queue.isEmpty {
            let (n, level) = queue.removeFirst()
            
            if level == 1 {
                string += "\nLevel: \(1)\t\t"
            }
            if level > prevLevel {
                string += "\nLevel: \(level)\t\t"
            }
            
            string += "\(n.val)\t"
            prevLevel = level
            
            if let left = n.left {
                queue.append((left, level + 1))
            }
            if let right = n.right {
                queue.append((right, level + 1))
            }
        }
        return string
    }
}


