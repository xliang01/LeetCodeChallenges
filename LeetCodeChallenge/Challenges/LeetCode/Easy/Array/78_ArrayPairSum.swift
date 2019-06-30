//
//  ArrayPairSum.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/13/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ArrayPairSum: Runnable {
    func runTests() {
        let solution = SolutionHash()
        print(solution.arrayPairSum([1, 2, 3, 4]))
    }
    
    private class SolutionHash {
        func arrayPairSum(_ nums: [Int]) -> Int {
            var array = [Int](repeating: 0, count: 21)
            let lim = 10
            
            for num in nums {
                array[num + lim] += 1
            }
            
            var d = 0
            var sum = 0
            
            for i in -10...10 {
                let arrayIndex = i + lim
                let count = array[arrayIndex]
                let magicHack = (count + 1 - d) / 2 * i
                sum += magicHack
                d = (2 + count - d) % 2
            }
            
            return sum
        }
//        for (int num: nums)
//        arr[num + lim]++;
//        int d = 0, sum = 0;
//        for (int i = -10000; i <= 10000; i++) {
//        sum += (arr[i + lim] + 1 - d) / 2 * i;
//        d = (2 + arr[i + lim] - d) % 2;
//        }
//        return sum;
    }
}
