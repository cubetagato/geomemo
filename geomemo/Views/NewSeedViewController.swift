//
//  NewSeedViewController.swift
//  geomemo
//
//  Created by Gabriel I. Hernández G. on 25/04/17.
//  Copyright © 2017 Gabriel I. Hernández G. All rights reserved.
//

import UIKit
import MapKit
import AddressBookUI
import Contacts

class NewSeedViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet var seedMapView: MKMapView?
    @IBOutlet var seedTypeLabel: UILabel?
    //@IBOutlet var locationSearchBar: UISearchBar!
    
    var newSeed: Seed?
    
    var seedLocationManager: CLLocationManager?
    var locationSearchController: UISearchController!
    //var locationSearchTableController: UITableViewController!
    var seedGeocoder: CLGeocoder!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //seedTypeLabel!.text = "\(newSeed!.seedType)"
        
        seedLocationManager = CLLocationManager()
        seedLocationManager!.delegate = self
        seedLocationManager!.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        seedLocationManager!.requestWhenInUseAuthorization()
        seedLocationManager!.distanceFilter = CLLocationDistance(exactly: 10)!
        seedLocationManager!.headingFilter = CLLocationDegrees(exactly: 10)!
        
        if !CLLocationManager.locationServicesEnabled() {
            print("Location Serices are disabled")
        }
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied  {
            print("Location services are blocked by the user")
        }
        if CLLocationManager.locationServicesEnabled()  {
            seedLocationManager!.startUpdatingLocation()
            //seedLocationManager!.allowDeferredLocationUpdates(untilTraveled: CLLocationDistance(exactly: 10)!, timeout: TimeInterval(exactly: 5)!)
            //seedLocationManager!.startMonitoringSignificantLocationChanges()
        }
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined   {
            print("about to show a dialog requesting permission")
        }
        
        
        
        seedGeocoder = CLGeocoder()
        
        //seedMapView!.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        seedMapView!.showsUserLocation = false
        seedMapView!.isPitchEnabled = true
        seedMapView!.isZoomEnabled = true
        seedMapView!.isRotateEnabled = false
        seedMapView!.isScrollEnabled = true
        seedMapView!.mapType = MKMapType.standard
        //seedMapView!.showAnnotations(seedMapView!.annotations, animated: true)
        seedMapView!.showsBuildings = true
        seedMapView!.showsCompass = true
        seedMapView!.showsPointsOfInterest = true
        seedMapView!.showsScale = false
        seedMapView!.showsTraffic = false
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(mapPointPress))
        longPressGestureRecognizer.minimumPressDuration = 1.5
        //longPressGestureRecognizer.delegate = self
        seedMapView!.addGestureRecognizer(longPressGestureRecognizer)
        
        let locationSearchTableViewController = LocationSearchTableViewController(nibName: "LocationSearchTableView", bundle: nil)
        locationSearchTableViewController.mapView = seedMapView!
        
        locationSearchTableViewController.tableView.delegate = locationSearchTableViewController
        //print(locationSearchTableViewController.tableView.restorationIdentifier)
        //locationSearchTableViewController.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
        locationSearchTableViewController.tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil ), forCellReuseIdentifier: "cell")
        //locationSearchTableViewController.tableView.register(
        
        locationSearchTableViewController.tableView.delegate = locationSearchTableViewController
        locationSearchTableViewController.tableView.dataSource = locationSearchTableViewController
        
        locationSearchController = UISearchController(searchResultsController: locationSearchTableViewController)
        locationSearchController.hidesNavigationBarDuringPresentation = false
        locationSearchController.dimsBackgroundDuringPresentation = true
        locationSearchController.searchBar.sizeToFit()
        locationSearchController.searchBar.placeholder = "Search for Places"
        locationSearchController.searchBar.delegate = self
        locationSearchController.searchResultsUpdater = locationSearchTableViewController
        
        
        navigationItem.titleView = locationSearchController.searchBar
        definesPresentationContext = true
        

        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(showSearchBar))
        
        

        // Do any additional setup after loading the view.
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

    //MARK: - Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location Manager")
        print(locations.count)
        
        if locations.count > 1  {
            print(locations[0].timestamp.timeIntervalSince(locations[1].timestamp))
        }
        
        let seedLocation: CLLocation = locations[0] as CLLocation
        seedMapView!.centerCoordinate = seedLocation.coordinate
        
        let seedPlacemark = MKPlacemark(coordinate: seedLocation.coordinate)
        seedMapView!.removeAnnotations(seedMapView!.annotations)
        seedMapView!.addAnnotation(seedPlacemark)
        seedMapView!.setRegion(MKCoordinateRegionMake(seedLocation.coordinate, MKCoordinateSpan()), animated: true)
        
        seedGeocoder.reverseGeocodeLocation(locations[0], completionHandler: { (placemarks, error) -> Void in
            
            let placemark = placemarks![0]
            //print(placemark)
            //print(placemark.addressDictionary!)
            
            let address = placemark.addressDictionary!["FormattedAddressLines"]
            print(address)
            
            
            
        })
        
        
        
        //print("locationManager")
        //let seedLocation: CLLocation = locations[0] as CLLocation
        //seedTypeLabel!.text = "A: \(seedLocation.altitude), La: \(seedLocation.coordinate.latitude), Lo: \(seedLocation.coordinate.longitude)"
        
        //seedMapView!.setUserTrackingMode(.follow, animated: true)
        
        //seedTypeLabel!.text = "La: \(seedLocation.coordinate.latitude), Lo: \(seedLocation.coordinate.longitude)"
        //animateMap(seedLocation)
        
        //let seedPlacemark = MKPlacemark(coordinate: seedMapView!.centerCoordinate)
        //seedMapView!.removeAnnotations(seedMapView!.annotations)
        //seedMapView!.addAnnotation(seedPlacemark)
        
        /*seedGeocoder.reverseGeocodeLocation(seedLocation, completionHandler: {(placemarks, error) -> Void in
            if ((error) != nil)  {
                print("Hay que hacer algo aqui")
                self.seedLocationManager!.stopUpdatingLocation()
                self.seedLocationManager!.startUpdatingLocation()
            } else if placemarks!.count > 0  {
                let pm = placemarks![0] as CLPlacemark
                let mkpm = MKPlacemark(placemark: pm)
                
                self.seedMapView!.removeAnnotations(self.seedMapView!.annotations)
                self.seedMapView!.addAnnotation(mkpm)
                
                self.seedTypeLabel!.text = pm.addressDictionary!["FormattedAddressLines"] as? String
                //self.seedLocationManager!.stopUpdatingLocation()
                //self.seedTypeLabel!.text = CNPostalAddressFormatter.string(from: mkpm.addressDictionary["FormattedAddressLines"] , style: CNPostalAddressFormatterStyle.mailingAddress)
                //if pm != nil{
                    //self.seedLocationManager!.stopUpdatingLocation()
                
                
                    //self.seedTypeLabel!.text = "\(String(describing: pm.locality)) \(String(describing: pm.postalCode)) \(String(describing: pm.subAdministrativeArea)) \(String(describing: pm.administrativeArea)) \(String(describing: pm.country))"
                //}
            }
        
        })*/
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied  {
            print("User has denied localization services")
        } else  {
            print("Local Manager did fail with error \(error.localizedDescription)")
        }
        
    }
    
    func animateMap(_ location: CLLocation) {
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        seedMapView!.setRegion(region, animated: true)
    }
    
    //MARK: SearchBar
    func showSearchBar (sender: UIBarButtonItem) -> Void  {
        present(locationSearchController, animated: true, completion: nil)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        if seedMapView!.annotations.count != 0   {
            seedMapView!.removeAnnotation(seedMapView!.annotations[0])
        }
        
        let localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        let localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start(completionHandler: {(response, error) -> Void in
            if response == nil  {
                let locationAlert = UIAlertController(title: "AlertController", message: "Place not found", preferredStyle: UIAlertControllerStyle.alert)
                self.present(locationAlert, animated: true, completion: nil)
                return
            }
            
            let pointAnnotation: MKPointAnnotation = MKPointAnnotation()
            pointAnnotation.title = searchBar.text
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: response!.boundingRegion.center.latitude, longitude: response!.boundingRegion.center.longitude)
            
            let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
            self.seedMapView!.centerCoordinate = pointAnnotation.coordinate
            self.seedMapView!.addAnnotation(pinAnnotationView.annotation!)
        }
        
        
        
        )
        
        
    }
    
    //MARK MAP PRESS RECOGNIZER
    func mapPointPress(gesture: UILongPressGestureRecognizer) -> Void   {
        print("Under pression!")
        let coordinate = seedMapView!.convert(gesture.location(in: seedMapView!), toCoordinateFrom: seedMapView)
        seedMapView!.setCenter(coordinate, animated: true)
    }
}
