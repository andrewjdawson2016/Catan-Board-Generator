

import UIKit

class Playground: UIViewController, UIScrollViewDelegate {
    
    var imageView: UIImageView!
    var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: #imageLiteral(resourceName: "b"))
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.contentOffset = CGPoint(x: 1000, y: 450)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 1.0
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        
        setZoomScale()
    }
    
    func setZoomScale() {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = 1.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    
    
    func setStuff() {
        var squareCords: Set<SquareCord> = Set<SquareCord>()
        squareCords.insert(SquareCord(x: 5, y: 5))
        squareCords.insert(SquareCord(x: 5, y: 5))
        print(squareCords.count)
        print(squareCords.contains(SquareCord(x: 5, y: 5)))
    }



}
