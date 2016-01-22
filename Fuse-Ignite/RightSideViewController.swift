//
//  RightSideViewController.swift
//  Fuse-Ignite
//
//  Created by Daniel Reilly on 15/01/2016.
//  Copyright © 2016 Fuse Technology. All rights reserved.
//

import UIKit
import Parse

class RightSideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResults = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchResults.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let myCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) 
        
        myCell.textLabel?.text = searchResults[indexPath.row]
        
        return myCell
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        
        let eventNameQuery = PFQuery(className: "EventObject")
        eventNameQuery.whereKey("eventName", containsString: searchBar.text)
        
        let eventDescriptionQuery = PFQuery(className: "EventObject")
        eventNameQuery.whereKey("eventDescription", containsString: searchBar.text)
        
        let eventLocationQuery = PFQuery(className: "EventObject")
        eventNameQuery.whereKey("eventLocation", containsString: searchBar.text)
    
        var query = PFQuery.orQueryWithSubqueries([eventNameQuery,eventDescriptionQuery,eventLocationQuery])
        
//        query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
//            
//            if(error != nil)
//            {
//                var myAlert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
//                
//                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
//                
//                myAlert.addAction(okAction)
//                
//                self.presentViewController(myAlert, animated: true, completion: nil)
//                
//                return
//            }
//            
//            if let objects = results as? [PFObject] {
//                self.searchResults.removeAll(keepCapacity: false)
//                
//                for object in objects {
//                    let eventName = object.objectForKey("eventName") as! String
//                    let eventDescription = object.objectForKey("eventDescription") as! String
//                    let eventLocation = object.objectForKey("eventLocation") as! String
//                    let eventNameAndDescription = eventName + " - " + eventLocation
//                    
//                    self.searchResults.append(eventNameAndDescription)
//                }
//                
//                dispatch_group_async(dispatch_get_main_queue()) {
//                    self.searchTable.reloadData()
//                    self.searchBar.resignFirstResponder()
//                }
//            }
//        
//        }
    }

    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    
}
