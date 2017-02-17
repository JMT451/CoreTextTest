//: Playground - noun: a place where people can play

import UIKit

MemoryLayout<Int>.size
MemoryLayout<Int>.alignment
MemoryLayout<Int>.stride

MemoryLayout<Int16>.size        // returns 2
MemoryLayout<Int16>.alignment   // returns 2
MemoryLayout<Int16>.stride      // returns 2

MemoryLayout<Bool>.size         // returns 1
MemoryLayout<Bool>.alignment    // returns 1
MemoryLayout<Bool>.stride       // returns 1

MemoryLayout<Float>.size        // returns 4
MemoryLayout<Float>.alignment   // returns 4
MemoryLayout<Float>.stride      // returns 4

MemoryLayout<Double>.size       // returns 8
MemoryLayout<Double>.alignment  // returns 8
MemoryLayout<Double>.stride     // returns 8

struct EmptyStruct {}

MemoryLayout<EmptyStruct>.size      // returns 0
MemoryLayout<EmptyStruct>.alignment // returns 1
MemoryLayout<EmptyStruct>.stride    // returns 1

struct SampleStruct {
    let number: UInt32
    let flag: Bool
}

MemoryLayout<SampleStruct>.size       // returns 5
MemoryLayout<SampleStruct>.alignment  // returns 4
MemoryLayout<SampleStruct>.stride     // returns 8

class EmptyClass {}

MemoryLayout<EmptyClass>.size      // returns 8 (on 64-bit)
MemoryLayout<EmptyClass>.stride    // returns 8 (on 64-bit)
MemoryLayout<EmptyClass>.alignment // returns 8 (on 64-bit)

class SampleClass {
    let number: Int64 = 0
    let flag: Bool = false
}

MemoryLayout<SampleClass>.size      // returns 8 (on 64-bit)
MemoryLayout<SampleClass>.stride    // returns 8 (on 64-bit)
MemoryLayout<SampleClass>.alignment // returns 8 (on 64-bit)

// #MARK: - Using Raw Pointers 

let count = 2
let stride = MemoryLayout<Int>.stride
let alignment = MemoryLayout<Int>.alignment
let byteCount = stride*count
// #MARK: - Using Typed Pointers

do{
    print("Raw pointers")
    
    let pointer = UnsafeMutableRawPointer.allocate(bytes: byteCount, alignedTo: alignment)
    defer {
        pointer.deallocate(bytes: byteCount, alignedTo: alignment)
    }
    pointer.storeBytes(of: 42, as: Int.self)
    pointer.advanced(by: stride).storeBytes(of: 6, as: Int.self)
    /*
    let newPointer = pointer + 8
    newPointer.storeBytes(of: 7, as: Int.self)
    */
    pointer.load(as: Int.self)
    pointer.advanced(by: stride).load(as: Int.self)
    
    let bufferPointer = UnsafeRawBufferPointer.init(start: pointer, count: byteCount)
    for (index,byte) in bufferPointer.enumerated() {
        print("byte\(index):\(byte)")
    }
}
// #MARK: - Getting The Bytes of an Instance

do {
    print("Typed pointers")
    
    let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
    pointer.initialize(to: 0, count: count)
    defer {
        pointer.deinitialize(count: count)
        pointer.deallocate(capacity: count)
    }
    
    pointer.pointee = 42
    /*
    let newPointer = pointer+1
    newPointer.pointee = 7
    newPointer.pointee
    */
    pointer.advanced(by: 1).pointee = 6
    pointer.pointee
    pointer.advanced(by: 1).pointee
    
    let bufferPointer = UnsafeBufferPointer(start: pointer, count: count)
    for (index, value) in bufferPointer.enumerated() {
        print("value \(index): \(value)")
    }
}

do {
    print("Getting the bytes of an instance")
    
    var sampleStruct = SampleStruct(number: 25, flag: true)
    
    withUnsafeBytes(of: &sampleStruct) { bytes in
        for byte in bytes {
            print(byte)
        }
    }
}


