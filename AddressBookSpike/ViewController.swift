//
//  ViewController.swift
//  AddressBookSpike
//
//  Created by Archita Bansal on 26/11/15.
//  Copyright © 2015 Archita Bansal. All rights reserved.
//

import UIKit
import AddressBook

class ViewController: UIViewController {

   
   
    
    @IBOutlet weak var outletInvite: UIButton!
     let addressBook : ABAddressBookRef = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
    
   
    @IBAction func onInvite(sender: UIButton) {
        
        promptForAddressBookRequestAccess()
        
    }
    
    var contacts = Array<String>()
    var organisation = Array<String>()
    var images = Array<UIImage>()
    var persons = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let url = NSURL(string: UIApplicationOpenSettingsURLString)
//        UIApplication.sharedApplication().openURL(url!)
        
    }
    
    func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func promptForAddressBookRequestAccess() {
        var err: Unmanaged<CFError>? = nil
        ABAddressBookRequestAccessWithCompletion(addressBook) {
            (granted: Bool, error: CFError!) in
            dispatch_async(dispatch_get_main_queue()) {
                if !granted {
                    // 1
                    print("Just denied")
                    //self.displayCantAddContactAlert()
                } else {
                    // 2
                    print("Just authorized")
                    self.fetchContacts()
                }
            }
        }
    }

    
    func fetchContacts(){
        
        
        
        let allContacts : NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as [ABRecord]
        for record in allContacts{
            
            var person : Person = Person()
            var contactPerson : ABRecordRef = record
            if (ABRecordCopyValue(contactPerson, kABPersonOrganizationProperty)?.takeRetainedValue() as? String) != nil{
                person.organisationName = (ABRecordCopyValue(contactPerson, kABPersonOrganizationProperty).takeRetainedValue() as? String)!
                
            }
            else{
                self.organisation.append("Organisation")
            }
            if let ref = contactPerson as? ABRecordRef{
                let img = ABPersonCopyImageDataWithFormat(ref, kABPersonImageFormatThumbnail)
                if img != nil {
                    let data = img.takeRetainedValue()
                    person.profileImage = UIImage(data: data)
                }
            }
            if (ABRecordCopyValue(contactPerson,kABPersonFirstNameProperty)?.takeRetainedValue() as? String) != nil{
                 person.fullName = ABRecordCopyCompositeName(contactPerson).takeRetainedValue() as String
                
            }
            else{
//                self.contacts.append("Joseph")
            }
            
            if !persons.contains(person){
               
                self.persons.append(person)

            }
           
        }
        
        let contactController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("contacts") as! ContactViewController
        contactController.persons = self.persons
        self.navigationController?.pushViewController(contactController, animated: false)
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

