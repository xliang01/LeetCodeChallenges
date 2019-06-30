//
//  42_MaxArea.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/14/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MaxArea: Runnable {
    func runTests() {
        let solution1 = SolutionMatrix()
        print(solution1.maxArea([1,8,6,2,5,4,8,3,7]))
        print(solution1.maxArea([1,8]))
        
        let solution2 = SolutionPointer()
        print(solution2.maxArea([1,8,6,2,5,4,8,3,7]))
        print(solution2.maxArea([1,8]))
    }
    
    private class SolutionMatrix {
        func maxArea(_ height: [Int]) -> Int {
            var max = 0
            for i in (0..<height.count) {
                for j in (i + 1..<height.count) {
                    let area = (j - i) * min(height[i], height[j])
                    if max < area {
                        max = area
                    }
                }
            }
            return max
        }
    }
    
    private class SolutionPointer {
        /**
            Solution:
         
            From the left and the right, attempt to get the max area by determining which side is shorter. If the left
            side is shorter, increment to try and get a bigger area. If the right is shorter, decrement to try and get
            a bigger area. When the left and right cross, we've found all the maximized possibilities.
         
            Performance Analysis:
         
            Time Complexity: O(N) to move the pointers.
            Space Complexity: O(1) as no new data structures are added.
         */
        func maxArea(_ height: [Int]) -> Int {
            var left = 0
            var right = height.count - 1
            var max = 0
            
            while left < right {
                let area: Int
                let distance = right - left
                if height[left] <= height[right] {
                    area = height[left] * distance
                    left += 1
                }
                else {
                    area = height[right] * distance
                    right -= 1
                }
                if max < area {
                    max = area
                }
            }
            
            return max
        }
    }
}
