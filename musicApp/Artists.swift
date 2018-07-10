//
//  Artists.swift
//  musicApp
//
//  Created by Fernando Ortiz Rico Celio on 7/8/18.
//  Copyright © 2018 Fernando Ortiz Rico Celio. All rights reserved.
//

import UIKit
import MediaPlayer

var selectedArtist : MPMediaItem?

class ArtistCell: UITableViewCell {
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
}

class Artists: UITableViewController {
    
    var artistsArray = [MPMediaItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false
        
        let query = MPMediaQuery.artists()
        
        var previous = ""
        var cont = 0
        
        for i in query.items! {
            if i.albumArtist != nil {
                if cont > 0 {
                    if previous != i.albumArtist {
                        artistsArray.append(i)
                    }
                }
                previous = i.albumArtist!
            }
            cont = cont+1
        }
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return artistsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as! ArtistCell
        
        if artistsArray[indexPath.row]["artwork"] != nil {
            cell.artistImage.image = artistsArray[indexPath.row].artwork?.image(at: CGSize(width: 100, height: 100))
        } else {
            cell.artistImage.image = #imageLiteral(resourceName: "artist")
        }
        cell.artistName.text = artistsArray[indexPath.row].albumArtist
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedArtist = artistsArray[indexPath.row]
        
        
        performSegue(withIdentifier: "showArtistDetails", sender: self)
    }
    

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
