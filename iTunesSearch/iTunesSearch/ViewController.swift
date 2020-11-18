//
//  ViewController.swift
//  iTunesSearch
//
//  Created by Karthick Chandran on 6/4/20.
//  Copyright © 2020 Karthick Chandran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iTunesTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)

    let dataModel:iTunesDataModeller = iTunesDataModeller()
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadTableView()
        dataModel.searchItunes(for: "") { (result) in
            if result
            {
                self.loadTableView()
            }
        }
        
    }
    func loadTableView()
    {
        DispatchQueue.main.async {
            self.iTunesTableView.delegate = self
            self.iTunesTableView.dataSource = self
            self.iTunesTableView.register(UINib(nibName: "iTunesTableViewCell", bundle: .main), forCellReuseIdentifier: "iTunesCell")
            self.iTunesTableView.rowHeight = 102
            
            self.searchController.searchResultsUpdater = self
            self.searchController.obscuresBackgroundDuringPresentation = false
            self.searchController.searchBar.placeholder = "Search iTunes"
            self.searchController.searchBar.sizeToFit()
            self.navigationController?.navigationItem.searchController = self.searchController
            self.definesPresentationContext = true
            self.iTunesTableView.addSubview(self.searchController.searchBar)
            self.iTunesTableView.reloadData()
            self.iTunesTableView.layoutIfNeeded()
        }
        
    }
    func filterContentForSearchText(text:String) {
        dataModel.searchItunes(for: text) { (result) in
            if result
            {
                self.loadTableView()
                print(self.dataModel.iTunesArray.count)
                
            }
        }
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate
{
    func updateSearchResults(for searchController: UISearchController) {
         let searchBar = searchController.searchBar
        filterContentForSearchText(text: searchBar.text!)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        view.backgroundColor = UIColor.black
        let label:UILabel = UILabel(frame: CGRect(x: 20, y: 10, width: tableView.frame.size.width, height: 20))
        label.text = dataModel.sectionName[section]
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        view.addSubview(label)
        return view
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataModel.sections.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.sections[dataModel.sectionName[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath) as! iTunesTableViewCell
        guard let data = dataModel.sections[dataModel.sectionName[indexPath.section]]?[indexPath.row] else { return cell }
        cell.setCellData(data: data)
        return cell
    }
   
    
}
