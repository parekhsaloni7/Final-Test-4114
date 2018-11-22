//
//  SeeReservationsViewController.swift
//  InClassExercisesStarter
//
//  Created by parrot on 2018-11-22.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import FirebaseFirestore

class SeeReservationsViewController: UIViewController {

    
    //MARK: Outlets
    @IBOutlet weak var textField: UITextView!
    
    
    // MARK: Firebase variables
    var db:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("You are on the see reservations screen")
        
        db = Firestore.firestore()
        
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        textField.text = ""
        
        let results =  db.collection("reservations").whereField("username", isEqualTo: "jenelle@gmail.com")
        results.getDocuments {
            (querySnapshot, error) in
            
            
            if (error != nil) {
                print("Error!")
                print(error?.localizedDescription)
            }
            else {
                
                for x in (querySnapshot?.documents)! {
                    let content = x.data();
                    
                    let name = content["name"] as! String
                    let dept = content["dept"] as! String
                    
                    self.textField.text = self.textField.text + "Reservations for: \(username), Days: \(days)\n"
                    
                }
            }
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
