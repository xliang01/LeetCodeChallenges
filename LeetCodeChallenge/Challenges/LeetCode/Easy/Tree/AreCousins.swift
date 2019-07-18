//
//  AreCousins.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/18/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AreCousins: Runnable {
    func runTests() {
        let solution = SolutionBFS()
    }
    
    private class SolutionBFS {
        func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
            guard let root = root else { return false }
            
            var queue = [(node: TreeNode, parent: TreeNode?, level: Int)]()
            queue.append((node: root, parent: nil, level: 0))
            
            var foundParent: TreeNode? = nil
            var foundLevel = 0
            
            while !queue.isEmpty {
                let (node, parent, level) = queue.removeFirst()
                
                if (node.val == x || node.val == y) {
                    if foundParent == nil {
                        foundParent = parent
                        foundLevel = level
                    }
                    else {
                        return parent?.val != foundParent?.val && level == foundLevel
                    }
                }
                
                if let left = node.left {
                    queue.append((node: left, parent: node, level: level + 1))
                }
                
                if let right = node.right {
                    queue.append((node: right, parent: node, level: level + 1))
                }
            }
            
            return false
        }
    }
}
