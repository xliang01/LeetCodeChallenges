//
//  HighFive.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/3/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class HighFive: Runnable {
    func runTests() {
        let solution = SolutionMinHeap()
        print(solution.highfive([[1,91],[1,92],[2,93],[2,97],[1,60],[2,77],[1,65],[1,87],[1,100],[2,100],[2,76]]))
    }
    
    private class SolutionMinHeap {
        func highfive(_ items: [[Int]]) -> [[Int]] {
            var map = [Int: Heap<Int>]()
            var ids = [Int]()
            var ans = [[Int]]()
            
            for i in items {
                let id = i[0]
                let score = i[1]
                if map[id] == nil {
                    map[id] = Heap<Int>(sort: { $0 > $1 })
                    ids.append(id)
                }
                map[id]?.insert(score)
            }
            
            for id in ids {
                if var queue = map[id] {
                    var sum = 0
                    var count = 0
                    while !queue.isEmpty, count < 5 {
                        let score = queue.remove()!
                        sum += score
                        count += 1
                    }
                    ans.append([id, sum/count])
                }
            }
            
            return ans
        }
    }
}
