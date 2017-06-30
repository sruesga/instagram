//
//  ProfileViewController.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/28/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    var posts: [PFObject] = []
    var refreshControl: UIRefreshControl!
    var isMoreDataLoading = false
    var maxNumberOfPosts: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self

        
        loadData()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        collectionView.insertSubview(refreshControl, at: 0)
        
        
        
        let query = PFQuery(className: "Post")
        query.includeKey("author")
        query.countObjectsInBackground { (total: Int32, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.maxNumberOfPosts = Int(total)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if HomeViewController.newPost {
            self.loadData()
            HomeViewController.newPost = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = collectionView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        cell.clear()
        let post = posts[indexPath.row]
        cell.instagramPost = post
        
        return cell
    }
    
    
    func loadData(withLimit limit: Int = 15) {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = limit
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the data fetched
                self.posts = posts
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
                self.isMoreDataLoading = false
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        }
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        loadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading && maxNumberOfPosts != nil && posts.count < maxNumberOfPosts) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = collectionView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - collectionView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && collectionView.isDragging) {
                
                isMoreDataLoading = true
                
                // Code to load more results
                loadData(withLimit: posts.count + 15)
            }
        }
    }
    
    @IBAction func didLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(loginViewController, animated: true, completion: nil)
            }
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
