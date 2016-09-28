//
//  HTTPHelper.swift
//  Jarvis
//
//  Created by James Hart on 8/9/16.
//  Copyright © 2016 James Hart. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HTTPHelp {
    
    //Living Room lights On
    func LRLightsOn() {
        //ViewController.activityInd.hidden = false
        //ViewController.activityInd.startAnimating()
        
        let postEndpoint:String = "http://jarvisha.herokuapp.com/api/lrlightsons"
        
        let params: [String:Any]? = [
            "lrlightson": [
                "notes": "Jarvis iOS",
                "api": "yes"
            ]
        ]
        
        Alamofire.request(postEndpoint, method: .post, parameters: params).response { response in
            print(response.response)
            print(response.data)
            print(response.request)
            
            
            
        }
        
       
    }
    
    
    
    //Living Room Lights Off
    func LRLightsOff() {
        //self.activityInd.hidden = false
        //self.activityInd.startAnimating()
        
        let postEndpoint:String = "http://jarvisha.herokuapp.com/api/lrlightsoffs"
        
        let params = [
            "lrlightsoff": [
                "notes": "Jarvis iOS",
                "api": "yes"
            ]
        ]
        
        Alamofire.request(postEndpoint, method: .post, parameters: params).response { response in
            print(response)
            
        }
    }

}
