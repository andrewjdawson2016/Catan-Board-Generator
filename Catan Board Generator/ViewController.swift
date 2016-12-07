

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var hexWidth: CGFloat!
    var xPos: CGFloat!
    var yPos: CGFloat!
    
    var numRows = 5
    var colNums = [3, 4, 5, 4, 3]
    var hexMap: [SquareCord: UITile] = [:]
    var coastCords: [SquareCord]!
    
    var tileColorMap: [Resource:String] = [Resource.BRICK: "94410B",
                                     Resource.WOOD: "5A5C34",
                                     Resource.WHEAT: "FBD769",
                                     Resource.ORE: "878A8F",
                                     Resource.SHEEP: "A5AF3D",
                                     Resource.DESERT: "C4AF73"]
    
    var portColorMap: [PortTypes: String] = [PortTypes.BRICK: "94410B",
                                             PortTypes.ORE: "878A8F",
                                             PortTypes.SHEEP: "A5AF3D",
                                             PortTypes.THREE_FOR_ONE: "FFFFFF",
                                             PortTypes.WHEAT: "FBD769",
                                             PortTypes.WOOD: "5A5C34"]
    
    var backgroundColor: UIColor!
    var generateButton: UIButton!
    var scrollView: UIScrollView!
    var boardArea: UIView!
    var contentFrame: CGRect!
    
    private var portMap: [Int: SquareCordSide]!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundColor  = UIColor(hexString: "909BA1")
        view.backgroundColor = backgroundColor
        
        hexWidth = view.frame.width / 6
        xPos = hexWidth
        yPos = (view.frame.height - hexWidth * 4) / 2
        
        boardArea = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        boardArea.center = view.center
//        boardArea.layer.borderWidth = 1
        scrollView = UIScrollView(frame: view.frame)
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(boardArea)
        scrollView.contentSize = boardArea.frame.size
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.clipsToBounds = false
        scrollView.maximumZoomScale = 1.0
        
        portMap = getPortMap()

        createButton()
        createBoard()
        
        


        
    }
    
    private func getPortMap() -> [Int: SquareCordSide] {
        var portMap: [Int: SquareCordSide] = [:]
        portMap[0] = SquareCordSide(squareCord: SquareCord(x: 0, y: 0), side: 5)
        portMap[1] = SquareCordSide(squareCord: SquareCord(x: 0, y: 0), side: 4)
        portMap[2] = SquareCordSide(squareCord: SquareCord(x: 0, y: 0), side: 3)
        portMap[3] = SquareCordSide(squareCord: SquareCord(x: 0, y: 1), side: 4)
        portMap[4] = SquareCordSide(squareCord: SquareCord(x: 0, y: 1), side: 3)
        portMap[5] = SquareCordSide(squareCord: SquareCord(x: 0, y: 2), side: 4)
        portMap[6] = SquareCordSide(squareCord: SquareCord(x: 0, y: 2), side: 3)
        portMap[7] = SquareCordSide(squareCord: SquareCord(x: 0, y: 2), side: 2)
        portMap[8] = SquareCordSide(squareCord: SquareCord(x: 0, y: 3), side: 3)
        portMap[9] = SquareCordSide(squareCord: SquareCord(x: 0, y: 3), side: 2)
        portMap[10] = SquareCordSide(squareCord: SquareCord(x: 0, y: 4), side: 3)
        portMap[11] = SquareCordSide(squareCord: SquareCord(x: 0, y: 4), side: 2)
        portMap[12] = SquareCordSide(squareCord: SquareCord(x: 0, y: 4), side: 1)
        portMap[13] = SquareCordSide(squareCord: SquareCord(x: 1, y: 4), side: 2)
        portMap[14] = SquareCordSide(squareCord: SquareCord(x: 1, y: 4), side: 1)
        portMap[15] = SquareCordSide(squareCord: SquareCord(x: 2, y: 4), side: 2)
        portMap[16] = SquareCordSide(squareCord: SquareCord(x: 2, y: 4), side: 1)
        portMap[17] = SquareCordSide(squareCord: SquareCord(x: 2, y: 4), side: 6)
        portMap[18] = SquareCordSide(squareCord: SquareCord(x: 3, y: 3), side: 1)
        portMap[19] = SquareCordSide(squareCord: SquareCord(x: 3, y: 3), side: 6)
        portMap[20] = SquareCordSide(squareCord: SquareCord(x: 4, y: 2), side: 1)
        portMap[21] = SquareCordSide(squareCord: SquareCord(x: 4, y: 2), side: 6)
        portMap[22] = SquareCordSide(squareCord: SquareCord(x: 4, y: 2), side: 5)
        portMap[23] = SquareCordSide(squareCord: SquareCord(x: 3, y: 1), side: 6)
        portMap[24] = SquareCordSide(squareCord: SquareCord(x: 3, y: 1), side: 5)
        portMap[25] = SquareCordSide(squareCord: SquareCord(x: 2, y: 0), side: 6)
        portMap[26] = SquareCordSide(squareCord: SquareCord(x: 2, y: 0), side: 5)
        portMap[27] = SquareCordSide(squareCord: SquareCord(x: 2, y: 0), side: 4)
        portMap[28] = SquareCordSide(squareCord: SquareCord(x: 1, y: 0), side: 5)
        portMap[29] = SquareCordSide(squareCord: SquareCord(x: 1, y: 0), side: 4)
        return portMap
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return boardArea
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        scrollView.contentInset = UIEdgeInsets.zero
//        scrollView.e
    }
    
    func createButton() {
        generateButton = UIButton(type: .system)
        generateButton.frame.size = CGSize(width: 180, height: 50)
        generateButton.center = CGPoint(x: view.center.x, y: view.frame.height - 60)
        generateButton.backgroundColor = UIColor(hexString: "788284")
        generateButton.setTitle("Generate", for: .normal)
        generateButton.setTitleColor(UIColor(hexString: "434343"), for: .normal)
        generateButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 24)
        generateButton.layer.cornerRadius = generateButton.frame.width / 7
        generateButton.addTarget(self, action: #selector(ViewController.createBoard), for: .touchUpInside)
        generateButton.alpha = 0.95
        generateButton.layer.borderColor = UIColor.black.cgColor
        view.addSubview(generateButton)
    }

    
    
    
    func createBoard() {
        for subview in boardArea.subviews {
            subview.removeFromSuperview()
        }
        if let sublayers = boardArea.layer.sublayers {
            for layer in sublayers {
                layer.removeFromSuperlayer()
            }
        }
        var squares = Utils.getFairSquares()
        var squareIndex = 0
        
        for square in squares {
            let row = square.y!
            let numTilesInColumn = self.colNums[row]
            let yOffSet = generateButton.frame.height / 2
            let y = self.yPos + (self.hexWidth * (2 / sqrt(3)) * 0.75) * CGFloat(row) - yOffSet
            let col = square.x!
            let xOffSet = (self.view.frame.width - self.hexWidth * 5) / 2
            let x = xOffSet + (self.hexWidth * CGFloat(col) + self.xPos - (self.hexWidth / 2) * CGFloat(numTilesInColumn - 3))
            let square = squares[squareIndex]
            squareIndex += 1
            let color = UIColor(hexString: tileColorMap[square.resource]!)
            let frame = CGRect(x: x, y: y, width: hexWidth, height: hexWidth * (2 / sqrt(3)))
            let tile = UITile(frame: frame, color: color, number: square.number)
            tile.hex.strokeColor = UIColor.black.cgColor
            tile.squareCord = SquareCord(x: col, y: row)
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapped))
            tile.addGestureRecognizer(tap)
            boardArea.addSubview(tile)
            hexMap[SquareCord(x: col, y: row)] = tile
        }
        placePorts()

    }
    
    func placePorts() {
        let ports = Utils.getFairPorts()
        for port in ports {
            let index = port.index
            let squareCordSide = portMap[index]
            let squareCord = squareCordSide!.squareCord!
            let side = squareCordSide!.side!
            let tile = hexMap[squareCord]!
            let color = portColorMap[port.portType]!
            drawPort(tile: tile, color: UIColor(hexString: color), side: side)
        }
    }
    
    func tapped(_ sender: AnyObject) {
        
    }
    
    func drawPort(tile: UITile, color: UIColor, side: Int) {

        let frame = tile.frame
        let halfHeight = Double(frame.height / 2)
        let halfWidth = Double(frame.width / 2)
        let x1 = (Double(frame.origin.x) + (halfWidth + (halfHeight * cos((Double(side) * 2 - 1) * M_PI / 6))))
        let y1 = (Double(frame.origin.y) + (halfHeight + (halfHeight * sin((Double(side) * 2 - 1) * M_PI / 6))))
        let x2 = (Double(frame.origin.x) + (halfWidth + (halfHeight * cos((Double(side + 1) * 2 - 1) * M_PI / 6))))
        let y2 = (Double(frame.origin.y) + (halfHeight + (halfHeight * sin((Double(side + 1) * 2 - 1) * M_PI / 6))))
        let dx = x2 - x1
        let dy = y2 - y1
        let x3 = (cos(((2.0 * M_PI) - M_PI / 3)) * dx - sin(((2.0 * M_PI) - M_PI / 3)) * dy) + x1
        let y3 = (sin(((2.0 * M_PI) - M_PI / 3)) * dx + cos(((2.0 * M_PI) - M_PI / 3)) * dy) + y1
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.opacity = 1
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = kCALineJoinMiter
        shapeLayer.fillColor = color.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.contentsScale = 2
        boardArea.layer.insertSublayer(shapeLayer, at: 0)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x2, y: y2))
        path.addLine(to: CGPoint(x: x3, y: y3))
        path.close()
        shapeLayer.path = path.cgPath
        
    }
    
    func makeViewAtPoint(point: CGPoint) {
        let v = UIView()
        v.frame.size = CGSize(width: 3, height: 3)
        v.center = point
        v.backgroundColor = UIColor.red
        view.addSubview(v)
    }
    
    private class SquareCordSide {
        
        var squareCord: SquareCord!
        var side: Int!
        
    
        init(squareCord: SquareCord, side: Int) {
            self.squareCord = squareCord
            self.side = side
        }
        
    }

}


