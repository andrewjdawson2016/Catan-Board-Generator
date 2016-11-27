

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var hexWidth: CGFloat!
    var xPos: CGFloat!
    var yPos: CGFloat!
    
    var numRows = 5
    var colNums = [3, 4, 5, 4, 3]
    
    let colors = ["9C3C0E", "474F39", "F8C727", "939393", "A7CE25"]
    var backgroundColor: UIColor!
    
    var generateButton: UIButton!
    var scrollView: UIScrollView!
    var boardArea: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundColor  = UIColor(hexString: "B3EAE5")
        view.backgroundColor = backgroundColor
        
        hexWidth = view.frame.width / 5
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
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return boardArea
    }
    
    func createButton() {
        generateButton = UIButton(type: .system)
        generateButton.frame = CGRect(x: view.frame.width / 3, y: view.frame.height - 72, width: view.frame.width / 3, height: 42)
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
        for row in 0...self.numRows - 1 {
            let numTilesInColumn = self.colNums[row]
            let yOffSet = self.generateButton.frame.height / 2
            let y = self.yPos + (self.hexWidth * (2 / sqrt(3)) * 0.75) * CGFloat(row) - yOffSet
            for col in 0...numTilesInColumn - 1 {
                let xOffSet = (self.view.frame.width - self.hexWidth * 5) / 2
                let x = xOffSet + (self.hexWidth * CGFloat(col) + self.xPos - (self.hexWidth / 2) * CGFloat(numTilesInColumn - 3))
                self.placeHex(x: x, y: y)
            }
        }
    }
    
    func random(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)) + UInt32(min))
    }
    
    func placeHex(x: CGFloat, y: CGFloat) {
        let colorStr = colors[random(min: 0, max: Int(colors.count))]
        let color = UIColor(hexString: colorStr)
        let number = random(min: 2, max: 11)
        let frame = CGRect(x: x, y: y, width: hexWidth, height: hexWidth * (2 / sqrt(3)))
        let tile = UITile(frame: frame, color: color, number: number)
        tile.hex.strokeColor = backgroundColor.cgColor
        boardArea.addSubview(tile)
    }
    
    

}

