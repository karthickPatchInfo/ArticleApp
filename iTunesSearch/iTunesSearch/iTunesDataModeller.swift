//
//  iTunesDataModeller.swift
//  iTunesSearch
//
//  Created by Karthick Chandran on 6/4/20.
//  Copyright © 2020 Karthick Chandran. All rights reserved.
//

import Foundation

class iTunesDataModeller {
    var sections:Dictionary<String,[iTunesDisplayData]>
    var sectionName:[String]
    
    var iTunesArray:Array<iTunesDisplayData>
    
    init() {
        sections = [:]
        iTunesArray = [iTunesDisplayData]()
        sectionName = [String]()
    }
    func searchItunes(for searchTerm:String, completionHandler :  @escaping (Bool) -> ())  {
//        https://itunes.apple.com/search?term=jack+johnson
        let urlFormat = searchTerm.replacingOccurrences(of: " ", with: "+")
        let baseURL = "https://itunes.apple.com/search?term="
        let urlWithSearchTerm = baseURL + urlFormat
        print(urlWithSearchTerm)
        let session = URLSession.shared
        guard let url = URL(string: urlWithSearchTerm) else { return }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
             let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let data:iTunesData = try decoder.decode(iTunesData.self, from: data!)
                self.iTunesArray.removeAll()
                self.sections.removeAll()
                self.sectionName.removeAll()
                self.modelSearchResponse(data: data)
                completionHandler(true)
                } catch  {
                        print("error decoding dta:\(error)")
                        }
        }
        )
        task.resume()
    }
    func modelSearchResponse(data:iTunesData) {
        for eachResult in data.results {
            var dispData:iTunesDisplayData = iTunesDisplayData()
                dispData.artistName = eachResult.artistName
            if eachResult.kind != nil {
                dispData.kind = eachResult.kind
            }
                dispData.previewURL = eachResult.previewURL
                if eachResult.artworkUrl60 != nil {
                    dispData.artworkUrl60 = eachResult.artworkUrl60
                }
                else if eachResult.artworkUrl100 != nil {
                    dispData.artworkUrl100  = eachResult.artworkUrl100
                }
                else if eachResult.artworkUrl30 != nil {
                    dispData.artworkUrl30  = eachResult.artworkUrl30
                }
            iTunesArray.append(dispData)
        }
        self.groupSearchResultByKind()
    }
    func groupSearchResultByKind() {
        for eachResult in iTunesArray {
            guard let result = eachResult.kind else { return }
                if (sections[result] == nil) {
                    sectionName.append(result)
                    var dataArr:[iTunesDisplayData] = [iTunesDisplayData]()
                    dataArr.append(eachResult)
                    sections[result] = dataArr
                }
                else
                {
                    guard var data = sections[result] else { return }
                    data.append(eachResult)
                    sections[result] = data
                    
                }
         }
       
        print("--------------")
        print(sections)
        print(sections.count)
    }
  
}
