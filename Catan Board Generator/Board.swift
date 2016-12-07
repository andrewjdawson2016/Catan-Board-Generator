import UIKit

class Board: NSObject {
    static let NUM_REDS = 4
    static let NUM_SQUARES = 19
    static let NUM_SIDES = 30
    static let NUM_PORTS = 9
    static let ROW_SIZES = [3, 4, 5, 4, 3]
    static let NUM_ROWS = 5
    
    let squares: [Square]
    let ports: [Port]
    
    override init() {
        self.squares = Board.createSquares()
        self.ports = Board.createPorts()
    }
    
    func getNeighbors(parent: SquareCord) -> [SquareCord] {
        let childA = SquareCord(x: parent.x + 1, y: parent.y)
        let childB = SquareCord(x: parent.x - 1, y: parent.y)
        let childC = SquareCord(x: parent.x, y: parent.y - 1)
        let childD = SquareCord(x: parent.x, y: parent.y + 1)
        var childE: SquareCord! = nil
        var childF: SquareCord! = nil
        if parent.y == Board.NUM_ROWS - 1 || Board.ROW_SIZES[parent.y] > Board.ROW_SIZES[parent.y + 1] {
            childE = SquareCord(x: parent.x - 1, y: parent.y + 1)
        } else  {
            childE = SquareCord(x: parent.x + 1, y: parent.y + 1)
        }
        if parent.y == 0 || Board.ROW_SIZES[parent.y] > Board.ROW_SIZES[parent.y - 1] {
            childF = SquareCord(x: parent.x - 1, y: parent.y - 1)
        } else {
            childF = SquareCord(x: parent.x + 1, y: parent.y - 1)
        }
        if parent.y == 0 || parent.y == 1 {
            return [childE, childD, childB, childF, childC, childA]
        } else if parent.y == 2 {
            return [childD, childE, childB, childF, childC, childA]
        } else {
            return [childD, childE, childB, childC, childF, childA]
        }
    }
    
    func squareCordIsInBounds(squareCord: SquareCord) -> Bool {
        return squareCord.y >= 0 && squareCord.y <= Board.NUM_ROWS - 1 &&
            squareCord.x >= 0 && squareCord.x <= Board.ROW_SIZES[squareCord.y] - 1
    }
    
    private class func createSquares() -> [Square] {
        let DICE_NUMS: [Int] = [ 5, 2, 6, 3, 8, 10, 9, 12, 11, 4, 8, 10, 9, 4, 5, 6, 3, 11]
        let CENTER_SQUARE: SquareCord = SquareCord(x: 2, y: 2)
        let INNER_CIRCLE_SQUARES: [SquareCord] = [SquareCord(x: 1, y: 1),
                                                  SquareCord(x: 2, y: 1),
                                                  SquareCord(x: 3, y: 2),
                                                  SquareCord(x: 2, y: 3),
                                                  SquareCord(x: 1, y: 3),
                                                  SquareCord(x: 1, y: 2)]
        let OUTTER_CIRCLE_SQUARES: [SquareCord] = [SquareCord(x: 0, y: 0),
                                                   SquareCord(x: 1, y: 0),
                                                   SquareCord(x: 2, y: 0),
                                                   SquareCord(x: 3, y: 1),
                                                   SquareCord(x: 4, y: 2),
                                                   SquareCord(x: 3, y: 3),
                                                   SquareCord(x: 2, y: 4),
                                                   SquareCord(x: 1, y: 4),
                                                   SquareCord(x: 0, y: 4),
                                                   SquareCord(x: 0, y: 3),
                                                   SquareCord(x: 0, y: 2),
                                                   SquareCord(x: 0, y: 1)]
        let ITERATION_ORDER: [SquareCord] = [CENTER_SQUARE] + INNER_CIRCLE_SQUARES + OUTTER_CIRCLE_SQUARES
        let NUM_OUTTER_SQUARE_CIRCLE: Int = OUTTER_CIRCLE_SQUARES.count
        let NUM_INNER_SQUARE_CIRCLE: Int = INNER_CIRCLE_SQUARES.count
        
        func getSquareTypes() -> [SquareType] {
            func getNext(allowed: inout [SquareType], disallowed: [SquareType]) -> SquareType {
                func hasAllowed(allowed: [SquareType], disallowed: [SquareType]) -> Bool {
                    for curr in allowed {
                        if !disallowed.contains(curr) {
                            return true
                        }
                    }
                    return false
                }
                
                var index: Int = Utils.random(0, allowed.count - 1)
                if !hasAllowed(allowed: allowed, disallowed: disallowed) {
                    let result: SquareType = allowed[index]
                    allowed.remove(at: index)
                    return result
                } else {
                    while (disallowed.contains(allowed[index])) {
                        index = Utils.random(0, allowed.count - 1)
                    }
                    let result: SquareType = allowed[index]
                    allowed.remove(at: index)
                    return result
                }
            }
            var allowed: [SquareType] = [SquareType.DESERT,
                                         SquareType.BRICK,
                                         SquareType.BRICK,
                                         SquareType.BRICK,
                                         SquareType.ORE,
                                         SquareType.ORE,
                                         SquareType.ORE,
                                         SquareType.SHEEP,
                                         SquareType.SHEEP,
                                         SquareType.SHEEP,
                                         SquareType.SHEEP,
                                         SquareType.WHEAT,
                                         SquareType.WHEAT,
                                         SquareType.WHEAT,
                                         SquareType.WHEAT,
                                         SquareType.WOOD,
                                         SquareType.WOOD,
                                         SquareType.WOOD,
                                         SquareType.WOOD];
            Utils.shuffle(&allowed)
            var disallowed: [SquareType] = []
            var result: [SquareType] = []
            
            let first: SquareType = getNext(allowed: &allowed, disallowed: disallowed)
            disallowed.append(first)
            result.append(first)
            
            for _ in 1...(NUM_INNER_SQUARE_CIRCLE) {
                let curr: SquareType = getNext(allowed: &allowed , disallowed: disallowed)
                result.append(curr)
                if disallowed.count == 1 {
                    disallowed.append(curr)
                } else {
                    disallowed.remove(at: 1)
                    disallowed.append(curr)
                }
            }
            
            disallowed = []
            for _ in 1...NUM_OUTTER_SQUARE_CIRCLE {
                let curr: SquareType = getNext(allowed: &allowed, disallowed: disallowed)
                result.append(curr)
                if disallowed.count == 1 {
                    disallowed.remove(at: 0)
                }
                disallowed.append(curr)
            }
            return result;
        }
        
        func getSquareWithSquareCord(squareCord: SquareCord, squares: [Square]) -> Square? {
            for square in squares {
                if square.squareCord.isEqual(squareCord) {
                    return square
                }
            }
            return nil
        }
        
        func placeDiceNums(squares: inout [Square]) {
            var startIndex: Int = Utils.random(0, NUM_OUTTER_SQUARE_CIRCLE - 1)
            for i in 0...(NUM_OUTTER_SQUARE_CIRCLE - 1) {
                let square: Square = getSquareWithSquareCord(squareCord: OUTTER_CIRCLE_SQUARES[(startIndex + i) % NUM_OUTTER_SQUARE_CIRCLE], squares: squares)!
                if square.squareType != SquareType.DESERT {
                    square.number = DICE_NUMS[i]
                }
            }
            
            startIndex = Utils.random(0, NUM_INNER_SQUARE_CIRCLE - 1)
            for i in 0...(NUM_INNER_SQUARE_CIRCLE - 1) {
                let square: Square = getSquareWithSquareCord(squareCord: INNER_CIRCLE_SQUARES[(startIndex + i) % NUM_INNER_SQUARE_CIRCLE], squares: squares)!
                if square.squareType != SquareType.DESERT {
                    square.number = DICE_NUMS[i + NUM_OUTTER_SQUARE_CIRCLE]
                }
            }
            
            let centerSquare: Square = getSquareWithSquareCord(squareCord: CENTER_SQUARE, squares: squares)!
            if centerSquare.squareType != SquareType.DESERT {
                centerSquare.number = DICE_NUMS[DICE_NUMS.count - 1]
            }
        }
        
        func squaresAreFair(squares: [Square]) -> Bool {
            return redNumsDistributed(squares: squares)
        }
        
        func redNumsDistributed(squares: [Square]) -> Bool {
            var map: [SquareType: Int] = [:]
            for square in squares {
                if square.isRedNum() {
                    let type: SquareType = square.squareType!
                    if map[type] == nil {
                        map[type] = 0
                    }
                    map[type] = map[type]! + 1
                    if map[type] == 3 {
                        return false
                    }
                }
            }
            return true
        }
        
        func redNumsNotTouching(squares: [Square]) -> Bool {
            for square in squares {
                let neighbors: [SquareCord] = getNeighbors(squares)
            }
        }
        
        while true {
            var squareTypes: [SquareType] = getSquareTypes()
            var result: [Square] = []
            
            for i in 0...(NUM_SQUARES - 1) {
                result.append(Square(squareType: squareTypes[i], squareCord: ITERATION_ORDER[i]));
            }
            placeDiceNums(squares: &result)
            
            if squaresAreFair(squares: result) {
                Utils.swapRandom(&result)
                if redNumsNotTouching(squares: result) {
                    return result
                }
            }
            
            let innerLast = getSquareWithSquareCord(squares: result, squareCord: SquareCord(x: 1, y: 2))
            let innerFirst = getSquareWithSquareCord(squares: result, squareCord: SquareCord(x: 1, y: 1))
            let innerSame: Bool = innerFirst!.resource == innerLast!.resource
            
            let outterLast = getSquareWithSquareCord(squares: result, squareCord: SquareCord(x: 0, y: 1))
            let outterFirst = getSquareWithSquareCord(squares: result, squareCord: SquareCord(x: 0, y: 0))
            let outterSame: Bool = outterFirst!.resource == outterLast!.resource
            
            let outterSecondLast = getSquareWithSquareCord(squares: result, squareCord: SquareCord(x: 0, y: 2))
            let outSecondLastSame: Bool = outterLast!.resource == outterSecondLast!.resource
            
            
            let clusterCount: Int = getClusterCount(squares: result)
            if redNumsDistributed(squares: result) && clusterCount < 4 && !innerSame && !outterSame && !outSecondLastSame {
                return result
            }
        }
    }
    
    private class func createPorts() -> [Port] {
        var portTypes = [PortType.BRICK,
                         PortType.ORE,
                         PortType.SHEEP,
                         PortType.WHEAT,
                         PortType.WOOD,
                         PortType.THREE_FOR_ONE,
                         PortType.THREE_FOR_ONE,
                         PortType.THREE_FOR_ONE,
                         PortType.THREE_FOR_ONE]
        
        func getIndices() -> [Int] {
            var gapSizes: [Int] = [ 2, 2, 2, 2, 2, 2, 3, 3, 3 ]
            Utils.shuffle(&gapSizes)
            var result: [Int] = []
            var index: Int = Utils.random(0, Board.NUM_SIDES - 1)
            for i in 0...(Board.NUM_PORTS - 1) {
                result.append(index)
                index = (index + gapSizes[i] + 1) % Board.NUM_SIDES
            }
            return result
        }
        
        func isDistributed(ports: [Port]) -> Bool {
            for i in 0...(ports.count - 1) {
                if (ports[i].portType == PortType.THREE_FOR_ONE &&
                    ports[(i + 1) % ports.count].portType == PortType.THREE_FOR_ONE &&
                    ports[(i + 2) % ports.count].portType == PortType.THREE_FOR_ONE) {
                    
                    return false
                }
            }
            return true
        }
        
        while true {
            var portIndices: [Int] = getIndices()
            Utils.shuffle(&portTypes)
            var result: [Port] = []
            
            for i in 0...(portIndices.count - 1) {
                result.append(Port(portType: portTypes[i], index: portIndices[i]))
            }
            
            if isDistributed(ports: result) {
                return result
            }
        }
    }
}
