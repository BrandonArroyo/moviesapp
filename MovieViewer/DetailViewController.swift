//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by Brandon Arroyo on 1/31/16.
//  Copyright © 2016 Brandon Arroyo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var posterimage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    var movies: NSDictionary!
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.height  ) 
        let overview = movies["overview"] as! String
        
        let title = movies["title"] as? String
        titleLabel.text = title
        overviewLabel.text = overview
        overviewLabel.sizeToFit()
// make sure that the poster path is there before we try and load it
        if let posterPath = movies["poster_path"] as? String{
            let baseURL = "http://image.tmdb.org/t/p/w500/"
            let imageURL = NSURL(string: baseURL + posterPath)
            
            let imageRequest = NSURLRequest(URL: imageURL!)
            self.posterimage.setImageWithURLRequest(
                imageRequest,
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        print("Image was NOT cached, fade in image")
                        self.posterimage.alpha = 0.0
                        self.posterimage.image = image
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            self.posterimage.alpha = 1.0
                        })
                    } else {
                        print("Image was cached so just update the image")
                        self.posterimage.image = image
                    }
                },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
            })
            
            
            
            
        }
        
    
    }
//------------------------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//     
//        
//    }


}
