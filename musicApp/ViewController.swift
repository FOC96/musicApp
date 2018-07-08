//
//  ViewController.swift
//  musicApp
//
//  Created by Fernando Ortiz Rico Celio on 7/7/18.
//  Copyright © 2018 Fernando Ortiz Rico Celio. All rights reserved.
//

import UIKit
import MediaPlayer
import StoreKit

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    @IBOutlet weak var songAlbum: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var songArtwork: UIImageView!
    @IBOutlet weak var pickerBtn: UIButton!
    @IBOutlet weak var magicBtn: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.layer.cornerRadius = 10
        self.view.layer.masksToBounds = true
        
        magicBtn.addTarget(self, action: #selector(magicDown), for: UIControlEvents.touchUpInside)
        magicBtn.addTarget(self, action: #selector(magicUp), for: UIControlEvents.touchUpOutside)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func magicDown() {
        magicBtn.setImage(#imageLiteral(resourceName: "magicActive"), for: .normal)
    }
    
    @objc func magicUp() {
        magicBtn.setImage(#imageLiteral(resourceName: "magicDefault"), for: .normal)
    }
    
    
    
    
    @IBAction func pickSong(_ sender: Any) {
        let mediaPicker = MPMediaPickerController(mediaTypes: .music)
        mediaPicker.allowsPickingMultipleItems = false
        mediaPicker.popoverPresentationController?.sourceView = view
        mediaPicker.delegate = self
        present(mediaPicker, animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        for item in mediaItemCollection.items {
            if let artwork = item.artwork?.image(at: CGSize(width: 800, height: 800)) {
                songArtwork.image = artwork
                let colores = artwork.getColors()
                slider.tintColor = colores.primary
                pickerBtn.tintColor = colores.primary
                if let title = item.title {
                    songTitle.text = title
                    if let artist = item.artist {
                        songArtist.text = artist
                        if let album = item.albumTitle {
                            songAlbum.text = album
                        }
                    }
                }
            }
        }
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    

}

