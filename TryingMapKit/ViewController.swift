//
//  ViewController.swift
//  TryingMapKit
//
//  Created by Felipe Soares on 23/02/17.
//  Copyright © 2017 Felipe Soares. All rights reserved.
//

import UIKit
import MapKit

//https://developers.google.com/maps/documentation/javascript/geocoding?hl=pt-br
//http://mhorga.org/2015/08/01/introduction-to-mapkit.html
//http://mhorga.org/2015/08/14/geocoding-in-ios.html

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupMap(){
        mapView.delegate = self
        //Type
        mapView.mapType = .standard
        
        //Area displayer on the map = region
//        let loc = CLLocationCoordinate2DMake(34.927752, -120.217608) //center
//        let span = MKCoordinateSpanMake(0.015, 0.015)
//        let reg = MKCoordinateRegionMake(loc, span)
//        mapView.region = reg
        
        //Area displayer on the map = region (meters)
        let loc = CLLocationCoordinate2DMake(34.927752, -120.217608)
        let reg = MKCoordinateRegionMakeWithDistance(loc, 1200, 1200)
        self.mapView.region = reg
        
        let annloc = CLLocationCoordinate2DMake(34.923964, -120.219558)
        let ann = MKPointAnnotation()
        ann.coordinate = annloc
        ann.title = "Park here"
        ann.subtitle = "Fun awaits down the road!"
        mapView.addAnnotation(ann)
        
        annotations.append(ann)
        
        
        
        let annloc2 = CLLocationCoordinate2DMake(33.927752, -119.217608)
        let ann2 = MKPointAnnotation()
        ann2.coordinate = annloc2
        ann2.title = "Park here"
        ann2.subtitle = "Fun awaits down the road!"
        mapView.addAnnotation(ann2)
        
        annotations.append(ann2)
        
        let annloc3 = CLLocationCoordinate2DMake(35.927752, -121.217608)
        let ann3 = MKPointAnnotation()
        ann3.coordinate = annloc3
        ann3.title = "Park here"
        ann3.subtitle = "Fun awaits down the road!"
        mapView.addAnnotation(ann3)
        
        annotations.append(ann3)
        
        
        
        
        forwardGeocoding(address: "1 Infinite Loop")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var v:MKAnnotationView! = nil
        if let t = annotation.title, t == "Park here"{
            let ident = "greenPin"
            v = mapView.dequeueReusableAnnotationView(withIdentifier: ident)
            if v == nil{
                v = MKPinAnnotationView(annotation: annotation, reuseIdentifier: ident)
                (v as! MKPinAnnotationView).pinTintColor = MKPinAnnotationView.greenPinColor()
                (v as! MKPinAnnotationView).animatesDrop = true
                v.canShowCallout = true
            }
            v.annotation = annotation
        }else if let t = annotation.title, t == "Park here2"{
            let ident = "bike"
            v = mapView.dequeueReusableAnnotationView(withIdentifier: ident)
            if v == nil{
                v = MKAnnotationView(annotation: annotation, reuseIdentifier: ident)
                v.image = UIImage(named: "pharmacyMap")
                v.bounds.size.height /= 3.0
                v.bounds.size.width /= 3.0
                v.centerOffset = CGPoint(x: 0, y: -20)
                v.canShowCallout = true
//                (v as! MKPinAnnotationView).pinTintColor = MKPinAnnotationView.greenPinColor()
//                (v as! MKPinAnnotationView).animatesDrop = true
//                v.canShowCallout = true
            }
            v.annotation = annotation
        }
        return v
    }
    
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.showAnnotations(annotations, animated: true)
    }
    
    func forwardGeocoding(address:String){
        
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            if error != nil{
                print(error)
                return
            }
            if (placemarks?.count)! > 0{
                let placeMark = placemarks?[0]
                let location = placeMark?.location
                let coordinate = location?.coordinate
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                if (placeMark?.areasOfInterest?.count)! > 0 {
                    let areaOfInterest = placeMark!.areasOfInterest![0]
                    print(areaOfInterest)
                } else {
                    print("No area of interest found.")
                }
            }
        }
    }


}

