//
//  AlbumDetails.swift
//  musicApp
//
//  Created by Fernando Ortiz Rico Celio on 7/9/18.
//  Copyright © 2018 Fernando Ortiz Rico Celio. All rights reserved.
//

import UIKit
import MediaPlayer

class AlbumDetails: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumTracksTable: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var playButton: Button!
    @IBOutlet weak var shuffleButton: Button!
    
    
    var accentColor : UIColor = UIColor(red:0.054902, green:0.054902, blue:0.054902, alpha:1.0)
    var songs = [MPMediaItem]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.layer.cornerRadius = 10
        self.view.layer.masksToBounds = true
        getAllSongs()
        // Do any additional setup after loading the view.
        if selectedAlbum != nil {
            artwork.image = selectedAlbum?.artwork?.image(at: CGSize(width: 1000, height: 1000))
            albumTitle.text = selectedAlbum?.albumTitle
            artist.text = selectedAlbum?.albumArtist

            let colors = selectedAlbum?.artwork?.image(at: CGSize(width: 1000, height: 1000))?.getColors()
            
            accentColor = (colors?.secondary)!
            
            artist.textColor = accentColor
            
            let playImage = UIImage(named: "play")
            let shuffleImage = UIImage(named: "shuffle")
            let playTinted = playImage?.withRenderingMode(.alwaysTemplate)
            let shuffleTinted = shuffleImage?.withRenderingMode(.alwaysTemplate)
            playButton.setImage(playTinted, for: .normal)
            shuffleButton.setImage(shuffleTinted, for: .normal)
            
            playButton.tintColor = accentColor
            shuffleButton.tintColor = accentColor
        } else {
            
        }
        albumTracksTable.dataSource = self
        albumTracksTable.delegate = self
        print(songs.count)
        
        let height = CGFloat(songs.count*60)
        
        print(height)
        
        tableHeight.constant = height
        
        albumTracksTable.layoutIfNeeded()
        
        albumTracksTable.reloadData()
    }
    
    
    func getAllSongs() {
        let albumTitleFilter = MPMediaPropertyPredicate(value: selectedAlbum?.albumTitle, forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: MPMediaPredicateComparison.equalTo)
        let artistPredicate: MPMediaPropertyPredicate =
            MPMediaPropertyPredicate(value: selectedAlbum?.albumArtist,
                                     forProperty: MPMediaItemPropertyAlbumArtist)
        
        let noCloudPredicate: MPMediaPropertyPredicate =
            MPMediaPropertyPredicate(value: false,
                                     forProperty: MPMediaItemPropertyIsCloudItem)
        
        let query: MPMediaQuery = MPMediaQuery.songs()
        query.addFilterPredicate(noCloudPredicate)
        query.addFilterPredicate(artistPredicate)
        query.addFilterPredicate(albumTitleFilter)
        
        songs = query.items!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTracksTable.dequeueReusableCell(withIdentifier: "trackCell") as! trackCell
        
        cell.trackNumber.text = String(songs[indexPath.row].albumTrackNumber)
        cell.trackName.text = songs[indexPath.row].title
        cell.trackArtist.text = songs[indexPath.row].artist
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as! ArtistCell
//
//        if artistsArray[indexPath.row]["artwork"] != nil {
//            cell.artistImage.image = (artistsArray[indexPath.row].artwork)?.image(at: CGSize(width: 50, height: 50))
//        } else {
//            cell.artistImage.image = #imageLiteral(resourceName: "prueba")
//        }
//        cell.artistName.text = artistsArray[indexPath.row].albumTitle
//
//        return cell
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

class trackCell: UITableViewCell {
    @IBOutlet weak var trackNumber: UILabel!
    @IBOutlet weak var trackArtist: UILabel!
    @IBOutlet weak var trackName: UILabel!
}
