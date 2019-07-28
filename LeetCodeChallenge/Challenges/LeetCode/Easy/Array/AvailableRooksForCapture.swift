//
//  AvailableRooksForCapture.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AvailableRooksForCapture: Runnable {
    func runTests() {
        let solution = SolutionIteration()
        let board: [[Character]] =
        [
            [".",".",".",".",".",".",".","."],
            [".",".",".","p",".",".",".","."],
            [".",".",".","R",".",".",".","p"],
            [".",".",".",".",".",".",".","."],
            [".",".",".",".",".",".",".","."],
            [".",".",".","p",".",".",".","."],
            [".",".",".",".",".",".",".","."],
            [".",".",".",".",".",".",".","."]
        ]
        print(solution.numRookCaptures(board))
    }
    
    private class SolutionIteration {
        func numRookCaptures(_ board: [[Character]]) -> Int {
            let rows = board.count
            let cols = board[0].count
            
            var count = 0
            for row in 0..<rows {
                for col in 0..<cols {
                    if board[row][col] == "R" {
                        var right = col + 1
                        while right < cols {
                            if board[row][right] == "p" {
                                count += 1
                                break
                            }
                            else if isEmpty(board, row, right) {
                                right += 1
                            }
                            else {
                                break
                            }
                        }
                        
                        var left = col - 1
                        while left >= 0 {
                            if board[row][left] == "p" {
                                count += 1
                                break
                            }
                            else if isEmpty(board, row, left) {
                                left -= 1
                            }
                            else {
                                break
                            }
                        }
                        
                        var top = row - 1
                        while top >= 0 {
                            if board[top][col] == "p" {
                                count += 1
                                break
                            }
                            else if isEmpty(board, top, col) {
                                top -= 1
                            }
                            else {
                                break
                            }
                        }
                        
                        var bottom = row + 1
                        while bottom < rows {
                            if board[bottom][col] == "p" {
                                count += 1
                                break
                            }
                            else if isEmpty(board, bottom, col) {
                                bottom += 1
                            }
                            else {
                                break
                            }
                        }
                        
                        return count
                    }
                }
            }
            
            return 0
            
            /*
             [[".",".",".",".",".",".",".","."],
             [".",".",".","p",".",".",".","."],
             [".",".",".","R",".",".",".","p"],
             [".",".",".",".",".",".",".","."],
             [".",".",".",".",".",".",".","."],
             [".",".",".","p",".",".",".","."],
             [".",".",".",".",".",".",".","."],
             [".",".",".",".",".",".",".","."]]
             
             [[".",".",".",".",".",".",".","."],
             [".",".",".","p",".",".",".","."],
             [".",".",".","p",".",".",".","."],
             ["p","p",".","R",".","p","B","."],
             [".",".",".",".",".",".",".","."],
             [".",".",".","B",".",".",".","."],
             [".",".",".","p",".",".",".","."],
             [".",".",".",".",".",".",".","."]]
             
             [[".",".",".",".",".",".",".","."],
             [".","p","p","p","p","p",".","."],
             [".","p","p","B","p","p",".","."],
             [".","p","B","R","B","p",".","."],
             [".","p","p","B","p","p",".","."],
             [".","p","p","p","p","p",".","."],
             [".",".",".",".",".",".",".","."],
             [".",".",".",".",".",".",".","."]]*/
        }
        
        private func isEmpty(_ board: [[Character]],
                             _ row: Int,
                             _ col: Int) -> Bool {
            return board[row][col] == "."
        }
    }
}
