

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var hexWidth: CGFloat!
    var xPos: CGFloat!
    var yPos: CGFloat!
    
    var numRows = 5
    var colNums = [3, 4, 5, 4, 3]
    var tiles: [UITile] = []
    
    var colorMap: [Resource:String] = [Resource.BRICK: "9C3C0E",
                                     Resource.WOOD: "474F39",
                                     Resource.WHEAT: "F8C727",
                                     Resource.ORE: "939393",
                                     Resource.SHEEP: "A7CE25",
                                     Resource.DESERT: "C4AF73"]
    var backgroundColor: UIColor!
    var generateButton: UIButton!
    var scrollView: UIScrollView!
    var boardArea: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        backgroundColor  = UIColor(hexString: "B3EAE5")
        view.backgroundColor = backgroundColor
        
        hexWidth = view.frame.width / 6
        xPos = hexWidth
        yPos = (view.frame.height - hexWidth * 4) / 2
        
        boardArea = UIView(frame: view.frame)
        scrollView = UIScrollView(frame: view.frame)
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(boardArea)
        scrollView.contentSize = CGSize(width: boardArea.frame.width, height: boardArea.frame.width / 8)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.clipsToBounds = false
        scrollView.maximumZoomScale = 3.0
 
        createButton()
        createBoard()
        
        makeTriangle()
        
    }

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return boardArea
    }
    
    func createButton() {
        generateButton = UIButton(type: .system)
        generateButton.frame = CGRect(x: view.frame.width / 4, y: view.frame.height - 72, width: view.frame.width / 2, height: 42)
        generateButton.backgroundColor = UIColor(hexString: "A12500")
        generateButton.setTitle("Generate", for: .normal)
        generateButton.setTitleColor(UIColor(hexString: "FBDF1D"), for: .normal)
        generateButton.titleLabel?.font = UIFont(name: "Arial", size: 26)
        generateButton.layer.cornerRadius = 6
        generateButton.addTarget(self, action: #selector(ViewController.createBoard), for: .touchUpInside)
        generateButton.alpha = 0.95
        view.addSubview(generateButton)
    }
    
    
    
    func createBoard() {
        for subview in boardArea.subviews {
            subview.removeFromSuperview()
        }
        var squares = Utils.getFairSquares()
        var squareIndex = 0
        for row in 0...self.numRows - 1 {
            let numTilesInColumn = self.colNums[row]
            let yOffSet = self.generateButton.frame.height / 2
            let y = self.yPos + (self.hexWidth * (2 / sqrt(3)) * 0.75) * CGFloat(row) - yOffSet
            for col in 0...numTilesInColumn - 1 {
                let xOffSet = (self.view.frame.width - self.hexWidth * 5) / 2
                let x = xOffSet + (self.hexWidth * CGFloat(col) + self.xPos - (self.hexWidth / 2) * CGFloat(numTilesInColumn - 3))
                let square = squares[squareIndex]
                squareIndex += 1
                self.placeHex(x: x, y: y, square: square)
            }
        }
    }
    
    func placeHex(x: CGFloat, y: CGFloat, square: Square) {
        let color = UIColor(hexString: colorMap[square.resource]!)
        let frame = CGRect(x: x, y: y, width: hexWidth, height: hexWidth * (2 / sqrt(3)))
        let tile = UITile(frame: frame, color: color, number: square.number)
        tile.hex.strokeColor = backgroundColor.cgColor
        boardArea.addSubview(tile)
        tiles.append(tile)
    }
    
    func makeTriangle() {
        
        let tile = tiles[1]
        
        let x1 = Double(tile.frame.origin.x) + Double(tile.points[2].x)
        let y1 = Double(tile.frame.origin.y) + Double(tile.frame.height) - Double(tile.points[0].y)
        
        let x2 = Double(tile.frame.origin.x) + Double(tile.points[3].x)
        let y2 = Double(tile.frame.origin.y) + Double(tile.frame.height) - Double(tile.points[1].y)
        
        
        let dx = x2 - x1
        let dy = y2 - y1
        
        let x3 = (cos(M_PI / 3) * dx - sin(M_PI / 3) * dy) + x1
        let y3 = (sin(M_PI / 3) * dx + cos(M_PI / 3) * dy) + y1
        
        
        
        
        
        
        

        
        let v = UIView(frame: CGRect(x: x1, y: y1, width: 3, height: 3))
        v.backgroundColor = UIColor.red
        view.addSubview(v)
        
        let v1 = UIView(frame: CGRect(x: x2, y: y2, width: 3, height: 3))
        v1.backgroundColor = UIColor.red
        view.addSubview(v1)
        
        let v2 = UIView(frame: CGRect(x: x3, y: y3, width: 3, height: 3))
        v2.backgroundColor = UIColor.red
        view.addSubview(v2)
        
        
        
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.opacity = 1
//        shapeLayer.lineWidth = 2
//        shapeLayer.lineJoin = kCALineJoinMiter
//        shapeLayer.fillColor = UIColor.red.cgColor
//        shapeLayer.strokeColor = backgroundColor.cgColor
//        boardArea.layer.addSublayer(shapeLayer)
//
//        
//        let path = UIBezierPath()
//        
//        path.move(to: p1)
//        path.addLine(to: p2)
//        path.addLine(to: p3)
//        path.close()
//        
//        shapeLayer.path = path.cgPath
    }
    
    

}

