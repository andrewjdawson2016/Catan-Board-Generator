

import UIKit

class Playground: UIViewController, UIScrollViewDelegate {
    



    override func viewDidLoad() {
        super.viewDidLoad()
        

        let shapeLayer = CAShapeLayer()
        shapeLayer.opacity = 1
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = kCALineJoinMiter
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        view.layer.addSublayer(shapeLayer)
        
        let xOrigin = 150.0
        let yOrigin = 300.0
        
        let path = UIBezierPath()
        
        let m = 30.0
        let point1 = CGPoint(x: xOrigin + m * cos(M_PI / 6), y: yOrigin + m * sin(M_PI / 6))
        let point2 = CGPoint(x: xOrigin, y: yOrigin)
        let point3 = CGPoint(x: xOrigin + m * cos(11 * M_PI / 6), y: yOrigin + m * sin(11 * M_PI / 6))
        
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.close()
        
        shapeLayer.path = path.cgPath
        
        
    }
    




}
