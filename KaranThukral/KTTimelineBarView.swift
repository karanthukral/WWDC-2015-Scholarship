//
//  KTTimelineBarView.swift
//  KaranThukral
//
//  Created by Karan Thukral on 2015-04-19.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

import UIKit

class KTTimelineBarView: UIView {
	
	var storyIndia: UIView?
	var highschoolStory: UIView?
	var uniStory: UIView?
	var kikAndCbcStory: UIView?
	var shopifyStory: UIView?
	var mcHacksAndCFKStory: UIView?
	var contact: UIView?
	var allStoryViews: Array <UIView> = []
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		storyIndia = UIView(frame: CGRectZero)
		self.addSubview(storyIndia!)
		allStoryViews.append(storyIndia!)
		
		highschoolStory = UIView(frame: CGRectZero)
		self.addSubview(highschoolStory!)
		allStoryViews.append(highschoolStory!)
			
		uniStory = UIView(frame: CGRectZero)
		self.addSubview(uniStory!)
		allStoryViews.append(uniStory!)
			
		kikAndCbcStory = UIView(frame: CGRectZero)
		self.addSubview(kikAndCbcStory!)
		allStoryViews.append(kikAndCbcStory!)
			
		shopifyStory = UIView(frame: CGRectZero)
		self.addSubview(shopifyStory!)
		allStoryViews.append(shopifyStory!)
			
		mcHacksAndCFKStory = UIView(frame: CGRectZero)
		self.addSubview(mcHacksAndCFKStory!)
		allStoryViews.append(mcHacksAndCFKStory!)
		
		contact = UIView(frame: CGRectZero)
		self.addSubview(contact!)
		allStoryViews.append(contact!)
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		var frame = self.frame
		var useableHeight = CGRectGetHeight(frame) - KTConstants.KTTimelineBarView.verticalBarPadding
		var distanceBetweenPoints = useableHeight/KTConstants.KTTimelineBarView.numberOfStories
		self.backgroundColor = KTConstants.KTTimelineBarView.barColor
		var index = CGFloat(0)
		for view in allStoryViews {
			view.frame = CGRectMake(KTConstants.KTTimelineBarView.leftDotPadding, CGFloat(KTConstants.KTTimelineBarView.verticalBarPadding + (distanceBetweenPoints * index)), KTConstants.KTTimelineBarView.dotSize, KTConstants.KTTimelineBarView.dotSize)
			view.layer.cornerRadius = KTConstants.KTTimelineBarView.dotSize / 2
			if (index == 0) {
				view.backgroundColor = KTConstants.KTTimelineBarView.selectedDotColor
			} else {
				view.backgroundColor = KTConstants.KTTimelineBarView.unselectedDotColor
			}
			index++
		}
	}
	
	func setSelected(index: Int) {
		for view in allStoryViews {
			view.backgroundColor = KTConstants.KTTimelineBarView.unselectedDotColor
		}
		var view = allStoryViews[index]
		view.backgroundColor = KTConstants.KTTimelineBarView.selectedDotColor
	}

}
