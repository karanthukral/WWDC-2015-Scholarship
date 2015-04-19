//
//  KTStoryViewController.swift
//  KaranThukral
//
//  Created by Karan Thukral on 2015-04-15.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

import UIKit

class KTStoryViewController: UIViewController, UIScrollViewDelegate, KTTimelineDelegate {
	@IBOutlet weak var bannerImageView: UIImageView!
	@IBOutlet weak var pageTitleLabel: UILabel!
	@IBOutlet weak var timelineButton: UIButton!
	@IBOutlet weak var textScrollView: UIScrollView!
	var innerScrollViews: Array <UIScrollView> = []
	var didLayoutScrollViews: Bool = false
	var allStories: Array <KTStory> = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		textScrollView.delegate = self
		self.automaticallyAdjustsScrollViewInsets = false
		allStories = KTDataStore.allStories()
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setUpTimelineButtonStyle()
		if (didLayoutScrollViews == false) {
			setUpScrollView()
		}
	}
	
	// MARK: Setup
	
	func setUpTimelineButtonStyle() {
		timelineButton.layer.cornerRadius = 0.5 * timelineButton.bounds.size.width
		timelineButton.layer.masksToBounds = false
		timelineButton.layer.shadowColor = UIColor(hue:0, saturation:0, brightness:0.5, alpha:1).CGColor
		timelineButton.layer.shadowOpacity = 1.0
		timelineButton.layer.shadowRadius = 0
		timelineButton.layer.shadowOffset = CGSizeMake(0, 1.0)
		timelineButton.backgroundColor = UIColor(hue:0.57, saturation:0.75, brightness:0.85, alpha:1)
	}
	
	func setUpScrollView() {
		didLayoutScrollViews = true
		var numberOfPages = allStories.count
		textScrollView.contentSize = CGSizeMake(CGRectGetWidth(textScrollView.frame), (CGRectGetHeight(textScrollView.frame) * CGFloat(numberOfPages)))
		textScrollView.backgroundColor = UIColor.clearColor()
		
		for var index = 0; index < numberOfPages; index++ {
			var innerView = setUpInnerScrollViewForIndex(index)
			textScrollView.addSubview(innerView)
			innerScrollViews.append(innerView)
		}
	}
	
	func setUpInnerScrollViewForIndex(index: Int) -> UIScrollView {
		print("Index \(index) scroll view \n")
		var parentHeight = CGRectGetHeight(textScrollView.frame)
		var parentSize = textScrollView.frame.size
		var origin = CGPointMake(0, (parentHeight * CGFloat(index)))
		var rect = CGRectMake(origin.x, origin.y, parentSize.width, parentSize.height)
		
		var innerView = UIScrollView.init(frame: rect)
		innerView.backgroundColor = UIColor.clearColor()
		
		var label = setUpLabelForIndex(index)
		if (label.frame.size.height < innerView.frame.size.height) {
			label.center = CGPointMake(innerView.frame.size.width/2, innerView.frame.size.height/2)
		}
		innerView.addSubview(label)
		var contentSize = CGSizeMake(label.frame.size.width, label.frame.size.height + CGFloat(50.0))
		innerView.contentSize = contentSize
		return innerView
	}
	
	func setUpLabelForIndex(index: Int) -> UILabel {
		var frame = CGRectMake(10, 30, textScrollView.frame.size.width - 20, 0)
		var label = UILabel.init(frame: frame)
		let story = allStories[index]
		var labelText = story.body
		var attributedText = NSMutableAttributedString.init(string: labelText)
		var paragraphStyle = NSMutableParagraphStyle.new()
		paragraphStyle.lineSpacing = 8
		attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, NSString(string: labelText).length))
		
		label.attributedText = attributedText
		label.backgroundColor = UIColor.clearColor()
		label.textColor = UIColor.blackColor()
		label.numberOfLines = 0
		label.font = UIFont.systemFontOfSize(16.0)
		var labelSize = label.sizeThatFits(CGSizeMake(frame.width, CGFloat(MAXFLOAT)))
		var labelFrame = label.frame
		labelFrame.size = labelSize
		label.frame = labelFrame
		return label
	}
	
	// MARK: Scroll View Delegate
	
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		var page = currentPage()
		var pageScrollView = innerScrollViews[page]
		pageScrollView.contentOffset = CGPointZero
		changeTitleAndImage(page)
	}
	
	// MARK: Helpers
	
	func currentPage() -> Int {
		return Int(textScrollView.contentOffset.y/textScrollView.frame.size.height)
	}
	
	func pageLocation(page: Int) -> CGFloat {
		return CGFloat(CGFloat(page) * CGRectGetHeight(textScrollView.frame))
	}
	
	func changeTitleAndImage(index: Int) {
		var story = allStories[index]
		UIView.animateWithDuration(0.25, delay: 0.0, options: nil, animations: {
			self.pageTitleLabel.text = story.title
			}, completion: { finished in
				
		})
	}
	
	// MARK: Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if (segue.identifier == "timelineSegue") {
			var timelineView = segue.destinationViewController as! KTTimelineViewController
			timelineView.delegate = self
			timelineView.selectedIndex = currentPage()
		}
	}
	
	// MARK: KTTimelineDelegate
	
	func userDidSelect(index: Int) {
		var pageLoc = pageLocation(index)
		textScrollView.scrollRectToVisible(CGRectMake(0, pageLoc, CGRectGetWidth(textScrollView.frame), CGRectGetHeight(textScrollView.frame)), animated: false
		)
		var pageScrollView = innerScrollViews[index]
		pageScrollView.contentOffset = CGPointZero
		changeTitleAndImage(currentPage())
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func userDidPressExit() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

}