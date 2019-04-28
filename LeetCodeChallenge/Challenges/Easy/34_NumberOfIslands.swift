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
        let solution1 = SolutionDFSWithZeroes()
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
}
