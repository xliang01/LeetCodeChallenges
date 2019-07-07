//
//  AlgoDiskStacking.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/7/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoDiskStacking: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.diskStacking([[2,1,2], [3,2,3], [2,2,8], [2,3,4], [1,2,1], [4,4,5]]))
    }
    
    private class SolutionDP {
        func diskStacking(_ disks: [[Int]]) -> [[Int]] {
            let disks = disks.sorted { (lhs, rhs) -> Bool in
                return lhs[2] < rhs[2]
            }
            
            var maxHeight = 0
            var dp = [Int](repeating: 0, count: disks.count)
            
            var rebuildSequences = [Int](repeating: -1, count: disks.count)
            var maxHeightIndex = -1
            
            // Get the sorted disk max height.
            for i in disks.indices {
                dp[i] = disks[i][2]
            }
            
            for i in disks.indices {
                for j in 0..<i {
                    // Check if this is even a valid disk to stack
                    if isValidDisk(disks, i, j) {
                        // Get the current disk height
                        let currentDiskHeight = disks[i][2]
                        // Get the previous acculated disk height. This is memoized of the previous disks.
                        let otherDiskAccumulatedHeight = dp[j]
                        // Get the total height between the accumulated disk and the current disk.
                        let totalHeight = currentDiskHeight + otherDiskAccumulatedHeight
                        
                        // If the total height is larger than the current dp height, replace with new total height.
                        // This is because we used the accumulated height of the previous disk and the current disk to get the new height.
                        if totalHeight > dp[i] {
                            dp[i] = totalHeight
                            maxHeight = max(maxHeight, totalHeight)
                            rebuildSequences[i] = j
                            maxHeightIndex = i
                        }
                    }
                }
            }
            
            return buildSequence(disks, maxHeightIndex, rebuildSequences)
        }
        
        func isValidDisk(_ disks: [[Int]], _ i: Int, _ j: Int) -> Bool {
            let current = disks[i]
            let other = disks[j]
            
            return
                other[0] < current[0] &&
                other[1] < current[1] &&
                other[2] < current[2]
        }
        
        func buildSequence(_ disks: [[Int]], _ maxHeightIndex: Int, _ sequences: [Int]) -> [[Int]] {
            var ans = [[Int]]()
            var maxHeightIndex = maxHeightIndex
            
            while maxHeightIndex != -1 {
                let disk = disks[maxHeightIndex]
                ans.append(disk)
                maxHeightIndex = sequences[maxHeightIndex]
            }
            return ans.reversed()
        }
    }
}
