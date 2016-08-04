//
//  ViewController.swift
//  PhotosViewer
//
//  Created by Mahmud, Syed on 3/31/16.
//  Copyright © 2016 bla company. All rights reserved.
//

import UIKit


class ViewController: UIViewController {


    @IBOutlet weak var imageViewer: UIView!
    
    var lastRasterizationScale:CGFloat = CGFloat()
    var lastContentOffset:CGPoint = CGPoint()
    
    var photoAlbumDictionary = Dictionary<String, AnyObject> ()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let mainImage = PhotoViewer(frame: self.imageViewer.frame)
        mainImage.parent = self
        mainImage.loadImage(UIImage(named: "main.jpeg")!, zoomScale: CGFloat(1.0), contentOffset: CGPoint(x: 0, y: 0))
        
        photoAlbumDictionary["main"] = mainImage
        
        let firstImage = PhotoViewer(frame: self.imageViewer.frame)
        firstImage.parent = self
        firstImage.loadImage(UIImage(named: "first.jpeg")!, zoomScale: CGFloat(1.0), contentOffset: CGPoint(x: 0, y: 0))
        
        photoAlbumDictionary["first"] = firstImage

    }

    func setPhotoBrowserZoomingScale(scale:CGFloat, offset:CGPoint) {
        self.lastRasterizationScale = scale
        self.lastContentOffset = offset
    }
    
    @IBAction func mainImage(sender: AnyObject) {
        photoAlbumDictionary["first"]?.removeFromSuperview()
        
        guard let photoView = photoAlbumDictionary["main"] as? UIView else {
            return
        }
        
        self.imageViewer.addSubview(photoView)
    }
    
    @IBAction func firstImage(sender: AnyObject) {
        photoAlbumDictionary["main"]?.removeFromSuperview()
        
        guard let photoView = photoAlbumDictionary["first"] as? UIView else {
            return
        }
        
        self.imageViewer.addSubview(photoView)
    }
}

