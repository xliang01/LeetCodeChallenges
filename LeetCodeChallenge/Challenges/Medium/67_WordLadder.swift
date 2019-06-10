//
//  67_WordLadder.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/9/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation


/**
     Given two words (beginWord and endWord), and a dictionary's word list, find the length of shortest transformation sequence from beginWord to endWord, such that:
 
     Only one letter can be changed at a time.
     Each transformed word must exist in the word list. Note that beginWord is not a transformed word.
     Note:
 
     Return 0 if there is no such transformation sequence.
     All words have the same length.
     All words contain only lowercase alphabetic characters.
     You may assume no duplicates in the word list.
     You may assume beginWord and endWord are non-empty and are not the same.
 
     Example 1:
 
         Input:
         beginWord = "hit",
         endWord = "cog",
         wordList = ["hot","dot","dog","lot","log","cog"]
 
         Output: 5
 
         Explanation: As one shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
         return its length 5.
 
     Example 2:
 
         Input:
         beginWord = "hit"
         endWord = "cog"
         wordList = ["hot","dot","dog","lot","log"]
 
         Output: 0
 
         Explanation: The endWord "cog" is not in wordList, therefore no possible transformation.
 */
class WordLadder: Runnable {
    func runTests() {
        let solution = SolutionBFSSimplified()
        print(solution.ladderLength("hit", "cog", ["hot","dot","dog","lot","log","cog"]))
    }
    
    private class SolutionBFS {
        func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
            guard wordList.contains(endWord) else { return 0 }
            let wordLength = beginWord.count
            let adjacentWordsLookup = prepareAdjacentWordsLookup(wordList, wordLength)
            var visited = Set<String>()
            
            var queue = [(String, Int)]()
            queue.append((beginWord, 1))
            
            while !queue.isEmpty {
                let tuple = queue.removeFirst()
                let word = tuple.0
                let level = tuple.1
                
                let wordChars = Array<Character>(word)
                
                for i in 0..<wordChars.count {
                    let pattern = getWordPattern(wordChars, i)
                    
                    if let adjacentWords = adjacentWordsLookup[pattern] {
                        for adajcentWord in adjacentWords {
                            if adajcentWord == endWord {
                                return level + 1
                            }
                            else if !visited.contains(adajcentWord) {
                                queue.append((adajcentWord, level+1))
                                visited.insert(adajcentWord)
                            }
                        }
                    }
                }
            }
            
            return 0
        }
        
        func prepareAdjacentWordsLookup(_ wordList: [String], _ wordLength: Int) -> [String: Set<String>] {
            let wordLength = wordList[0].count
            var adjacentWordsLookup = [String: Set<String>]()
            
            for word in wordList {
                for i in 0..<wordLength {
                    let wordChars = Array<Character>(word)
                    let pattern = getWordPattern(wordChars, i)
                    
                    if adjacentWordsLookup[pattern] == nil {
                        adjacentWordsLookup[pattern] = Set<String>()
                    }
                    adjacentWordsLookup[pattern]!.insert(word)
                }
            }
            return adjacentWordsLookup
        }
        
        private func getWordPattern(_ wordChars: [Character], _ index: Int) -> String {
            return ("\(String(wordChars[0..<index]))*\(String(wordChars[(index+1)..<wordChars.count]))")
        }
    }
    
    private class SolutionDualBFS {
        func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
            if !wordList.contains(endWord) {
                return 0
            }
            
            let a2z = "abcdefghijklmnopqrstuvwxyz"
            var beginSet = Set<String>()
            var endSet = Set<String>()
            var len = 1
            var visit = Set<String>()
            
            beginSet.insert(beginWord)
            endSet.insert(endWord)
            while !beginSet.isEmpty && !endSet.isEmpty {
                if beginSet.count > endSet.count {
                    swap(&beginSet, &endSet)
                }
                var temp = Set<String>()
                for word in beginSet {
                    var chars = Array<Character>(word)
                    for i in 0..<chars.count {
                        for char in Array<Character>(a2z) {
                            let old = chars[i]
                            chars[i] = char
                            let target = String(chars)
                            if endSet.contains(target) {
                                return len + 1
                            }
                            if !visit.contains(target) && wordList.contains(target) {
                                temp.insert(target)
                                visit.insert(target)
                            }
                            chars[i] = old
                        }
                    }
                }
                beginSet = temp
                len += 1
            }
            
            return 0
        }
    }
    
    // Doesn't work
    
    private class SolutionBFSSimplified {
        func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
            if !wordList.contains(endWord) { return 0 }

            var visited = Set<String>()
            var queue = [(String, Int)]()

            visited.insert(beginWord)
            queue.append((beginWord, 1))

            while !queue.isEmpty {
                let data = queue.removeFirst()
                let word = data.0
                let level = data.1

                for nextWord in wordList {
                    if isTraversable(word, nextWord) {
                        if nextWord == endWord { return level + 1 }
                        if visited.contains(nextWord) { continue }

                        visited.insert(nextWord)
                        queue.append((nextWord, level + 1))
                    }
                }
            }

            return 0
        }

        private func isTraversable(_ word: String, _ nextWord: String) -> Bool {
            let wordChars = Array<Character>(word)
            let nextWordChars = Array<Character>(nextWord)

            var count = 0
            for i in 0..<wordChars.count {
                count += (wordChars[i] != nextWordChars[i] ? 1 : 0)
            }
            return count == 1
        }
    }
}
