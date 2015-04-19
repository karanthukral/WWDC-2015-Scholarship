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
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func setUp(forStory story: KTStory, isSelected selected: Bool) {
		self.titleLabel.text = story.title
		if (selected) {
			selectionImageView.image = UIImage(named: "selectedStory")
		} else {
			selectionImageView.image = UIImage(named: "unselectedStory")
		}
	}

}