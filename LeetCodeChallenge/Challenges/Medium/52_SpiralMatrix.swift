//
//  52_SpiralMatrix.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SpiralMatrix: Runnable {
    func runTests() {
        let matrix1 = [
            [ 1, 2, 3 ],
            [ 4, 5, 6 ],
            [ 7, 8, 9 ]
        ]
        
        let solution1 = SolutionDirectionArrays()
        print(solution1.spiralOrder(matrix1))
    }
    
    private class SolutionDirectionArrays {
        func spiralOrder(_ matrix: [[Int]]) -> [Int] {
            guard !matrix.isEmpty else { return [] }
            var answers = [Int]()
            
            let width = matrix[0].count
            let height = matrix.count
            
            // Get the row index, col index and direction index default to 0
            var row = 0
            var col = 0
            var di = 0
            // The array used to determine the direction of how the spiral matrix is advancing in the X direction (col)
            let dx = [1, 0, -1, 0]
            // The array used to determine the direction of how the spiral matrix is advancing in the Y direction (row)
            let dy = [0, 1, 0, -1]
            // Mark the visited as false.
            var visited = [[Bool]](repeating: [Bool](repeating: false, count: width), count: height)
            
            // Iterate through the entire array
            for _ in 0..<width * height {
                // Append the answer and mark as visited.
                answers.append(matrix[row][col])
                visited[row][col] = true
                // Set the direction PREVIEW for the col and row. This temporary variable is used to determine if we've
                // exceeded the dimensions of hte matrix.
                let c = col + dx[di]
                let r = row + dy[di]
                
                // If we did exceed the matrix, increment the direction index to change directions.
                if c < 0 || c >= width || r < 0 || r >= height || visited[c][r] {
                    di = (di + 1) % 4
                    // Change directions now.
                    col += dx[di]
                    row += dy[di]
                }
                // If we're still in the bounds of the matrix, keep the direction
                else {
                    col = c
                    row = r
                }
            }
            
            return answers
        }
    }
}
