//
//  RestaurantMapViewController.swift
//  InClassExercisesStarter
//
//  Created by parrot on 2018-11-22.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation

class RestaurantMapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded the map screen")
     /*   let keyword = "restaurant"
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = keyword
        
        let coordinate = CLLocationCoordinate2DMake(43.6532, -79.3832)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let r = MKCoordinateRegionMake(coordinate, span)
        
        searchRequest.region = r
         let search = MKLocalSearch(request: searchRequest)
        
        var places = response?.mapItems // [MKMapItems]
        // do something with the results
        for x in places! {
            print("Name: \(x.name)")
            print("Address: \(x.phoneNumber)")
            print("Lat:  \(x.placemark.coordinate.latitude)")
            print("Lng: \(x.placemark.coordinate.longitude)")
            print("=======")
        }
 */
        
        let url = "https://opentable.herokuapp.com/api/restaurants?city=Toronto&per_page=5"
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON {
            (response) in
            
            // -- put your code below this line
            
            if (response.result.isSuccess) {
                print("awesome, i got a response from the website!")
                print("Response from webiste: " )
                print(response.data )
                
                do {
                    let json = try JSON(data:response.data!)
                    print(json)
                    
                    // Get the dog photo url
                    let p = json["message"].string!
                    print(p)
                    
                    // Show the photo url in the user interface
                   // self.infoLabel.text = p
                    
                    // Code to put the photo into an ImageView
                    let url = URL(string: p)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                 //   self.mapView.image = UIImage(data: data!)
                    
                    
                }
                catch {
                    print ("Error while parsing JSON response")
                }
                
            }
            
        }
        
        // set the center of the map
        let x = CLLocationCoordinate2DMake(43.6532, -79.3832)
        
        // pick a zoom level
        let y = MKCoordinateSpanMake(0.01, 0.01)
        
        // set the region property of the mapview
        let z = MKCoordinateRegionMake(x, y)
        self.mapView.setRegion(z, animated: true)
        // 1. Create a pin object
        let pin = MKPointAnnotation()
        
        // 2. Set the latitude / longitude of the pin
        pin.coordinate = x
        
        // 3. OPTIONAL: add a information popup (a "bubble")
        pin.title = "HERE IS SOME INFORMATION"
        
        // 4. Show the pin on the map
        self.mapView.addAnnotation(pin)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: Actions

    @IBAction func zoomInPressed(_ sender: Any) {
        
        print("zoom in!")
        var r = mapView.region
        r.span.latitudeDelta = r.span.latitudeDelta * 2
        r.span.longitudeDelta = r.span.longitudeDelta * 2
        self.mapView.setRegion(r, animated: true)
        
        // HINT: Check MapExamples/ViewController.swift
    }
    
    @IBAction func zoomOutPressed(_ sender: Any) {
        // zoom out
        print("zoom out!")
        var r = mapView.region
        
        print("Current zoom: \(r.span.latitudeDelta)")
        
        r.span.latitudeDelta = r.span.latitudeDelta / 4
        r.span.longitudeDelta = r.span.longitudeDelta / 4
        print("New zoom: \(r.span.latitudeDelta)")
        print("-=------")
        self.mapView.setRegion(r, animated: true)
        // HINT: Check MapExamples/ViewController.swift
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
