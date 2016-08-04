//
//  PhotoViewer.swift
//  ViewerTest
//
//  Created by Mahmud, Syed on 3/31/16.
//  Copyright © 2016 bla company. All rights reserved.
//

import UIKit

class PhotoViewer : UIView, UIScrollViewDelegate {
    
    var scrollView: UIScrollView?
    var imageView: UIImageView?
    
    var image:UIImage?
    var rasterizationScale:CGFloat = CGFloat(1.0)
    var lastContentOffset:CGPoint = CGPoint(x: 0.0, y: 0.0)
    weak var parent:ViewController?
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func encodeWithCoder(_aCoder: NSCoder) { }
    
    func loadImage(image:UIImage, zoomScale:CGFloat, contentOffset:CGPoint) {
        
        self.rasterizationScale = zoomScale
        
        self.scrollView = UIScrollView(frame: self.frame)
        
        if let scrollV = self.scrollView {
            scrollV.minimumZoomScale = 0.2
            scrollV.maximumZoomScale = 5.0
            scrollV.backgroundColor = UIColor.clearColor()
            scrollV.translatesAutoresizingMaskIntoConstraints = true
            scrollV.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            scrollV.autoresizesSubviews = true
            scrollV.pagingEnabled = false
            scrollV.showsVerticalScrollIndicator = false
            scrollV.showsHorizontalScrollIndicator = false
            scrollV.delegate = self
            self .addSubview(scrollV)
            
            self.image = image
            self.imageView = UIImageView(image: self.image)
            
            if let imgView = self.imageView {
                imgView.userInteractionEnabled = true
                imgView.contentMode = UIViewContentMode.ScaleAspectFit
                imgView.backgroundColor = UIColor.clearColor()
                
                scrollV.addSubview(imgView)
                scrollV.contentSize = imgView.frame.size
            }
            
            scrollV.zoomScale = self.rasterizationScale
            
            if contentOffset.x != 0 || contentOffset.y != 0 {
                scrollV.contentOffset = contentOffset
            }
        }
    }
    
    //MARK: - UIScrollViewDelegate methods
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        self.rasterizationScale = scale
        self.lastContentOffset = scrollView.contentOffset
     
        parent?.setPhotoBrowserZoomingScale(self.rasterizationScale, offset:self.lastContentOffset)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        self.lastContentOffset = scrollView.contentOffset
        
        parent?.setPhotoBrowserZoomingScale(self.rasterizationScale, offset:self.lastContentOffset)
        
        return self.imageView
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.lastContentOffset = scrollView.contentOffset
        parent?.setPhotoBrowserZoomingScale(self.rasterizationScale, offset:self.lastContentOffset)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset
        parent?.setPhotoBrowserZoomingScale(self.rasterizationScale, offset:self.lastContentOffset)
    }
    
}


