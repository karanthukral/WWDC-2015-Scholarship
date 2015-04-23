//
//  KTConstants.swift
//  KaranThukral
//
//  Created by Karan Thukral on 2015-04-20.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

import Foundation
import UIKit

struct KTConstants {
	
	static let circularButtonShadowColor = UIColor(hue:0, saturation:0, brightness:0.5, alpha:1)
	
	struct KTStoryView {
		static let timelineButtonBackgroundColor = UIColor(hue:0.57, saturation:0.75, brightness:0.85, alpha:1)
		static let innerScrollViewPadding = CGFloat(50)
		static let topLabelPadding = CGFloat(15)
		static let timelineBarWidth = CGFloat(8)
	}
	
	struct KTTimelineView {
		static let cancelTimelineButtonBackgroundColor = UIColor(hue:0.96, saturation:0.89, brightness:0.76, alpha:1)
	}
	
	struct KTTimelineBarView {
		static let selectedDotColor = UIColor(hue:0.57, saturation:0.81, brightness:0.67, alpha:0.7)
		static let unselectedDotColor = UIColor(hue:0, saturation:0, brightness:0.89, alpha:1)
		static let barColor = UIColor(hue:0, saturation:0, brightness:0.92, alpha:0.7)
		static let verticalBarPadding = CGFloat(23)
		static let numberOfStories = CGFloat(6)
		static let leftDotPadding = CGFloat(-2.5)
		static let dotSize = CGFloat(13)

	}
}
