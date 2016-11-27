
import UIKit

class UITile: UIView {
    
    let hex = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, color: UIColor, number: Int) {
        super.init(frame: frame)
        
        let numLabel = UILabel()
        let whiteCircle = UIView()
        
        hex.opacity = 1
        hex.lineWidth = 2
        hex.lineJoin = kCALineJoinMiter
        hex.strokeColor = UIColor(hexString: "B3EAE5").cgColor
        hex.fillColor = color.cgColor
        layer.addSublayer(hex)
        
        
        let tileWidth = frame.width * 0.46
        let numTileFrame = CGRect(x: (frame.width - tileWidth) / 2, y: (frame.height - tileWidth) / 2, width: tileWidth, height: tileWidth)
        
        whiteCircle.frame = numTileFrame
        whiteCircle.backgroundColor = UIColor.white
        whiteCircle.layer.cornerRadius = numTileFrame.width / 2
        addSubview(whiteCircle)

        numLabel.frame = numTileFrame
        numLabel.text = "\(number)"
        if number == 6 || number == 8 {
            numLabel.textColor = UIColor.red
        } else {
            numLabel.textColor = UIColor.black
        }
        numLabel.textAlignment = .center
        numLabel.font = UIFont(name: "Arial-Bold", size: frame.width * 0.275)
        numLabel.sizeToFit()
        numLabel.center = CGPoint(x: whiteCircle.center.x, y: whiteCircle.center.y)
        addSubview(numLabel)

        let halfHeight = Double(frame.height / 2)
        let halfWidth = Double(frame.width / 2)
        let path = UIBezierPath()
        
        for i in 1...6 {
            let x = (halfWidth + (halfHeight * cos((Double(i) * 2 - 1) * M_PI / 6)))
            let y = (halfHeight + (halfHeight * sin((Double(i) * 2 - 1) * M_PI / 6)))
            let point = CGPoint(x: x, y: y)
            if i == 1 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.close()
        hex.path = path.cgPath
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
