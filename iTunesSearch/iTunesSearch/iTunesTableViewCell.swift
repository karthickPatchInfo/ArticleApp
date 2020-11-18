//
//  iTunesTableViewCell.swift
//  iTunesSearch
//
//  Created by Karthick Chandran on 6/4/20.
//  Copyright © 2020 Karthick Chandran. All rights reserved.
//

import UIKit

class iTunesTableViewCell: UITableViewCell {

    @IBOutlet weak var artWorkImage: UIImageView!
    @IBOutlet weak var previewUrl: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var genre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCellData(data:iTunesDisplayData){
        previewUrl.text = data.previewURL
        artistName.text = data.artistName
        genre.text = data.primaryGenreName
        if (data.artworkUrl100 != nil) {
            loadArtworkImage(iconUrl: data.artworkUrl100!)
        } else if (data.artworkUrl30 != nil){
            loadArtworkImage(iconUrl: data.artworkUrl30!)
        } else if (data.artworkUrl60 != nil) {
            loadArtworkImage(iconUrl: data.artworkUrl60!)
        }
        
    }
    func loadArtworkImage(iconUrl:String)  {
         let session = URLSession.shared
            let url = URL(string: iconUrl)
               if (url != nil)
                       {
                           let task = session.dataTask(with: url!) { (Data, response, error) in
                       if (Data != nil) {
                          DispatchQueue.main.async {
                          self.artWorkImage.image = UIImage(data: Data!)
                           }}
                      }
                      task.resume()
               }
    }
}
