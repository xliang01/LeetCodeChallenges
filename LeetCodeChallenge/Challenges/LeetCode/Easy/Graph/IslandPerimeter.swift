//
//  IslandPerimeter.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class IslandPerimeter: Runnable {
    func runTests() {
        let solution = SolutionDFS()
        let grid = [[0,1,0,0],
                    [1,1,1,0],
                    [0,1,0,0],
                    [1,1,0,0]]
        print(solution.islandPerimeter(grid))
    }
    
    private class SolutionDFS {
        func islandPerimeter(_ grid: [[Int]]) -> Int {
            var perimeters = 0
            for row in 0..<grid.count {
                for col in 0..<grid[row].count {
                    if grid[row][col] != 1 {
                        continue
                    }
                    
                    let up = row - 1 >= 0 ? grid[row - 1][col] : 0
                    let down = row + 1 < grid.count ? grid[row + 1][col] : 0
                    let left = col - 1 >= 0 ? grid[row][col - 1] : 0
                    let right = col + 1 < grid[0].count ? grid[row][col + 1] : 0
                    
                    if up == 0 { perimeters += 1 }
                    if down == 0 { perimeters += 1 }
                    if left == 0 { perimeters += 1 }
                    if right == 0 { perimeters += 1 }
                }
            }
            return perimeters
        }
    }
}
