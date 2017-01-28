//
//  TrackViewController.swift
//  Backtrack Mapper
//
//  Created by Nicholas Taras on 21/10/2016.
//  Copyright © 2016 Tea Break Apps. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TrackViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,     UIPickerViewDataSource, UIPickerViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    var pickerDataSource = [
        "Icon Beach",
        "Icon Bar",
        "Icon Restaurant",
        "Shop",
        "Resort",
        "Surf Spot",
        "Cafe",
        "Cake Shop",
        "Bakery Shop",
        "Hangout",
        "Hideout",
        "Class",
        "Bay",
        "Cove",
        "Shoreline",
        "Date Spot",
        "Chillout Area",
        "Club",
        "Bowls Club",
        "Yaught Club",
        "Pool Club",
        "Playing Field",
        "Stadium",
        "Tennis Court",
        "Park",
        "Cool Building",
        "Bed and Breakfast",
        "Friends Place",
        "Salsa Club",
        "Horse Riding Club",
        "Tourist Attaction",
        "Theme Park",
        "Romantic Place",
        "Scary Place",
        "Film Location",
        "Boxing Club",
        "Snokelling Area",
        "Desert Island",
        "Secret Place",
        "A place for good times",
        "Dentist",
        "Beauty spot",
        "Doctor",
        "Something Else"
    ];
    
//    To have two
//    var pickerDataSource = [["A", "B", "C", "D"],["Beach","Bar","Restaurant","Shop"]];
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 2
//    }
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerDataSource[component][row]
//    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){

        print("Row Selected", pickerDataSource[row]);
        
//        if(row == 0){
//            self.view.backgroundColor = UIColor.whiteColor();
//        } else if(row == 1) {
//            self.view.backgroundColor = UIColor.redColor();
//        } else if(row == 2) {
//            self.view.backgroundColor =  UIColor.greenColor();
//        } else {
//            self.view.backgroundColor = UIColor.blueColor();
//        }
        
    }
    
    @IBAction func takePhoto(sender: AnyObject!){
        print("Take Photo");
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
//            imagePicker.allowsEditing = false
//            self.presentViewController(imagePicker, animated: true, completion: nil)
//        }
    }
    
    @IBAction func chooseFromLibrary(sender: UIButton!) {
        print("Choose Image From Library");
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func useMyLocation(sender: UIButton!) {
        print("Use My Location");
        determineMyCurrentLocation()
    }
    
    @IBAction func saveTrack(sender: UIButton!) {
        print("Save Track");
        //store name, location, date and time, location, image
        
        //let imageData = UIImageJPEGRepresentation(imageView.image!, 0.6)
        //let compressedJPGImage = UIImage(data: imageData!)
        //UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBOutlet var map: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation:CLLocation = locations.first else { return }
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        if let location = manager.location {
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error)->Void in
                
                if (error != nil) {
                    print("Reverse geocoder failed with error " + error!.localizedDescription)
                    return
                }
                
                if placemarks!.count > 0 {
                    let pm = placemarks![0] 
                    self.displayLocationInfo(pm)
                } else {
                    print("Problem with the data received from geocoder")
                }
            })
        }
    }
    
    func displayLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            let street = (containsPlacemark.thoroughfare != nil) ? containsPlacemark.thoroughfare : ""

//            localityTxtField.text = locality
//            postalCodeTxtField.text = postalCode
//            aAreaTxtField.text = administrativeArea
//            countryTxtField.text = country
            
            print(locality, postalCode, administrativeArea, country, street)
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        print("Error, could not find location. \(error)")
    }
    
}


