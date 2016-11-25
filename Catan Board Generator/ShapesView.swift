

import UIKit

class ShapesView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shape = CAShapeLayer()
        view.layer.addSublayer(shape)
        shape.opacity = 1
        shape.lineWidth = 2
        shape.lineJoin = kCALineJoinMiter
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor(hexString: "A7CE25").cgColor
        
        let height: Double = Double(view.frame.width / 2)
        let xOrigin: Double = 160
        let yOrigin: Double = 200
        
        let path = UIBezierPath()

        
        for i in 1...6 {
            let x = xOrigin + height * cos((Double(i) * 2 - 1) * M_PI / 6)
            let y = yOrigin + height * sin((Double(i) * 2 - 1) * M_PI / 6)
            let point = CGPoint(x: x, y: y)
            if i == 1 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.close()
        shape.path = path.cgPath


    }
    
    

    

}
