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
//                self.showAlert(title: "Authorized", message: "The deviced is linked to an Apple Music account", buttonTitle: "OK", buttonStyle: .default, buttonAction: ())
                print("Authorized")
                self.askPerm()
                break;
            case .denied:
                print("Denied")
//                self.showAlert(title: "Denied", message: "The deviced is not linked to an Apple Music account", buttonTitle: "OK", buttonStyle: .default, buttonAction: ())
                break;
            case .notDetermined:
                print("Not determined")
//                self.showAlert(title: "Not Determined", message: "This is weird", buttonTitle: "OK", buttonStyle: .default, buttonAction: ())
                break;
            default:
//                self.showAlert(title: "ERROR", message: "", buttonTitle: "OK", buttonStyle: .default, buttonAction: ())
                print("ERROR")
                break;
            }
        }
    }
    
    func askPerm() {
        controller.requestCapabilities { (capabilities : SKCloudServiceCapability, error) in
            if capabilities.contains(SKCloudServiceCapability.musicCatalogPlayback) {
//                self.showAlert(title: "Playback Allowed", message: "The device allows playback of Apple Music catalog tracks.", buttonTitle: "OK", buttonStyle: .default, buttonAction: ())
                print("musicCatalogPlayback good")
                self.showArtistsView()
            }
        }
    }
    
    func showArtistsView() {
        performSegue(withIdentifier: "showArtists", sender: self)
    }
    
//    func showAlert(title: String, message: String, buttonTitle: String, buttonStyle : UIAlertActionStyle, buttonAction: ()) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
//            alert.dismiss(animated: true, completion: nil)
//        }
//        let mainAction = UIAlertAction(title: buttonTitle, style: buttonStyle) { (action) in
//            alert.dismiss(animated: true, completion: {
//                buttonAction
//            })
//        }
//        alert.addAction(cancelAction)
//        alert.addAction(mainAction)
//        present(alert, animated: true, completion: nil)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
