//
//  ProfileViewController.swift
//  instagram
//
//  Created by Skyler Ruesga on 6/28/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userProfileImage: PFImageView!

    
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
        
        self.usernameLabel.text = PFUser.current()?.username
        
        self.userProfileImage.file = PFUser.current()?["profile_picture"] as? PFFile
        self.userProfileImage.loadInBackground()
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.size.width / 2
        self.userProfileImage.clipsToBounds = true
        
        
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumInteritemSpacing  = 1
        layout.minimumLineSpacing = 1
        let cellsPerLine: CGFloat = 3
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        
        layout.itemSize = CGSize(width: width, height: width)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        let post = posts[indexPath.item]
        cell.clear()
        cell.instagramPost = post
        cell.image.file = post["media"] as! PFFile
        cell.image.loadInBackground()

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

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        let vc = segue.destination as! DetailViewController
        let cell = sender as! ProfileCell
        let post = cell.instagramPost
        vc.post = post
    }
}
