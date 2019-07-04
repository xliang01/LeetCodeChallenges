//
//  UniqueBinaryTrees.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/4/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class UniqueBinaryTrees: Runnable {
    func runTests() {
        let solution = SolutionDPRecurse()
        let trees = solution.generateTrees(3)
        for tree in trees {
            print(tree!.preOrder)
        }
    }
    
    func numTrees(_ n: Int) -> Int {
        if n == 0 { return 0 }
        else if n == 1 { return 1 }
        else if n == 2 { return 2 }
        
        var G = [Int](repeating: 0, count: n + 1)
        G[0] = 1
        G[1] = 1
        
        for N in 2...n {
            for F in 1...N {
                G[N] += G[F - 1] * G[N - F]
            }
        }
        return G[n]
    }
    
    private class SolutionDPRecurse {
        func generateTrees(_ n: Int) -> [TreeNode?] {
            if n == 0 {
                return []
            }
            else if n == 1 {
                return [TreeNode(n)]
            }
            
            return generateTrees(1, n)
        }
        
        func generateTrees(_ start: Int, _ end: Int) -> [TreeNode?] {
            var trees = [TreeNode]()
            
            if start > end {
                return [nil]
            }
            
            for i in start...end {
                let leftTrees = generateTrees(start, i - 1)
                let rightTrees = generateTrees(i + 1, end)
                
                for left in leftTrees {
                    for right in rightTrees {
                        let root = TreeNode(i)
                        root.left = left
                        root.right = right
                        trees.append(root)
                    }
                }
            }
            return trees
        }
    }
}
