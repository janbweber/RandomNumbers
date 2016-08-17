//
//  MersenneTwisterMT19937.swift
//  RandomNumbers
//
//  Created by Jan B Weber on 16.05.16.
//  Copyright © 2016 Hilbert Games. All rights reserved.
//

import Foundation

class MersenneTwisterMT19937 {
    
    private let N: Int
    private let M: Int
    
    private var MT: [UInt32]
    private var index: Int
    private let LOWER: UInt32
    private let UPPER: UInt32
    private let A: UInt32
    
    init(seed: UInt32) {
        N = 624
        M = 397
        MT = [UInt32](count: N, repeatedValue: 0x00000000)
        index = N
        LOWER = 0x7fffffff
        UPPER = 0x80000000
        A = 0x9908b0df
        
        MT[0] = seed
        for i in 1 ..< N-1 {
            MT[i] = UInt32(truncatingBitPattern: 1812433253 * Int((MT[i-1] ^ (MT[i-1] >> 30)) + UInt32(i)))
        }
    }
    
    func extract_number() -> UInt32 {
        if index >= N {
            twist()
        }
        var y: UInt32 = MT[index]
        y = y ^ y >> 11
        y = y ^ y << 7 & 2636928640
        y = y ^ y << 15 & 4022730752
        y = y ^ y >> 18
        
        index += 1
        
        return y
    }
    
    private func twist() {
        for i in 0 ..< N-1 {
            let x: UInt32 = (MT[i] & UPPER) + (MT[i+1 % N] & LOWER)
            
            MT[i] = MT[(i + M) % N] ^ x >> 1
            if x % 2 != 0 {
                MT[i] = MT[i] ^ A
            }
            
            index = 0
        }
    }
    
}