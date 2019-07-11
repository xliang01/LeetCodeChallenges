//
//  AlgoBoggleBoard.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/7/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoBoggleBoard: Runnable {
    func runTests() {
        let solution = SolutionDFS()
        let input: [[Character]] = [
            ["y", "g", "f", "y", "e", "i"],
            ["c", "o", "r", "p", "o", "u"],
            ["j", "u", "z", "s", "e", "l"],
            ["s", "y", "u", "r", "h", "p"],
            ["e", "a", "e", "g", "n", "d"],
            ["h", "e", "l", "s", "a", "t"]
        ]
        print(solution.boggleBoard(input, ["san",
                                           "sana",
                                           "at",
                                           "vomit",
                                           "yours",
                                           "help",
                                           "end",
                                           "been",
                                           "bed",
                                           "danger",
                                           "calm",
                                           "ok",
                                           "chaos",
                                           "complete",
                                           "rear",
                                           "going",
                                           "storm",
                                           "face",
                                           "equal",
                                           "dangerous"]))
    }
    
    private class SolutionDFS {
        func boggleBoard(_ board: [[Character]], _ words: [String]) -> [String] {
            var wordsFound = [String]()
            
            for word in words {
                if !findWord(board, word).isEmpty {
                    wordsFound.append(word)
                }
            }
            
            return wordsFound
        }
        
        func findWord(_ board: [[Character]],
                      _ word: String) -> String {
            let chars = Array<Character>(word)
            var visited = [[Bool]](repeating: [Bool](repeating: false, count: board[0].count), count: board.count)
            
            for row in board.indices {
                for col in board[0].indices {
                    if dfs(board, row, col, 0, &visited, chars) {
                        return word
                    }
                }
            }
            return ""
        }
        
        func dfs(_ board: [[Character]],
                 _ row: Int,
                 _ col: Int,
                 _ index: Int,
                 _ visited: inout [[Bool]],
                 _ chars: [Character]) -> Bool {
            // If we are out of bounds, return false.
            if row < 0 || row >= board.count || col < 0 || col >= board[0].count || visited[row][col] {
                return false
            }
            // If we are at the end of the word, it means nothing before this point stopped from a successful search. Return true.
            else if index == chars.count {
                return true
            }
            
            visited[row][col] = true
            if board[row][col] == chars[index] {
                var hasFound = false
                // Go through all directions fo the search.
                for i in -1...1 {
                    for j in -1...1 {
                        hasFound = hasFound || dfs(board,
                                                   row + i,
                                                   col + j,
                                                   index + 1,
                                                   &visited,
                                                   chars)
                    }
                }
                return hasFound
            }
            // Must backtrack here because this word may be used in a different search.
            visited[row][col] = false
            return false
        }
    }
    
}
