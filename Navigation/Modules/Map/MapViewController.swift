//
//  MapViewController.swift
//  Navigation
//
//  Created by a.agataev on 04.07.2022.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation

final class MapViewController: UIViewController {
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = .standard
        mapView.showsCompass = true
        mapView.showsBuildings = true
        mapView.delegate = self
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete all placemark", style: .plain, target: self, action: #selector(deleteAllPlacemarks))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Route", style: .plain, target: self, action: #selector(showRoutes))
        
        setupView()
        checkUserLocationPermissions()
        addPlacemarks()
    }
    
    private func setupView() {
        view.addSubview(mapView)

        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    private func checkUserLocationPermissions() {
        locationManager.startUpdatingLocation()
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
        case .denied, .restricted:
            print("Go to setting app")
        @unknown default:
            fatalError("Error!")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = "My Location"
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController: MKMapViewDelegate {
    @objc
    func showRoutes() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.755819, longitude: 37.617644)))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 53.195878, longitude: 50.100202)))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let response = response else { return }

            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    private func addPlacemarks() {
        let tulaCityCoords = CLLocationCoordinate2D(latitude: 54.193122, longitude: 37.617348)
        let tulaPlace = MKPlacemark(coordinate: tulaCityCoords)
        mapView.addAnnotation(tulaPlace)
    }
    
    @objc
    func deleteAllPlacemarks() {
        let annotations = mapView.annotations.filter({ $0 !== self.mapView.userLocation })
        mapView.removeAnnotations(annotations)
    }
}

extension MapViewController {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }
}

extension MapViewController {
}
