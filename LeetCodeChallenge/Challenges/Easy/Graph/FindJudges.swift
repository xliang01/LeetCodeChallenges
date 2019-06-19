//
//  FindJudges.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/19/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FindJudges: Runnable {
    func runTests() {
        let solution = SolutionMatrix()
//        print(solution.findJudge(2, [[1,2]]))
//        print(solution.findJudge(3, [[1,3],[2,3]]))
//        print(solution.findJudge(3, [[1,3],[2,3],[3,1]]))
//        print(solution.findJudge(3, [[1,2],[2,3]]))
        print(solution.findJudge(4, [[1,3],[1,4],[2,3],[2,4],[4,3]]))
    }
    
    private class SolutionMatrix {
        func findJudge(_ N: Int, _ trust: [[Int]]) -> Int {
            var inAndOut = Array(repeating: Array(repeating: 0, count: 2), count: N)
            
            for edge in trust {
                inAndOut[edge[0] - 1][1] += 1
                inAndOut[edge[1] - 1][0] += 1
            }
            
            print("p: [Trusted By] [Trusting]")
            for (r, row) in inAndOut.enumerated() {
                var strings = [String]()
                for col in row {
                    strings.append("[\(col)]")
                }
                print("\(r + 1): \(strings.joined(separator: "          "))")
            }
            
            for i in 0..<N {
                if (inAndOut[i][0] == N - 1 && inAndOut[i][1] == 0) {
                    return i + 1
                }
            }
            
            return -1
        }
    }
    
    private class SolutionMap {
        func findJudge(_ N: Int, _ trust: [[Int]]) -> Int {
            if trust.count == 0 { return 1 }
            if trust.count == 1 { return trust[0][1] }
            
            var townsFolk = [Int: [Int]]()
            
            for folk in trust {
                let truster = folk[0]
                let trustee = folk[1]
                
                if townsFolk[truster] == nil {
                    townsFolk[truster] = []
                }
                townsFolk[truster]?.append(trustee)
            }
            
            var judge: Int = -1
            var count = 0
            for folk in trust {
                let trustee = folk[1]
                
                if townsFolk[trustee] == nil {
                    count += 1
                    judge = trustee
                }
            }
            
            return count == N - 1 ? judge : -1
        }
    }
}
