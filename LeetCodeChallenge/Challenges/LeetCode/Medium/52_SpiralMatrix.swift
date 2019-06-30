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
        
        let matrix2 = [
            [1,2,3,4],
            [5,6,7,8],
            [9,10,11,12]
        ]
        
        let matrix3 = [[2,3]]
        let matrix4 = [[1,2],[3,4]]
        
        let solution1 = SolutionDirectionArrays()
        print(solution1.spiralOrder(matrix1))
        print(solution1.spiralOrder(matrix2))
        print(solution1.spiralOrder(matrix3))
        print(solution1.spiralOrder(matrix4))
        
        let solution2 = SolutionBoundingArrays()
        print(solution2.spiralOrder(matrix1))
        print(solution2.spiralOrder(matrix2))
        print(solution2.spiralOrder(matrix3))
        print(solution2.spiralOrder(matrix4))
    }
    
    private class SolutionBoundingArrays {
        /**
            Solution:
         
            Iterate the outer edges of the array using a bounding box. Then close the bounding box until only the
            center remains.
         
            Performance:
         
            Time Complexity: O(N * M) iterate through the bounding box.
            Space Complexity: O(N * M) to keep track of all elements that have been visited, and the answers array.
        */
        func spiralOrder(_ matrix: [[Int]]) -> [Int] {
            guard !matrix.isEmpty else { return [] }
            var answers = [Int]()
            
            var left = 0
            var right = matrix[0].count - 1
            var top = 0
            var bottom = matrix.count - 1
            
            while left <= right && top <= bottom {
                var col = left
                while col <= right {
                    answers.append(matrix[top][col])
                    col += 1
                }
                var row = top + 1
                while row <= bottom {
                    answers.append(matrix[row][right])
                    row += 1
                }
                
                if left < right && top < bottom {
                    col = right - 1
                    while col >= left + 1 {
                        answers.append(matrix[bottom][col])
                        col -= 1
                    }
                    row = bottom
                    while row >= top + 1 {
                        answers.append(matrix[row][left])
                        row -= 1
                    }
                }
                
                left += 1
                right -= 1
                top += 1
                bottom -= 1
            }
            return answers
        }
    }
    
    private class SolutionDirectionArrays {
        /**
            Solution:
         
            The tricky part for this problem is that we cannot iterate normally using i = 0 to height, and j = 0 to width.
            This is because we have to change directions in the array. To actually handle this, we need to keep separate
            variables called "row" and "col" which both start at 0. However, to determine which direction we want to
            travel to, we keep a direction matrix of dx (which dictates how the col moves in the x axis), and dy (which
            dictates how the row moves in the y axis).
         
                dx: [1, 0, -1, 0]
                dy: [0, 1, 0, -1]
         
            To iterate through the entire array, we actually go from i = 0 to height * width. This allows us to travel
            through every index in the array. The TRICK is to determine which col and row will be used as i increments.
         
            As we traverse through row and col, we want to mark these coordinates as visited. The visited matrix is used
            for dynamic programming so we keep track of which graph node has already been visited.
         
            As row increments, and col increments, we check if they have exceeded the bounds of the matrix OR if the
            next row or col has been visited. If not, then do
         
                row = row + dy[di]
                col = col + dx[di]
         
            Where di is the index that marks where the value of dx and dy are. This basically gets MODed to 4 so it can
            indefinitely cycle through the directions array.
         
            Now if the row and col increments exceed the bounds of the matrix, we have to increment di so that the
            correct direction for dx and dy can be derived. Afterward, we just keep iterating until we get to the
            end of the array.
         
            Performance Analysis:
         
            Time Complexity: O(N * M) to iterate through all elements in the array.
            Space Complexity: O(N * M) to keep track of all elements that have been visited, and the answers array.
        */
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
                if c < 0 || c >= width || r < 0 || r >= height || visited[r][c] {
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
