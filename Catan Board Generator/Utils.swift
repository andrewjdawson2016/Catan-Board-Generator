import UIKit

class Utils {
    
    static func random(_ min: Int, _ max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max + 1 - min)) + UInt32(min))
    }
    
    static func shuffle<T>(_ array: inout [T]) {
        if array.count > 1 {
            for i in (1...(array.count - 1)).reversed() {
                let index: Int = random(0, i)
                swap(&array[index], &array[i])
            }
        }
    }
    
    static func swap<T>(_ first: inout T, _ second: inout T) {
        let temp: T = first
        first = second;
        second = temp
    }
}
