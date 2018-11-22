//
//  MakeReservationViewController.swift
//  InClassExercisesStarter
//
//  Created by parrot on 2018-11-22.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class MakeReservationViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var seatsTextField: UITextField!
    
    // Mark: Firestore variables
    var db:Firestore!
    
    
    // MARK: Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        let currentUser = Auth.auth().currentUser;
        if (currentUser != nil) {
            print("We have a user!")
            print("User id: \(currentUser?.uid)")
            print("Email: \(currentUser?.email)")
        }
        else {
            print("no user is signed in.")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Actions
    @IBAction func buttonPressed(_ sender: Any) {
        print("pressed the button")
        
        db.collection("reservation").document().setData([
            "username": "Jenelle",
            "restaurant": nameTextField.text,
            "day": dayTextField.text,
            "numSeats":seatsTextField.text
            ])            }
            
            // UI: Clear the textbox
            //self.messagesTextBox.text = ""
            
            // Get only what is changed:
       //     querySnapshot?.documentChanges.forEach({
       //         (diff) in
                
         //       if (diff.type == DocumentChangeType.added) {
                    // something was added
          //          let data = diff.document.data()     // get the document that was added
                    //let user = data["username"] as! String
               //     let msg = data["message"] as! String
                   // print(user)
                 //   print(msg)
                    
                   // self.messagesTextBox.text = self.messagesTextBox.text + "\(user): \(msg) \n"
                }
                

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


