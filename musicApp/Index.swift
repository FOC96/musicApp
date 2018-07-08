//
//  Index.swift
//  musicApp
//
//  Created by Fernando Ortiz Rico Celio on 7/8/18.
//  Copyright © 2018 Fernando Ortiz Rico Celio. All rights reserved.
//

import UIKit
import StoreKit

class Index: UIViewController {
    
    let controller = SKCloudServiceController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectAM(_ sender: Any) {
        SKCloudServiceController.requestAuthorization { (status : SKCloudServiceAuthorizationStatus) in
            switch(status) {
            case .authorized:
                print("AUTORIZADO")
                self.askPerm()
                break;
            case .denied:
                print("DENEGADO")
                break;
            case .notDetermined:
                print("Sin determinar")
                break;
            default:
                print("Error")
                break;
            }
        }
    }
    
    func askPerm() {
        controller.requestCapabilities { (capabilities : SKCloudServiceCapability, error) in
            if capabilities.contains(SKCloudServiceCapability.musicCatalogPlayback) {
                print("The device allows playback of Apple Music catalog tracks.")
            }
        }
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
