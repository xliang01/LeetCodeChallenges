//
//  51_WordSearch.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/29/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class WordSearch: Runnable {
    func runTests() {
        let solution1 = SolutionBackTracking()
        
        let board:[[Character]] =
            [
                ["A","B","C","E"],
                ["S","F","C","S"],
                ["A","D","E","E"]
            ]
        
        print(solution1.exist(board, "ABCCE"))
        print(solution1.exist(board, "SEE"))
        print(solution1.exist(board, "AF"))

        let board2:[[Character]] =
            [
                ["A","A","A","S"],
                ["A","A","A","A"],
                ["A","A","A","A"]
        ]

        print(solution1.exist(board2, "AAAAAAAAAAAS"))
    }
    
    /**
        Solution:
     
        Use DFS with backtracking to find all permutations of the board, and find the one permutation that creates the word.
        If no permutations exist, return false on all stacks.
     
        Performance:
     
        Time Complexity: O(NM*4^S) Where N is the height of the board, M is the width of the board,
        4 are the directions, and S is the length of the word.
     
        Space Complexity: O(N*M + S) where the first O(NM) is for the DFS visited map. The second O(S) is for the total
        number of recursions that will be popped when matching the word of length S.
    */
    private class SolutionBackTracking {
        func exist(_ board: [[Character]], _ word: String) -> Bool {
            if board.isEmpty || word.isEmpty { return false }
            let width = board[0].count
            let height = board.count
            let characters = Array<Character>(word)
            var visited = [[Bool]](repeating: [Bool](repeating: false, count: width), count: height)
            
            for col in 0..<width {
                for row in 0..<height {
                    if dfsBackTrack(board, &visited, characters, 0, row, col) {
                        return true
                    }
                }
            }
            return false
        }
        
        func dfsBackTrack(_ board: [[Character]],
                          _ visited: inout [[Bool]],
                          _ characters: [Character],
                          _ characterIndex: Int,
                          _ row: Int,
                          _ col: Int) -> Bool {
            if characterIndex == characters.count { return true }
            if col < 0 || col >= board[0].count || row < 0 || row >= board.count || visited[row][col] { return false }
            
            visited[row][col] = true
            if board[row][col] == characters[characterIndex] {
                let left = col - 1
                let right = col + 1
                let top = row - 1
                let bottom = row + 1
                if
                    dfsBackTrack(board, &visited, characters, characterIndex + 1, row, left) ||
                    dfsBackTrack(board, &visited, characters, characterIndex + 1, row, right) ||
                    dfsBackTrack(board, &visited, characters, characterIndex + 1, top, col) ||
                    dfsBackTrack(board, &visited, characters, characterIndex + 1, bottom, col) {
                    return true
                }
            }
            visited[row][col] = false
            
            return false
        }
    }
}
