import UIKit

class Square: NSObject {
    var resource: Resource!
    var number: Int!
    var squareCord: SquareCord!
    var x: Int!
    var y: Int!
    
    init(resource: Resource, number: Int, squareCord: SquareCord) {
        self.resource = resource
        self.number = number
        self.squareCord = squareCord
        self.x = squareCord.x
        self.y = squareCord.y
    }
    
    convenience init(resource: Resource, squareCord: SquareCord) {
        self.init(resource: resource, number: -1, squareCord: squareCord)
    }
    
    convenience init(resource: Resource, x: Int, y: Int) {
        self.init(resource: resource, squareCord: SquareCord(x: x, y: y))
    }
}
