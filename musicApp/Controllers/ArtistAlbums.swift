//
//  AlbumsController.swift
//  musicApp
//
//  Created by Fernando Ortiz Rico Celio on 7/9/18.
//  Copyright © 2018 Fernando Ortiz Rico Celio. All rights reserved.
//

import UIKit
import MediaPlayer

var selectedAlbum : MPMediaItem?

class ArtistAlbums: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    
    @IBOutlet weak var albumCollectionView: UICollectionView!
    @IBOutlet weak var artistCover: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    var albums = [MPMediaItem]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        artistCover.image = selectedArtist?.artwork?.image(at: CGSize(width: 800, height: 800))
        artistName.text = selectedArtist?.albumArtist
        self.navigationController?.navigationBar.isHidden = true
        self.view.layer.cornerRadius = 10
        self.view.layer.masksToBounds = true
        
        getAlbums()
        albumCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getAlbums() {
        let artistPredicate: MPMediaPropertyPredicate =
            MPMediaPropertyPredicate(value: selectedArtist?.albumArtist,
                                     forProperty: MPMediaItemPropertyAlbumArtist)
        
        let noCloudPredicate: MPMediaPropertyPredicate =
            MPMediaPropertyPredicate(value: false,
                                     forProperty: MPMediaItemPropertyIsCloudItem)
        
        let query: MPMediaQuery = MPMediaQuery.albums()
        
        query.addFilterPredicate(noCloudPredicate)
        query.addFilterPredicate(artistPredicate)
        
        var previous = ""
        var cont = 0
        
        for i in query.items! {
            if i.albumTitle != nil {
                if cont > 0 {
                    if previous != i.albumTitle {
                        albums.append(i)
                    }
                }
                previous = i.albumTitle!
            }
            cont = cont+1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCell

        cell.artwork.image = (albums[indexPath.row].artwork?.image(at: CGSize(width: 600, height: 600)))!
        cell.title.text = albums[indexPath.row].albumTitle
        cell.year.text = "YEAR"
        
//        cell.artwork.image = #imageLiteral(resourceName: "album")
//        cell.title.text = "Album Títle"
//        cell.year.text = "YEAR"

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAlbum = albums[indexPath.row]
        self.navigationController?.navigationBar.isHidden = true
        
        performSegue(withIdentifier: "showAlbumDetails", sender: self)
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

class AlbumCell : UICollectionViewCell {
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
}
