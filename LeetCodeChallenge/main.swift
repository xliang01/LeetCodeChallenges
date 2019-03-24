//
//  main.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/18/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

protocol Runnable {
    func runTests()
}

func run(_ runnable: Runnable) {
    runnable.runTests()
}

//run(TwoSums())
//run(TwoSumsBST())
//run(TwoSumsOOP())
//run(JewelsAndStones())
//run(AnagramMappings())
//run(ToLowerString())
//run(UniqueEmails())
//run(MorseCode())
//run(NRepeated())
//run(SortedSquares())
//run(SortedArrayByParity())
//run(ImageFlip())
//run(ReturnToOrigin())
//run(DIStringMatch())
run(HammingDistance())
