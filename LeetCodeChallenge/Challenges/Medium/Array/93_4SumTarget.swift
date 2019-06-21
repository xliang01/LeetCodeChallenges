//
//  93_4SumTarget.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/21/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FourSumTarget: Runnable {
    func runTests() {
        let solution = SolutionMaxSumPointers()
        print(solution.fourSum([5,5,3,5,1,-5,1,-2], 4))
    }
    // 1 2 3 4 5
    private class SolutionMaxSumPointers {
        func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
            var nums = nums.sorted()
            if nums.count < 4 { return [] }
            
            var answer = [[Int]]()
            for i in 0..<(nums.count-3) {
                if i > 0 && nums[i] == nums[i-1] { continue }
                
                for j in i+1..<(nums.count-2) {
                    if j > i+1 && nums[j] == nums[j-1] { continue }
                    
                    var left = j+1
                    var right = nums.count - 1

                    while left < right {
                        let sum = nums[i] + nums[j] + nums[left] + nums[right]
                        
                        if sum < target {
                            left += 1
                        }
                        else if sum > target {
                            right -= 1
                        }
                        else {
                            answer.append([nums[i], nums[j], nums[left], nums[right]])
                            left += 1
                            right -= 1
                            
                            while right > left && nums[right] == nums[right+1] {
                                right -= 1
                            }
                            while left < right && nums[left] == nums[left-1] {
                                left += 1
                            }
                        }
                    }
                }
            }
            return answer
        }
    }
}
