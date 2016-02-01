//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Brandon Arroyo on 1/17/16.
//  Copyright © 2016 Brandon Arroyo. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate {


    @IBOutlet weak var collectionView: UICollectionView!
//    This is where we will be storying the json that we retrieved
    var movies: [NSDictionary]?
    var dataTest: [String]!
    var filteredData: [String]!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
 //------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        loadDataFromNetwork()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.insertSubview(refreshControl, atIndex: 0)
    }
    
//------------------------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    @available(iOS 6.0, *)
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if let movies = movies {
                return movies.count - 1
        } else {
                return 0
        }
            
        
    }
  
    
    
    @available(iOS 6.0, *)
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell",forIndexPath: indexPath) as! MovieCell
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        if let posterPath = movie["poster_path"] as? String{
            let baseURL = "http://image.tmdb.org/t/p/w500/"
            let imageURL = NSURL(string: baseURL + posterPath)
            cell.poserView.setImageWithURL(imageURL!)

        }
                
                
        print("row \(indexPath.row)")
        return cell
        
        
    }
    
    func loadDataFromNetwork() {
        
        // ... Create the NSURLRequest (myRequest) ...
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let myRequest = NSURLRequest(URL: url!)
        
        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(myRequest,
            completionHandler: { (dataOrNil, response, error) in
                
                // Hide HUD once the network request comes back (must be done on main UI thread)
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            self.collectionView.reloadData()
                    }
                }
        });
        task.resume()
    }
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // ... Create the NSURLRequest (myRequest) ...
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let myRequest = NSURLRequest(URL: url!)
        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(myRequest,
            completionHandler: { (dataOrNil, response, error) in
                // ... Use the new data to update the data source ...
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            self.collectionView.reloadData()
                    }
                }
                // Reload the tableView now that there is new data
                self.collectionView.reloadData()
                
                // Tell the refreshControl to stop spinning
                refreshControl.endRefreshing()	
        });
        task.resume()
    }
    
    
    // MARK: - Navigation
    
//     In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPathForCell(cell)
            let  movie = movies![indexPath!.row]
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.movies = movie
            
            
        }
    


}

//------------------------------------------------------------------------------
