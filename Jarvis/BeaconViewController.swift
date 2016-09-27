//
//  BeaconViewController.swift
//  Jarvis
//
//  Created by James Hart on 8/9/16.
//  Copyright © 2016 James Hart. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconViewController: UIViewController, CLLocationManagerDelegate   {

    //Outlets
    @IBOutlet var messageLabel: UILabel!
    
    //Properties
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.messageLabel.text = "Init"
        
        //BLE
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - BLUETOOTH
    
    func locationManager(_ manager: CLLocationManager!, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                    print("scanning")
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "665EB58C-0933-4A9E-B9F1-BBB5F8551344")
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: 01, minor: 02, identifier: "living Room")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion){
        if beacons.count > 0 {
            let beacon = beacons[0] 
            updateDistance(beacon.proximity)
        } else {
            updateDistance(.unknown)
        }
    }
    
    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8, animations: {
            switch distance {
            case .unknown: 
                self.messageLabel.text = "No beacon detected"
                
            case .far:
                self.messageLabel.text = "turn it off"
                let HTTP = HTTPHelp()
                HTTP.LRLightsOff()
                
            case .near:
                self.messageLabel.text = "Beacon Detected"
                let HTTP = HTTPHelp()
                HTTP.LRLightsOn()
                
            case .immediate:
                self.messageLabel.text = "Beacon Detected Adjacent"
                let HTTP = HTTPHelp()
                HTTP.LRLightsOn()
            }
        }) 
    }
    
    func locationManager(_ manager: CLLocationManager!, didFailWithError error: Error) {
        messageLabel.text = "error"
    }
    
    
    func locationManager(_ manager: CLLocationManager!, monitoringDidFailFor region: CLRegion!, withError error: Error) {
        messageLabel.text = "Region Failed"
    }
    
    
    func locationManager(_ manager: CLLocationManager!, rangingBeaconsDidFailFor region: CLBeaconRegion!, withError error: Error) {
        //messageLabel.text = "Ranging Beacons Did Fail in Region"
    }

    //Status bar white color
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    

}
