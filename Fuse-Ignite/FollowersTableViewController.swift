//
//  FollowersTableViewController.swift
//  Fuse-Ignite
//
//  Created by Daniel Reilly on 08/05/2016.
//  Copyright © 2016 Fuse Technology. All rights reserved.
//

import UIKit
import Parse
import ParseUI

var show = String()
var user = String()

class FollowersTableViewController: UITableViewController {
    
    var usernameArray = [String]()
    var profilePictureArray = [PFFile]()
    
    var followArray = [String]()
    
    override func viewDidLoad() {
        self.navigationItem.title = show.capitalizedString
        
        if(show == "followers") {
            loadFollowers()
        }
        
        if(show == "following") {
            loadFollowing()
        }
    }
    
    func loadFollowers(){
        let followQuery = PFQuery(className: "Followers")
        followQuery.whereKey("following", equalTo: user)
        
        //get followers
        followQuery.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if(error == nil) {
                self.followArray.removeAll(keepCapacity: false)
                
                for object in objects! {
                    self.followArray.append(object.valueForKey("follower") as! String)
                }
                let query = PFUser.query()
                query?.whereKey("username", containedIn: self.followArray)
                query?.addDescendingOrder("createdAt")
                
                //get username and profile picture
                query?.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error:NSError?) in
                if(error == nil) {
                    self.usernameArray.removeAll(keepCapacity: false)
                    self.profilePictureArray.removeAll(keepCapacity: false)
                    
                for object in objects! {
                    self.usernameArray.append(object.valueForKey("username") as! String)
                    self.profilePictureArray.append(object.valueForKey("profile_picture") as! PFFile)
                    self.tableView.reloadData()
                        }
                } else {
                    print(error?.localizedDescription)
                    }
                })
            } else {
                print(error?.localizedDescription)
            }
        }
        
    }
    
    func loadFollowing(){
        let followQuery = PFQuery(className: "Followers")
        followQuery.whereKey("follower", equalTo: user)
        
        //get following
        followQuery.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if(error == nil) {
                self.followArray.removeAll(keepCapacity: false)
                
                for object in objects! {
                    self.followArray.append(object.valueForKey("following") as! String)
                }
                
               // find users following the selected user
                let query = PFQuery(className: "_User")
                query.whereKey("username", containedIn: self.followArray)
                query.addDescendingOrder("createdAt")
                query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) in
                    if(error == nil) {
                        self.usernameArray.removeAll(keepCapacity: false)
                        self.profilePictureArray.removeAll(keepCapacity: false)
                        
                        for object in objects! {
                            self.usernameArray.append(object.valueForKey("username") as! String)
                            self.profilePictureArray.append(object.valueForKey("profile_picture") as! PFFile)
                            self.tableView.reloadData()
                        }
                    } else {
                        print(error?.localizedDescription)
                    }
                })
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    //number of cells
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernameArray.count
    }
    
    //cell configuration
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //define cell
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! FollowersCell
        
        //connect data from server to objects
        cell.usernameLabel.text = usernameArray[indexPath.row]
        profilePictureArray[indexPath.row].getDataInBackgroundWithBlock { (data:NSData?, error:NSError?) in
            if(error == nil) {
                cell.userProfilePictureImage.image = UIImage(data: data!)
                cell.userProfilePictureImage.layer.cornerRadius = cell.userProfilePictureImage.frame.size.width / 2;
                cell.userProfilePictureImage.clipsToBounds = true;
            } else {
                print(error?.localizedDescription)
            }
        }
        
        let query = PFQuery(className: "Followers")
        query.whereKey("follower", equalTo: PFUser.currentUser()!.username!)
        query.whereKey("following", equalTo: cell.usernameLabel.text!)
        query.countObjectsInBackgroundWithBlock ({ (count: Int32, error: NSError?) in
            if(error == nil) {
                if(count == 0) {
                    cell.userFollowingButton.setTitle("Follow +", forState: UIControlState.Normal)
                    cell.userFollowingButton.backgroundColor = .lightGrayColor()
                } else {
                    cell.userFollowingButton.setTitle("Following", forState: UIControlState.Normal)
                    cell.userFollowingButton.backgroundColor = UIColor.greenColor()
                }
            }
        })
        
        //hide follow button for current user
        if cell.usernameLabel.text == PFUser.currentUser()?.username {
            cell.userFollowingButton.hidden = true
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //recall cell to call cells data
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FollowersCell
        
        //if user tapped on themselves, go home else go visitor
        if cell.usernameLabel.text! == PFUser.currentUser()!.username {
            let myProfile = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(myProfile, animated: true)
        } else {
            visitorName.append(cell.usernameLabel.text!)
            let visitor = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileVisitorViewController") as! ProfileVisitorViewController
            self.navigationController?.pushViewController(visitor, animated: true)
        }
    }
    
}
