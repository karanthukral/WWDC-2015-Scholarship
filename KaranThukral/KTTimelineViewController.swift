//
//  KTTimelineViewController.swift
//  KaranThukral
//
//  Created by Karan Thukral on 2015-04-18.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

import UIKit

protocol KTTimelineDelegate {
	func userDidSelect(index: Int)
	func userDidPressExit()
}


class KTTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var exitTimelineButton: UIButton!
	var delegate: KTTimelineDelegate?
	var allStories: Array<KTStory> = []
	var selectedIndex: Int?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = UITableViewCellSeparatorStyle.None
		allStories = KTDataStore.allStories()
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setUpTimelineButtonStyle()
	}

	// MARK: Setup
	
	func setUpTimelineButtonStyle() {
		exitTimelineButton.layer.cornerRadius = 0.5 * exitTimelineButton.bounds.size.width
		exitTimelineButton.layer.masksToBounds = false
		exitTimelineButton.layer.shadowColor = KTConstants.circularButtonShadowColor.CGColor
		exitTimelineButton.layer.shadowOpacity = 1.0
		exitTimelineButton.layer.shadowRadius = 0
		exitTimelineButton.layer.shadowOffset = CGSizeMake(0, 1.0)
		exitTimelineButton.backgroundColor = KTConstants.destroyActionColor
		exitTimelineButton.setBackgroundImage(UIImage(named: "closeButton"), forState: UIControlState.Normal)
	}
    

	@IBAction func exitTimelineButtonPressed(sender: AnyObject) {
		delegate?.userDidPressExit()
	}
	
	// MARK: UITableViewDelegate

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 80.0
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate?.userDidSelect(indexPath.row)
	}
	
	// MARK: UITableViewDataSource
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allStories.count + 1
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var isSelected = false
		if (selectedIndex == indexPath.row) {
			isSelected = true
		}
		let cell = tableView.dequeueReusableCellWithIdentifier("timelineCell") as! KTTimelineCell
		var title: String?
		if (indexPath.row < allStories.count) {
			title = allStories[indexPath.row].title
		} else {
			title = "Contact"
		}
		cell.setUp(forTitle: title!, isSelected: isSelected)
		return cell
	}
	
	


}
