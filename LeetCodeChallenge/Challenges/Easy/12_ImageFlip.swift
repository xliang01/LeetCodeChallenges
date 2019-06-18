//
//  12_ImageFlip.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ImageFlip: Runnable {
    func runTests() {
        let solution1 = SolutionArrayModify()
        print(solution1.flipAndInvertImage([[1,1,0],[1,0,1],[0,0,0]]))
        print(solution1.flipAndInvertImage([[1,1,0,0],[1,0,0,1],[0,1,1,1],[1,0,1,0]]))
        
        let solution2 = SolutionArraySwapAndInvert()
        print(solution2.flipAndInvertImage([[1,1,0],[1,0,1],[0,0,0]]))
        print(solution2.flipAndInvertImage([[1,1,0,0],[1,0,0,1],[0,1,1,1],[1,0,1,0]]))
    }
    
    private class SolutionArrayModify {
        func flipAndInvertImage(_ A: [[Int]]) -> [[Int]] {
            var A = A
            for index in (0..<A.count) {
                var array = A[index]
                swapArray(&array)
                invertArray(&array)
                A[index] = array
            }
            return A
        }
        
        private func swapArray(_ array: inout [Int]) {
            let size = array.count
            for left in (0..<size/2) {
                let temp = array[left]
                let right = size - 1 - left
                array[left] = array[right]
                array[right] = temp
            }
        }
        
        private func invertArray(_ array: inout [Int]) {
            for index in (0..<array.count) {
                array[index] = array[index] ^ 1
            }
        }
    }
    
    private class SolutionArraySwapAndInvert {
        /**
            In array flip and invert. Inverting is done with the bit operator ^ for XOR.
            1 ^ 1 = 0, 1 ^ 0 = 1.
         
            Performance:
         
            Runtime Complexity: O(N) because you have to iterate through all of the array.
            Space Complexity: O(1) because no data structures were added.
         */
        func flipAndInvertImage(_ A: [[Int]]) -> [[Int]] {
            var A = A
            let L = A[0].count
            
            for (index, var bits) in A.enumerated() {
                for left in (0..<(L + 1)/2) {
                    let right = L - left - 1
                    let bit = bits[left] ^ 1
                    bits[left] = bits[right] ^ 1
                    bits[right] = bit
                }
                A[index] = bits
            }
            return A
        }
    }
}
