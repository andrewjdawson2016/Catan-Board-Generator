import UIKit

class Utils: NSObject {
    static let ROW_SIZES = [ 3, 4, 5, 4, 3]
    static let NUM_ROWS = 5
    static let NUM_REDS = 4
    
    static func getFairPorts() -> [Port] {
        var result = [Port.BRICK,
                      Port.ORE,
                      Port.SHEEP,
                      Port.WHEAT,
                      Port.WOOD,
                      Port.THREE_FOR_ONE,
                      Port.THREE_FOR_ONE,
                      Port.THREE_FOR_ONE,
                      Port.THREE_FOR_ONE]
        shuffle(&result)
        return result
    }
    
    static func getFairSquares() -> [Square] {
        let resources: [Resource] = getShuffledResources()
        var result: [Square] = []
        var resourceIndex: Int = 0
        var desert: SquareCord? = nil
        for i in 0...(NUM_ROWS - 1) {
            let currRowSize: Int = ROW_SIZES[i]
            for j in 0...(currRowSize - 1) {
                result.append(Square(resource: resources[resourceIndex], x: j, y: i))
                if (resources[resourceIndex] == Resource.DESERT) {
                    desert = SquareCord(x: j, y: i)
                }
                resourceIndex += 1
            }
        }
        
        let redSquareCords: [SquareCord] = getRedSquareCords(desert: desert!)
        placeDiceRolls(squares: &result, redSquares: redSquareCords)
        return result
    }
    
    static func random(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max + 1 - min)) + UInt32(min))
    }
    
    private static func shuffle<T>(_ array: inout [T]) {
        for i in (1...(array.count - 1)).reversed() {
            let index: Int = random(min: 0, max: i)
            swap(first: &array[index], second: &array[i])
        }
    }
    
    private static func placeDiceRolls(squares: inout [Square], redSquares: [SquareCord]) {
        var nonRedDiceRolls: [Int] = []
        for i in 3...11 {
            if i != 6 && i != 7 && i != 8 {
                nonRedDiceRolls.append(i)
                nonRedDiceRolls.append(i)
            }
        }
        
        nonRedDiceRolls.append(2)
        nonRedDiceRolls.append(12)
        shuffle(&nonRedDiceRolls)
            
        var redDiceRolls: [Int] = []
        redDiceRolls.append(6)
        redDiceRolls.append(6)
        redDiceRolls.append(8)
        redDiceRolls.append(8)
        shuffle(&redDiceRolls)
        
        var nonRedDiceIndex = 0
        var redDiceIndex = 0
            
        for square in squares {
            if square.resource != Resource.DESERT {
                if redSquares.contains(square.squareCord) {
                    square.number = redDiceRolls[redDiceIndex]
                    redDiceIndex += 1
                } else {
                    square.number = nonRedDiceRolls[nonRedDiceIndex]
                    nonRedDiceIndex += 1
                }
            }
        }
    }
    
    private static func getShuffledResources() -> [Resource] {
        let resourceCounts: [Resource: Int] = getResourceCounts()
        var result: [Resource] = []
        for resource in resourceCounts.keys {
            let count: Int = resourceCounts[resource]!
            for _ in 0...(count - 1) {
                result.append(resource)
            }
        }
        shuffle(&result)
        return result
    }
    
    private static func getResourceCounts() -> [Resource: Int] {
        var result: [Resource: Int] = [:]
        result[Resource.BRICK] = 3
        result[Resource.DESERT] = 1
        result[Resource.ORE] = 3
        result[Resource.SHEEP] = 4
        result[Resource.WOOD] = 4
        result[Resource.WHEAT] = 4
        return result;
    }
    
    private static func swap<T>(first: inout T, second: inout T) {
        let temp: T = first
        first = second;
        second = temp
    }
    
    private static func getRedSquareCords(desert: SquareCord) -> [SquareCord] {
        var allowedSquares: Set<SquareCord> = Set<SquareCord>()
        for i in 0...(NUM_ROWS - 1) {
            let currRowSize: Int = ROW_SIZES[i]
            for j in 0...(currRowSize - 1) {
                let curr: SquareCord = SquareCord(x: j, y: i)
                if (!curr.isEqual(desert)) {
                    allowedSquares.insert(curr)
                }
            }
        }
        
        var result: [SquareCord] = []
        for _ in (0...NUM_REDS - 1) {
            let tempSquares = Array(allowedSquares)
            let index: Int = random(min: 0, max: (tempSquares.count - 1))
            let curr: SquareCord = tempSquares[index]
            allowedSquares.remove(curr)
            removeChildren(allowedSquares: &allowedSquares, parent: curr)
            result.append(curr)
        }
        return result
    }
    
    private static func removeChildren(allowedSquares: inout Set<SquareCord>, parent: SquareCord) {
        let childA = SquareCord(x: parent.x - 1, y: parent.y)
        let childB = SquareCord(x: parent.x + 1, y: parent.y)
        let childC = SquareCord(x: parent.x, y: parent.y - 1)
        let childD = SquareCord(x: parent.x, y: parent.y + 1)
        var childE: SquareCord! = nil
        var childF: SquareCord! = nil
        
        if parent.y == NUM_ROWS - 1 || ROW_SIZES[parent.y] > ROW_SIZES[parent.y + 1] {
            childE = SquareCord(x: parent.x - 1, y: parent.y + 1)
        } else  {
            childE = SquareCord(x: parent.x + 1, y: parent.y + 1)
        }
        
        if parent.y == 0 || ROW_SIZES[parent.y] > ROW_SIZES[parent.y - 1] {
            childF = SquareCord(x: parent.x - 1, y: parent.y - 1)
        } else {
            childF = SquareCord(x: parent.x + 1, y: parent.y - 1)
        }
        
        allowedSquares.remove(childA)
        allowedSquares.remove(childB)
        allowedSquares.remove(childC)
        allowedSquares.remove(childD)
        allowedSquares.remove(childE)
        allowedSquares.remove(childF)
    }
}
