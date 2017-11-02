//
//  ViewController.swift
//  BeerScroller
//
//  Created by Ben Scheirman on 10/25/17.
//  Copyright © 2017 NSScreencast. All rights reserved.
//

import UIKit

class BeerListViewController: UITableViewController {

    let breweryDBClient = BreweryDBClient()
    
    var beers: [Beer] = []
    private var currentPage = 1
    private var shouldShowLoadingCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Beers"
        
        tableView.estimatedRowHeight = 56
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(BeerCell.self, forCellReuseIdentifier: String(describing: BeerCell.self))
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshBeers), for: .valueChanged)

        refreshControl?.beginRefreshing()
        loadBeers()
    }
    
    @objc
    private func refreshBeers() {
        currentPage = 1
        loadBeers(refresh: true)
    }
    
    private func loadBeers(refresh: Bool = false) {
        print("Fetching page \(currentPage)")
        breweryDBClient.fetchBeers(page: currentPage, styleId: 3) { page in
            DispatchQueue.main.async {
                
                if refresh {
                    self.beers = page.data
                } else {
                    for beer in page.data {
                        if !self.beers.contains(beer) {
                            self.beers.append(beer)
                        }
                    }   
                }
                
                self.shouldShowLoadingCell = page.currentPage < page.numberOfPages
                
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    private func fetchNextPage() {
        currentPage += 1
        loadBeers()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = beers.count
        return shouldShowLoadingCell ? count + 1 : count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoadingIndexPath(indexPath) {
            return LoadingCell(style: .default, reuseIdentifier: "loading")
        } else {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BeerCell.self), for: indexPath) as! BeerCell
            let beer = beers[indexPath.row]
            
            cell.beerNameLabel.text = beer.name
            cell.breweryLabel.text = beer.breweries.first?.nameShortDisplay ?? "(unknown)"
            
            if let abv = beer.abv {
                cell.abvLabel.isHidden = false
                cell.abvLabel.text = "\(abv)%"
            } else {
                cell.abvLabel.isHidden = true
            }
            
            return cell
        }
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        fetchNextPage()
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == self.beers.count
    }
}

