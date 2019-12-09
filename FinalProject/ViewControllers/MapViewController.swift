//
//  MapViewController.swift
//  FinalProject
//
//  Created by Luke Dam on 2019-12-09.
//  Copyright © 2019 sheridan. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var cityName: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    let locationManager = CLLocationManager()
    var lonArray = [Double]()
    var latArray = [Double]()
    var destLocation = CLLocation()

    
    override func viewDidLoad() {
        
        let btnString = mainDelegate.cityName + " ➡️"
        
        cityName.setTitle(btnString, for: .normal)

        super.viewDidLoad()
        
        readJson()

    }
    
    func readJson() {
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=" + mainDelegate.cityName +  "&appid=e30aab7068f44fded6e3f4c84ec3d0e3").response {responseJSON in
            
            if let json = try? JSON(data: responseJSON.data!) {
                //print(json)
                
                self.lonArray.removeAll()
                self.latArray.removeAll()
                
                let a = json["coord"]["lon"].double
                let b = json["coord"]["lat"].double
                
                self.lonArray.append(a!)
                self.latArray.append(b!)
                
                self.setLocation()
            }
        }
    }
    
    func setLocation () {
        
        //json location
        destLocation = CLLocation(latitude: latArray[0] as CLLocationDegrees, longitude: lonArray[0] as CLLocationDegrees)
        
        // center on location and region
        let viewRegion = MKCoordinateRegion.init(center: destLocation.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
        
        // enable mapView region
        mapView.setRegion(viewRegion, animated: true)
        
        annotation(lat: latArray[0], lon: lonArray[0])
        getDirections(lat: 43.469198, lon: -79.699552)
    }
    
    func getDirections(lat: Double, lon: Double) {

        annotation1(lat: lat, lon: lon)
        let request = createRequest(lat: lat, lon: lon, from: destLocation.coordinate)
        let directions = MKDirections(request: request)

        directions.calculate ( completionHandler: { [unowned self] response, error in
            
            // create polyline overlay
            for route in (response?.routes)! {
                //print(route)
                
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
                
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                
                for step in route.steps {
                    self.mainDelegate.routeArray.append(step.instructions)
                }
                
                //print(self.mainDelegate.routeArray)
                
            }
        })
    }
    
    func createRequest(lat: Double, lon: Double, from coordinate: CLLocationCoordinate2D) -> MKDirections.Request{
        
        
        let destination = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let request = MKDirections.Request()
        
        // origin
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        
        // destination
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        
        request.requestsAlternateRoutes = false
        
        //by car
        request.transportType = .automobile
        
        return request
    }
    
    func annotation(lat:Double, lon:Double) {
        
        //let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
        
        // span with 20-30km range
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 50000, longitudinalMeters: 50000)
        
        
        mapView.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Destination"
        annotation.subtitle = "Destination"
        
        mapView.addAnnotation(annotation)
    }
    
    func annotation1(lat:Double, lon:Double) {
        
        //let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
        
        // span with 20-30km range
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 50000, longitudinalMeters: 50000)
        
        
        mapView.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Here"
        annotation.subtitle = "Here"
        
        mapView.addAnnotation(annotation)
    }
}

// extend mk delegate
extension MapViewController {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        if overlay is MKPolyline {
            // create polyline renderer
            let renderer2 = MKPolylineRenderer(overlay: overlay)

            // renderer.style class
            renderer2.strokeColor = UIColor.blue

            return renderer2
        }
        return MKOverlayRenderer()
    }

}
