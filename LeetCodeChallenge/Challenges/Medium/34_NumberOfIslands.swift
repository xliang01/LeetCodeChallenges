//
//  34_NumberOfIslands.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

private struct TestInput {
    static var input1: [[Character]] {
        return [
            Array<Character>("11110"),
            Array<Character>("11010"),
            Array<Character>("11000"),
            Array<Character>("00000"),
        ]
    }
    
    static var input2: [[Character]] {
        return [
            Array<Character>("11000"),
            Array<Character>("11000"),
            Array<Character>("00100"),
            Array<Character>("00011"),
        ]
    }
}

class NumberOfIslands: Runnable {
    func runTests() {
        let solution1 = SolutionBFS()
        print(solution1.numIslands(TestInput.input1))
        print(solution1.numIslands(TestInput.input2))
    }
    
    private class SolutionDFS {
        func numIslands(_ grid: [[Character]]) -> Int {
            guard !grid.isEmpty else {
                return 0
            }
            
            var hasVisited = [Bool](repeating: false, count: grid.count * grid[0].count)
            var islandCount = 0
            for row in (0..<grid.count) {
                for col in (0..<grid[row].count) {
                    let stackIndex = getStackIndex(grid, row, col)
                    if !hasVisited[stackIndex] && grid[row][col] == "1" {
                        islandCount += 1
                    }
                    dfs(grid, row, col, &hasVisited)
                }
            }
            
            return islandCount
        }
        
        private func dfs(_ grid: [[Character]],
                         _ row: Int,
                         _ col: Int,
                         _ hasVisited: inout [Bool]) {
            // Base Case: Out of bounds due to ocean.
            if row < 0 || row >= grid.count || col < 0 || col >= grid[row].count { return }
            let stackIndex = getStackIndex(grid, row, col)
            if hasVisited[stackIndex] { return }
            
            let coordinate = grid[row][col]
            hasVisited[stackIndex] = true
            
            // If this is an ocean, then just return.
            if coordinate == "1" {
                dfs(grid, row + 1, col, &hasVisited)
                dfs(grid, row - 1, col, &hasVisited)
                dfs(grid, row, col + 1, &hasVisited)
                dfs(grid, row, col - 1, &hasVisited)
            }
        }
        
        private func getStackIndex(_ grid: [[Character]],
                                   _ row: Int,
                                   _ col: Int) -> Int {
            return (row * grid[row].count) + col
        }
    }
    
    private class SolutionDFSWithZeroes {
        
        /**
            Using the Depth First Search, iterate through each node and determine if the coordinate is an island.
            If it is, mark the island as "0" (similar to how we flag visited). Then traverse all available coordinates
            surrounding it. Keep doing this until all coordinates are marked as 0s.
         
            DFS works because when we pick one coordinate in the array, we will change all nodes to 0 that are islands
            adjacent to the current node. So each coordinate that is still a 1 in the iteration will be a unique
            island, because the previous coordinate would have had all adjacent coordinates marked as 0.
         
            Performance:
         
            Time Complexity: O(mn) where m is the number of rows, and n is the number of columns.
            Space Complexity: O(mn) as recursion will visit each children mn times if the entire grid is an island. This
            creates an mn number of recursive calls.
        */
        func numIslands(_ grid: [[Character]]) -> Int {
            guard !grid.isEmpty else {
                return 0
            }
            
            var grid = grid
            var islandCount = 0
            
            for row in (0..<grid.count) {
                for col in (0..<grid[row].count) {
                    if grid[row][col] == "1" {
                        islandCount += 1
                    }
                    dfs(&grid, row, col)
                }
            }
            
            return islandCount
        }
        
        private func dfs(_ grid: inout [[Character]],
                         _ row: Int,
                         _ col: Int) {
            // Base Case: Out of bounds due to ocean or current coordinate is an ocean.
            if row < 0 || row >= grid.count || col < 0 || col >= grid[row].count || grid[row][col] == "0" {
                return
            }
            
            // Assign the current island value to 0 to mark it's been traversed.
            grid[row][col] = "0"
            dfs(&grid, row + 1, col)
            dfs(&grid, row - 1, col)
            dfs(&grid, row, col + 1)
            dfs(&grid, row, col - 1)
        }
    }
    
    private class SolutionBFS {
        /**
            Using the Breadth First Search, iterate through each node and determine if the coordinate is an island.
            If it is, mark the island as "0" (similar to how we flag visited). Then traverse all available coordinates
            surrounding it. Keep doing this until all coordinates are marked as 0s.

            BFS works because when we pick one coordinate in the array, we queue all the surrounding coordinates that are
            also an island (1). Then in the queue, we pop from the queue and do this again until all islands are traversed.
            Each island then becomes 0 until no more connected islands exist.

            Performance:

            Time Complexity: O(mn) where m is the number of rows, and n is the number of columns.
            Space Complexity: O(mn) because in the worst case, we have to traverse very vertex with a possible island edge.
         */
        func numIslands(_ grid: [[Character]]) -> Int {
            guard !grid.isEmpty else { return 0 }
            var grid = grid
            var islandCount = 0
            
            for row in (0..<grid.count) {
                let rowCount = grid[row].count
                
                for col in (0..<grid[row].count) {
                    if grid[row][col] == "1" {
                        islandCount += 1
                        grid[row][col] = "0"
                        
                        var queue = [Int]()
                        queue.append(row * rowCount + col)
                        
                        while !queue.isEmpty {
                            let index = queue.removeFirst()
                            let queueRow = index / rowCount
                            let queueCol = index % rowCount
                            let left = queueCol - 1
                            let right = queueCol + 1
                            let top = queueRow - 1
                            let bottom = queueRow + 1
                            
                            if left >= 0 && grid[queueRow][left] == "1" {
                                grid[queueRow][left] = "0"
                                queue.append(queueRow * rowCount + left)
                            }
                            
                            if right < rowCount && grid[queueRow][right] == "1" {
                                grid[queueRow][right] = "0"
                                queue.append(queueRow * rowCount + right)
                            }
                            
                            if top >= 0 && grid[top][queueCol] == "1" {
                                grid[top][queueCol] = "0"
                                queue.append(top * rowCount + queueCol)
                            }
                            
                            if bottom < grid.count && grid[bottom][queueCol] == "1" {
                                grid[bottom][queueCol] = "0"
                                queue.append(bottom * rowCount + queueCol)
                            }
                        }
                    }
                }
            }
            return islandCount
        }
    }
}
