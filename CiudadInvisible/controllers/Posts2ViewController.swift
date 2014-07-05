//
//  Posts2ViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 05/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class Posts2ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var scrollView : UIScrollView
    
    var headerImageYOffset : CGFloat = -150.0
    var headerImage = UIImageView(image: UIImage(named: "bg1.jpg"))
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //
        scrollView.removeFromSuperview()
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 180))
        let blackBorderView = UIView(frame: CGRect(x: 0, y: 179, width: self.view.frame.size.width, height: 1))
        blackBorderView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        tableHeaderView.addSubview(blackBorderView)
        
        let tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.tableHeaderView = tableHeaderView
        
        self.view.addSubview(tableView)
        
        //
        var headerImageFrame = headerImage.frame
        headerImageFrame.origin.y = headerImageYOffset
        headerImage.frame = headerImageFrame
        self.view.insertSubview(headerImage, aboveSubview: tableView)
        
        
        /*

        // Create an empty table header view with small bottom border view
        UIView *tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, self.view.frame.size.width, 180.0)];
        UIView *blackBorderView = [[UIView alloc] initWithFrame: CGRectMake(0.0, 179.0, self.view.frame.size.width, 1.0)];
        blackBorderView.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.8];
        [tableHeaderView addSubview: blackBorderView];
        [blackBorderView release];
        
        _tableView.tableHeaderView = tableHeaderView;
        [tableHeaderView release];
        
        // Create the underlying imageview and offset it
        _headerImageYOffset = -150.0;
        _headerImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"header-image.png"]];
        CGRect headerImageFrame = _headerImage.frame;
        headerImageFrame.origin.y = _headerImageYOffset;
        _headerImage.frame = headerImageFrame;
        [self.view insertSubview: _headerImage belowSubview: _tableView];
        
        */
        
        
        /* TWITTER COVER
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 4000)
        scrollView.addTwitterCoverWithImage(UIImage(named: "bg1.jpg"))
        */
    }
 
    // MARK: ScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        let scrollOffset = scrollView.contentOffset.y;
        var headerImageFrame = headerImage.frame;
        
        if (scrollOffset < 0) {
            // Adjust image proportionally
            headerImageFrame.origin.y = headerImageYOffset - ((scrollOffset / 3));
        } else {
            // We're scrolling up, return to normal behavior
            headerImageFrame.origin.y = headerImageYOffset - scrollOffset;
        }
        headerImage.frame = headerImageFrame;
    }
    
}
