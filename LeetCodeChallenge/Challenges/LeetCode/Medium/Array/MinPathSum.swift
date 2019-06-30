//
//  MinPath.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/29/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MinPathSum: Runnable {
    func runTests() {
        let solution = SolutionRecursionMem()
        let input = [
            [1,3,1],
            [1,5,1],
            [4,2,1]
        ]
        print(solution.minPathSum(input))
    }
    
    private class SolutionDP {
        func minPathSum(_ grid: [[Int]]) -> Int {
            if grid.isEmpty { return 0 }
            var dp = [[Int]](repeating: [Int](repeating: 0, count: grid[0].count), count: grid.count)
            
            for row in stride(from: grid.count - 1, through: 0, by: -1) {
                for col in stride(from: grid[row].count - 1, through: 0, by: -1) {
                    // Base Case for the right most edge of the matrix, where we can't go anywhere.
                    if row == grid.count - 1 && col == grid[row].count - 1 {
                        dp[row][col] += grid[row][col]
                    }
                    // If we are on the bottom, and can't go down any more, just take the right.
                    else if row == grid.count - 1 && col != grid[row].count - 1 {
                        dp[row][col] += grid[row][col] + dp[row][col + 1]
                    }
                    // If we are on the right, and can't go right any more, just take the bottom.
                    else if row != grid.count - 1 && col == grid[row].count - 1 {
                        dp[row][col] += grid[row][col] + dp[row + 1][col]
                    }
                        // If we can still go down or right, take the min between either directions.
                    else {
                        dp[row][col] += grid[row][col] + min(dp[row + 1][col], dp[row][col + 1])
                    }
                }
            }
            return dp[0][0]
        }
    }
    
    private class SolutionRecursionMem {
        func minPathSum(_ grid: [[Int]]) -> Int {
            if grid.isEmpty { return 0 }
            var mem = [[Int]](repeating: [Int](repeating: Int.max, count: grid[0].count), count: grid.count)
            return traverse(grid, 0, 0, &mem)
        }
        
        private func traverse(_ grid: [[Int]], _ row: Int, _ col: Int, _ mem: inout [[Int]]) -> Int {
            // If we've reached the end of the array, stop.
            if row >= grid.count || col >= grid[0].count {
                return Int.max
            }
            else if row == grid.count - 1 && col == grid[0].count - 1 {
                return grid[row][col]
            }
            // If already memoized stop.
            else if mem[row][col] != Int.max {
                return mem[row][col]
            }
            // Traverse down or right
            let val = grid[row][col]
            let right = traverse(grid, row, col + 1, &mem)
            let down = traverse(grid, row + 1, col, &mem)
            
            // In case
            if col == Int.max && down == Int.max {
                mem[row][col] = val
            }
            else if right != Int.max && down != Int.max {
                mem[row][col] = min(val + right, val + down)
            }
            else if right != Int.max {
                mem[row][col] = val + right
            }
            else {
                mem[row][col] = val + down
            }
            return mem[row][col]
        }
    }
}
