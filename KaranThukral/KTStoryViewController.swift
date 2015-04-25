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
	var didLayoutCustomSubviews: Bool = false
	var allStories: Array <KTStory> = []
	var timelineBar: KTTimelineBarView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		textScrollView.delegate = self
		self.automaticallyAdjustsScrollViewInsets = false
		allStories = KTDataStore.allStories()
		bannerImageView.image = allStories[0].bannerImage
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setUpTimelineButtonStyle()
		if (didLayoutCustomSubviews == false) {
			setUpScrollView()
			setupTimelineBar()
		}
	}
	
	// MARK: Setup
	
	func setUpTimelineButtonStyle() {
		timelineButton.layer.cornerRadius = 0.5 * timelineButton.bounds.size.width
		timelineButton.layer.masksToBounds = false
		timelineButton.layer.shadowColor = KTConstants.circularButtonShadowColor.CGColor
		timelineButton.layer.shadowOpacity = 1.0
		timelineButton.layer.shadowRadius = 0
		timelineButton.layer.shadowOffset = CGSizeMake(0, 1.0)
		timelineButton.backgroundColor = KTConstants.primaryActionColor
		timelineButton.setBackgroundImage(UIImage(named: "timelineButton"), forState: UIControlState.Normal)
	}
	
	func setUpScrollView() {
		didLayoutCustomSubviews = true
		var numberOfPages = allStories.count + 1 // 1 extra for contact view
		textScrollView.contentSize = CGSizeMake(CGRectGetWidth(textScrollView.frame), (CGRectGetHeight(textScrollView.frame) * CGFloat(numberOfPages)))
		textScrollView.backgroundColor = UIColor.clearColor()
		
		for (var index = 0; index < allStories.count; index++) {
			var innerView = setUpInnerScrollViewForIndex(index)
			textScrollView.addSubview(innerView)
			innerScrollViews.append(innerView)
		}
		setupContactView()
	}
	
	func setUpInnerScrollViewForIndex(index: Int) -> UIScrollView {
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
		var contentSize = CGSizeMake(label.frame.size.width, label.frame.size.height + KTConstants.KTStoryView.innerScrollViewPadding)
		innerView.contentSize = contentSize
		innerView.showsVerticalScrollIndicator = false
		return innerView
	}
	
	func setUpLabelForIndex(index: Int) -> UILabel {
		var frame = CGRectMake(0, KTConstants.KTStoryView.topLabelPadding, textScrollView.frame.size.width, 0)
		var label = UILabel.init(frame: frame)
		let story = allStories[index]
		var labelText = story.body
		var attributedText = NSMutableAttributedString.init(string: labelText)
		var paragraphStyle = NSMutableParagraphStyle.new()
		paragraphStyle.lineSpacing = 12
		attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, NSString(string: labelText).length))
		
		label.attributedText = attributedText
		label.backgroundColor = UIColor.clearColor()
		label.textColor = UIColor.blackColor()
		label.numberOfLines = 0
		label.font = UIFont(name: "Maven Pro", size: 18.0)
		var labelSize = label.sizeThatFits(CGSizeMake(frame.width, CGFloat(MAXFLOAT)))
		var labelFrame = label.frame
		labelFrame.size = labelSize
		label.frame = labelFrame
		return label
	}
	
	func setupContactView() {
		var superView = UIView(frame: CGRectMake(0, CGRectGetHeight(textScrollView.frame) * CGFloat(allStories.count), CGRectGetWidth(textScrollView.frame), CGRectGetHeight(textScrollView.frame)))
		textScrollView.addSubview(superView)
		var viewHeight = KTConstants.KTStoryView.contactViewHeight
		var contactView = UIView(frame:CGRectMake(0, (CGRectGetHeight(superView.frame) - viewHeight)/2, CGRectGetWidth(superView.frame), viewHeight))
		var label = UILabel(frame: CGRectMake(0, 0, CGRectGetWidth(contactView.frame), KTConstants.KTStoryView.contactViewLabelHeight))
		label.font = UIFont(name: "Maven Pro", size: 22.0)
		label.textAlignment = NSTextAlignment.Center
		label.numberOfLines = 0
		label.text = "Designed & Developed By\nKaran Thukral"
		contactView.addSubview(label)
		
		var websiteButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
		var buttonWidth = KTConstants.KTStoryView.websiteButtonWidth
		websiteButton.frame = CGRectMake((CGRectGetWidth(superView.frame) - buttonWidth)/2, CGRectGetMaxY(label.frame) + 20, buttonWidth, KTConstants.KTStoryView.websiteButtonHeight)
		websiteButton.layer.cornerRadius = 0.5 * KTConstants.KTStoryView.websiteButtonHeight
		websiteButton.layer.masksToBounds = false
		websiteButton.addTarget(self, action: Selector("websiteButtonTapped"), forControlEvents: UIControlEvents.TouchUpInside)
		websiteButton.backgroundColor = KTConstants.primaryActionColor
		websiteButton.setBackgroundImage(UIImage(named: "websiteButton"), forState: UIControlState.Normal)
		contactView.addSubview(websiteButton)
		superView.addSubview(contactView)
	}
	
	func setupTimelineBar() {
		var height = CGRectGetHeight(textScrollView.frame) - CGRectGetHeight(timelineButton.frame) + 10
		timelineBar = KTTimelineBarView(frame: CGRectMake(CGRectGetMidX(timelineButton.frame) - (KTConstants.KTStoryView.timelineBarWidth/2), CGRectGetMaxY(bannerImageView.frame), KTConstants.KTStoryView.timelineBarWidth, height))
		self.view.insertSubview(timelineBar, atIndex: 0)
		timelineBar.setSelected(0)
		for view in timelineBar.allStoryViews {
			var tapGesture = UITapGestureRecognizer(target: self, action: Selector("timelineTapped:"))
			view.addGestureRecognizer(tapGesture)
		}
	}
	
	// MARK: Action Handlers
	
	func timelineTapped(gestureRecognizer: UITapGestureRecognizer) {
		var allTimelineViews = timelineBar.allStoryViews
		for var index = 0; index < allTimelineViews.count; index++ {
			if (allTimelineViews[index] == gestureRecognizer.view) {
				updateInnerScrollViewOffset(index)
				textScrollView.scrollRectToVisible(CGRectMake(0, CGRectGetHeight(textScrollView.frame) * CGFloat(index), CGRectGetWidth(textScrollView.frame), CGRectGetHeight(textScrollView.frame)), animated: true)
				changeTitleAndImage(index)
				break
			}
		}
	}
	
	func websiteButtonTapped() {
		UIApplication.sharedApplication().openURL(NSURL(string: "http://www.karanthukral.me")!)
	}
	
	// MARK: Scroll View Delegate
	
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		changeTitleAndImage(currentPage())
	}
	
	// MARK: Helpers
	
	func currentPage() -> Int {
		return Int(textScrollView.contentOffset.y/textScrollView.frame.size.height)
	}
	
	func pageLocation(page: Int) -> CGFloat {
		return CGFloat(CGFloat(page) * CGRectGetHeight(textScrollView.frame))
	}
	
	func changeTitleAndImage(index: Int) {
		timelineBar.setSelected(index)
		var image: UIImage?
		var title: String?
		if (index < allStories.count) {
			var story = allStories[index]
			image = story.bannerImage
			title = story.title
		} else {
			// Contact Page
			image = UIImage(named: "contactImage")
			title = "Contact"
		}
		
		UIView.transitionWithView(self.bannerImageView, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
			self.bannerImageView.image = image
			self.pageTitleLabel.text = title
			}) { (completed) -> Void in
				
		}
	}
	
	func updateInnerScrollViewOffset(index: Int) {
		if (index < allStories.count) {
			var innerScrollView = innerScrollViews[index]
			innerScrollView.contentOffset = CGPointZero
		}
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
		updateInnerScrollViewOffset(index)
		changeTitleAndImage(currentPage())
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func userDidPressExit() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

}