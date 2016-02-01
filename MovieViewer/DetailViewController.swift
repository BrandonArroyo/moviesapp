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
    var movies: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let overview = movies["overview"] as! String
        overviewLabel.text = overview
// make sure that the poster path is there before we try and load it
        if let posterPath = movies["poster_path"] as? String{
            let baseURL = "http://image.tmdb.org/t/p/w500/"
            let imageURL = NSURL(string: baseURL + posterPath)
            posterimage.setImageWithURL(imageURL!)
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
