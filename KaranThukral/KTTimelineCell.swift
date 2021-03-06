//
//  KTTimelineCell.swift
//  KaranThukral
//
//  Created by Karan Thukral on 2015-04-18.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

import UIKit

class KTTimelineCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!

	@IBOutlet weak var selectionImageView: UIImageView!
	
	func setUp(forTitle title: String, isSelected selected: Bool) {
		self.titleLabel.text = title
		if (selected) {
			selectionImageView.image = UIImage(named: "selectedStory")
		} else {
			selectionImageView.image = UIImage(named: "unselectedStory")
		}
	}

}
