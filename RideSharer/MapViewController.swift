//
//  MapViewController.swift
//  RideSharer
//
//
import MapKit
import UIKit

class MapViewController: UIViewController {
    //Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    //Variables
    let locationManager = CLLocationManager()
    
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManagerDidChangeAuthorization()
        } else {
            //Do something to let users know why they need to turn it on
            alertLocationPermNeeded()
        }
    }
    
    func locationManagerDidChangeAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
        case .denied, .restricted:
            alertDeniedLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        @unknown default:
            break
        }
    }
    
    //Alert functionality
    func alertLocationPermNeeded() {
        let alert = UIAlertController(
            title: "Need Location Access Permissions",
            message: "GPS access is restricted. Go to Location Services under Privacy to enable GPS to have access to tracking.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .default,
                                      handler: nil))
        
        alert.addAction(UIAlertAction(title: "Allow Location Access",
                                      style: .cancel,
                                      handler: { (alert) -> Void in
            UIApplication.shared.open(URL(string: "app-settings:root=LOCATION_SERVICES")!,
                                                                options: [:],
                                                                completionHandler: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertDeniedLocation() {
        let alert = UIAlertController(
            title: "Denied",
            message: "You have denied Location Access. Tracking unavailable.",
            preferredStyle: .alert
            )
        let OK = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alert.addAction(OK)
        self.present(alert, animated: true, completion: nil)
    }
}
