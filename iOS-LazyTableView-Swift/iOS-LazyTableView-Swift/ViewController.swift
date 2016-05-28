//
//  ViewController.swift
//  iOS-LazyTableView-Swift
//
//  Created by Jared on 5/27/16.
//  Copyright © 2016 Jared Stefanowicz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, L3SDKLazyTableViewDelegate
{
    struct ViewControllerConstants
    {
        static let lazyLoadPageSize = 15
    }
    
    var dataSource: [String]!
    
    @IBOutlet weak var lazyTableView: L3SDKLazyTableView!
    
    @IBOutlet weak var itemsIndicatorLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.dataSource = [String]()
        
        fetchNewItems()
        
        self.lazyTableView.delegate = self
        self.lazyTableView.dataSource = self
        self.lazyTableView.lazyLoad.enabled = true
        self.lazyTableView.lazyLoad.pageSize = ViewControllerConstants.lazyLoadPageSize
    }

    func fetchNewItems()
    {
        var counter = self.dataSource.count
        for _ in 0..<ViewControllerConstants.lazyLoadPageSize
        {
            dataSource.append("Item - \(counter+1)")
            counter += 1
        }
        
        self.itemsIndicatorLabel.text = "\(counter) items loaded."
    }
    
    // MARK: Lazyload Table View
    
    func tableView(tableView: UITableView, lazyLoadNextCursor cursor: Int)
    {
        fetchNewItems()
        lazyTableView.reloadData()
    }
    
    // MARK: Table View 
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = self.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
}

