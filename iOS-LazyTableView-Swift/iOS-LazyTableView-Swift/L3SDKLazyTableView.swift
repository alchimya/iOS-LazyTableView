//
//  L3SDKLazyTableView.swift
//  iOS-LazyTableView
//
//  Created by Jared on 5/27/16.
//  Copyright © 2016 DomenicoVacchiano. All rights reserved.
//

import UIKit

@objc protocol L3SDKLazyTableViewDelegate
{
    optional func tableView(tableView: UITableView, lazyLoadNextCursor cursor: Int)
}

class L3SDKLazyTableView: UITableView, UITableViewDelegate
{
    var lazyLoadEnabled: Bool!
    var lazyLoadPageSize: Int!
    var currentCursor: Int!
    var lazyLoad: L3SDKUtilityLazyLoad = L3SDKUtilityLazyLoad()
    override var delegate: UITableViewDelegate?
    {
        didSet
        {
            super.delegate = self
        }
        
        willSet
        {
            self.senderDelegate = newValue as? L3SDKLazyTableViewDelegate
        }
    }
    private var senderDelegate: L3SDKLazyTableViewDelegate?
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        super.delegate = self
    }
    
    override init(frame: CGRect, style: UITableViewStyle)
    {
        super.init(frame: frame, style: style)
        super.delegate = self
    }
    
    // MARK: UITableView UIScrollView Override
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        let endScrolling: CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height

        if (endScrolling >= scrollView.contentSize.height)
        {
            self.senderDelegate?.tableView?(self, lazyLoadNextCursor: self.lazyLoad.nextCursor())
            currentCursor = self.lazyLoad.currentCursor
        }
    }
}