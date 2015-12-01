//
//  ContactViewController.swift
//  AddressBookSpike
//
//  Created by Archita Bansal on 28/11/15.
//  Copyright © 2015 Archita Bansal. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var contactTableView: UITableView!
    var tableData = Array<String>()
    var tableSubData = Array<String>()
    var imageData = Array<UIImage>()
    var persons = [Person]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
        
        self.contactTableView.contentInset = UIEdgeInsets(top: -50, left: 0, bottom: 0, right: 8.0)
        self.contactTableView.bounces = false

      

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persons.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56.0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ContactTableViewCell = self.contactTableView.dequeueReusableCellWithIdentifier("ContactCell") as! ContactTableViewCell
        cell.nameLabel.text = self.persons[indexPath.row].fullName
        cell.workLabel.text = self.persons[indexPath.row].organisationName
        if self.persons[indexPath.row].profileImage != nil{
            cell.personImage.image = self.persons[indexPath.row].profileImage
        }
        else{
            cell.personImage.image = UIImage(named: "userProfile")
        }
        cell.personImage.layer.cornerRadius = 20 ;
        cell.personImage.clipsToBounds = true;

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

   
}
