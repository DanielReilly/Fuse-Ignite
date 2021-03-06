//  Created by Daniel Reilly on 20/04/2016.
//  Copyright © 2016 Fuse Technology. All rights reserved.

import UIKit
import Parse
import CoreLocation
import CoreBluetooth
import ParseUI

class RelevantUsersCustomCell: PFTableViewCell
{
    @IBOutlet var userFullName: UILabel!
    @IBOutlet var userInterests: UILabel!
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var userDistance: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
}

var eventObjectId = String()

class EventHomeSocialTableViewController: PFQueryTableViewController {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventLocationNameLabel: UILabel!
    @IBOutlet weak var eventLocationAddress1Label: UILabel!
    @IBOutlet weak var eventLocationPostcodeLabel: UILabel!
    @IBOutlet weak var eventLocationCountryLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var userProfilePictureImage: UIImageView!
    @IBOutlet weak var userJoinEventButton: UIButton!
    @IBOutlet weak var eventObjectLabel: UILabel!
    
    var window: UIWindow?
    var drawerContainer: MMDrawerController?
    
    // Container to store the view table selected object
    var currentObject : PFObject?
    
    var usernameArray = [String]()
    var profilePictureArray = [PFFile]()
    
    var followArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userJoinEventButton.layer.cornerRadius = self.userJoinEventButton.frame.size.width / 2;
        self.userJoinEventButton.clipsToBounds = true;
        
//        let idQuery = PFQuery(className: "EventObject")
//        idQuery.whereKey("objectId", equalTo: eventObjectId.last!)
//        idQuery.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
//            if(error == nil) {
//                if objects!.isEmpty {
//                    print("User not registered")
//                }
//            }
//        }
//        
        // Unwrap the current object object
        if let object = currentObject {
            eventObjectLabel.text = object.objectId!
            eventNameLabel.text = object["eventName"] as? String
            eventLocationNameLabel.text = object["eventLocationName"] as? String
            eventLocationAddress1Label.text = object["eventAddress1"] as? String
            eventLocationPostcodeLabel.text = object["eventPostcode"] as? String
            eventLocationCountryLabel.text = object["eventCountry"] as? String
            eventDescriptionLabel.text = object["eventDescription"] as? String
            self.eventDescriptionLabel.sizeToFit()
        }
        
        // Return to table view
<<<<<<< HEAD
        self.navigationController?.popViewController(animated: true)
=======
        self.navigationController?.popViewControllerAnimated(true)
        
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
        loadProfilePicture()
    }
    
    //Init the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        //Configure the PFQueryTableView
        self.parseClassName = "_User"
        self.textKey = "eventName"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery<PFObject> {
        let query = PFQuery(className: "_User")
        query.order(byAscending: "userInterests")
        return query
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject?) -> RelevantUsersCustomCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "RelevantUsersCell") as? RelevantUsersCustomCell!
        if cell == nil {
            cell = RelevantUsersCustomCell(style: UITableViewCellStyle.default, reuseIdentifier: "RelevantUsersCell")
        }
    // Extract values from the PFObject to display in the table cell
        
//        let profilePicFile: PFFile = (object?.objectForKey("profile_picture") as? PFFile)!
//        profilePicFile.getDataInBackgroundWithBlock({ (data: NSData?, error:NSError?) in
//            cell?.userProfilePicture.image = UIImage(data: data!)
//        })

        if let relevantUsers = object?["fullName"] as? String {
            cell?.userFullName?.text = relevantUsers
        }

        if let username = object?["username"] as? String {
            cell?.usernameLabel?.text = username
        }
        
        if let userInterests = object?["userInterests"] as? NSArray {
            cell?.userInterests?.text = "#" + userInterests.componentsJoined(by: ", ")
        } else {
            cell?.userInterests?.text = "No interests yet Entered"
        }
        
        return cell!
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
<<<<<<< HEAD
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
=======
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
        let header1: String = "Relevant Users"

        return header1
    }
    
<<<<<<< HEAD
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //recall cell to call cells data
        let cell = tableView.cellForRow(at: indexPath) as! RelevantUsersCustomCell
=======
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //recall cell to call cells data
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! RelevantUsersCustomCell
        
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
        //if user tapped on themselves, go home else go visitor
        if cell.usernameLabel.text! == PFUser.current()!.username! {
            let myProfile = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(myProfile, animated: true)
        } else {
            visitorName.append(cell.usernameLabel.text!)
            let visitor = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVisitorViewController") as! ProfileVisitorViewController
            self.navigationController?.pushViewController(visitor, animated: true)
        }
    }
    
<<<<<<< HEAD
    @IBAction func leftSideButtonTapped(_ sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.shared().delegate as! AppDelegate
        appDelegate.drawerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    @IBAction func rightSideButtonTapped(_ sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.shared().delegate as! AppDelegate
        appDelegate.drawerContainer?.toggle(MMDrawerSide.right, animated: true, completion: nil)
=======
    @IBAction func leftSideButtonTapped(sender: AnyObject) {
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    @IBAction func rightSideButtonTapped(sender: AnyObject) {
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
        
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
    }
    
    func loadProfilePicture(){
        
<<<<<<< HEAD
        let profilePictureObject = PFUser.current()?.object(forKey: "profile_picture") as! PFFile
        profilePictureObject.getDataInBackground { (imageData: Data?, error: NSError?) -> Void in
=======
        let profilePictureObject = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
        
        profilePictureObject.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
            
            if(imageData != nil)
            {
                self.userProfilePictureImage.image = UIImage(data: imageData!)
                
            }
        }
        self.userProfilePictureImage.layer.cornerRadius = self.userProfilePictureImage.frame.size.width / 2;
        self.userProfilePictureImage.clipsToBounds = true;
    }
    
    @IBAction func doneButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    @IBAction func userJoinEvent(_ sender: UIButton, forEvent event: UIEvent) {
        //When user attending username matches && event objectId match button must be disabled to prevent duplicate entries on database
            let eventAttendees = PFObject(className: "UserAttending")
            eventAttendees["attendee"] = PFUser.current()!.username!
            eventAttendees["eventAttendingId"] = eventObjectLabel.text
                eventAttendees.saveInBackground({ (success:Bool, error:NSError?) in
                    if(success) {
                        self.userJoinEventButton.isEnabled = false
=======
    @IBAction func userJoinEvent(sender: UIButton, forEvent event: UIEvent) {
        
            let eventAttendees = PFObject(className: "UserAttending")
=======
    @IBAction func userJoinEvent(sender: UIButton, forEvent event: UIEvent) {
        
            let eventAttendees = PFObject(className: "UserAttending")
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
    @IBAction func userJoinEvent(sender: UIButton, forEvent event: UIEvent) {
        
            let eventAttendees = PFObject(className: "UserAttending")
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
    @IBAction func userJoinEvent(sender: UIButton, forEvent event: UIEvent) {
        
            let eventAttendees = PFObject(className: "UserAttending")
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
        
            eventAttendees["attendee"] = PFUser.currentUser()!.username!
            eventAttendees["eventId"] = eventObjectId
                
                eventAttendees.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) in
                    if(success) {
                        self.userJoinEventButton.imageForState(UIControlState.Disabled)
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
=======
>>>>>>> parent of d32cc6b... User attending event button now works and have disabled the save fields for arrays as these present an error message which is expected as the list is comma separated but not an array of strings. Added outlets for the event feed fields and added in new buttons for like, comment etc. This does not yet show as I haven't yet amended it for viewing all following. No uuid is present so it presents a runtime error since that is the main view. Added like button in the post table view and removed unnecessary whitespace.
                    } else {
                        print(error?.localizedDescription)
                    }
                })
            }
    }
