//
//  MapViewController.swift
//  MapKitAssignment
//
//  Created by Student on 9/26/17.
//  Copyright © 2017 Anvit. All rights reserved.
//

import Foundation
import UIKit
import MapKit

//How to know where user is
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var fromPlace = ""
    var toPlace = ""
    var showType = "" //its either "map" or "route"
    var geocoder = CLGeocoder()
    var places = [String]()
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //if showType == "map" {
        print("fromPlace = " + fromPlace)
        print("toPlace = " + toPlace)
        if (!fromPlace.isEmpty) {
            places.append(fromPlace)
        }
        if (!toPlace.isEmpty) {
            places.append(toPlace)
        }
        if showType == "map" {
            mapPlot(places, polyline: false) //Map plots
        } else if showType == "route" {
            mapPlot(places, polyline: true) //Map plots
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Helper function to plot on map
    func mapPlot(_ places:[String], polyline:Bool) {
        var i = 1
        var coordinates: CLLocationCoordinate2D?
        var placemark: CLPlacemark?
        var annotation: Station?
        var stations:Array = [Station]()
        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        
        for address in places {
            geocoder = CLGeocoder() //new geocoder
            geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                if((error) != nil)  {
                    print("Error", error)
                }
                placemark = placemarks?.first
                if placemark != nil {
                    coordinates = placemark!.location!.coordinate
                    points.append(coordinates!)
                    print("locations = \(coordinates!.latitude) \(coordinates!.longitude)")
                    annotation = Station(latitude: coordinates!.latitude, longitude: coordinates!.longitude, address: address)
                    stations.append(annotation!)
                    print(stations.count)
                    print(i)
                    if (i == self.places.count) {
                        print("Printing map.")
                        self.mapView.addAnnotations(stations)
                        //                        let region = MKCoordinateRegionMakeWithDistance(coordinates!, 7000.0, 7000.0)
                        //                        self.mapView.setRegion(region, animated: true)
                        if (polyline == true) { //If draw polyline is true
                            let line = MKPolyline(coordinates: &points, count: points.count)
                            self.mapView.add(line)
                        }
                    }
                    i += 1
                }
            })
        }
    }
    
    func mapView(_ mapView: MKMapView!, rendererFor overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return MKPolylineRenderer()
    }
    
    class Station: NSObject, MKAnnotation {
        var title: String?
        var latitude: Double
        var longitude:Double
        
        var coordinate: CLLocationCoordinate2D {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        init(latitude: Double, longitude: Double, address: String) {
            self.latitude = latitude
            self.longitude = longitude
            self.title = address
        }
    }
}


