import UIKit

class Utils: NSObject {
    
    private static func getClusterCount(squares: [Square]) -> Int {
        var resourceSquareCords: [Resource: [SquareCord]] = [:]
        for square in squares {
            if resourceSquareCords[square.resource!] == nil {
                resourceSquareCords[square.resource] = []
            }
            resourceSquareCords[square.resource]!.append(square.squareCord!)
        }
        
        var groups: Int = 0
        
        for curr in resourceSquareCords {
            groups += getClusterCountSingleCluster(squareCordList: curr.value)
        }
        
        return groups
    }
    
    private static func getClusterCountSingleCluster(squareCordList: [SquareCord]) -> Int {
        if squareCordList.count == 3 {
            let singleCounts: Int = getSingleCounts(squareCordList: squareCordList)
            if singleCounts == 0 {
                return 0
            } else {
                return 1
            }
        } else {
            let singleCounts: Int = getSingleCounts(squareCordList: squareCordList)
            if singleCounts == 4 {
                return 0
            } else if singleCounts == 2 || singleCounts == 1 {
                return 1
            } else {
                return 2
            }
        }
    }
    
    private static func getSingleCounts(squareCordList: [SquareCord]) -> Int {
        var result: Int = 0
        for i in 0...(squareCordList.count - 1) {
            let parent: SquareCord = squareCordList[i]
            let children: [SquareCord] = getNeighbors(parent: parent)
            var parentIsSingle: Bool = true
            for child in children {
                if squareCordIsInBounds(squareCord: child) {
                    for j in 0...(squareCordList.count - 1) {
                        if i != j {
                            if (squareCordList[j].isEqual(child)) {
                                parentIsSingle = false
                            }
                        }
                    }
                }
            }
            if parentIsSingle {
                result += 1;
            }
        }
        return result
    }

    static func random(_ min: Int, _ max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max + 1 - min)) + UInt32(min))
    }
    
    static func shuffle<T>(_ array: inout [T]) {

        for i in (1...(array.count - 1)).reversed() {
            let index: Int = random(0, i)
            swap(&array[index], &array[i])
        }
    }
    
    static func swapRandom<T>(_ array: inout [T]) {
        var first: T = array[random(0, array.count - 1)]
        var second: T = array[random(0, array.count - 1)]
        swap(&first, &second)
    }
    
    static func swap<T>(_ first: inout T, _ second: inout T) {
        let temp: T = first
        first = second;
        second = temp
    }
}
