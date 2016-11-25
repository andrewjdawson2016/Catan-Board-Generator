

import UIKit

class Playground: UIViewController, UIScrollViewDelegate {
    
    let imageView = UIImageView()
    var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    
    
    
    func setStuff() {
        var squareCords: Set<SquareCord> = Set<SquareCord>()
        squareCords.insert(SquareCord(x: 5, y: 5))
        squareCords.insert(SquareCord(x: 5, y: 5))
        print(squareCords.count)
        print(squareCords.contains(SquareCord(x: 5, y: 5)))
    }



}
