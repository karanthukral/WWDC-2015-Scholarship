//
//  KTDataStore.swift
//  KaranThukral
//
//  Created by Karan Thukral on 2015-04-18.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

import UIKit

struct KTStory {
	var title: String
	var body: String
	var bannerImage: UIImage
	
	init(storyTitle: String, storyBody: String, image: UIImage) {
		self.title = storyTitle
		self.body = storyBody
		self.bannerImage = image
	}
}

class KTDataStore: NSObject {
	
	class func allStories() -> Array <KTStory> {
		var array = [KTStory]()
		
		var lifeInIndia = KTStory(storyTitle: "Life in India", storyBody: "I was born in New Delhi, India and grew up in a small town called Chandigarh, a couple hundred miles away from the capital. I moved to Canada while in grade 12 to town called Brantford and completed my high school there. Thereafter, I enrolled into the University of Toronto's Computer Science program and subsequently moved to Toronto as well.", image: UIImage(named: "profileImage")!)
		array.insert(lifeInIndia, atIndex: 0)
		
		var highSchool = KTStory(storyTitle: "High School & \nFIRST Robotics", storyBody: "I was born in New Delhi, India and grew up in a small town called Chandigarh, a couple hundred miles away from the capital. I moved to Canada while in grade 12 to town called Brantford and completed my high school there. Thereafter, I enrolled into the University of Toronto's Computer Science program and subsequently moved to Toronto as well.", image: UIImage(named: "profileImage")!)
		array.insert(highSchool, atIndex: 1)
		
		var university = KTStory(storyTitle: "University", storyBody: "I was born in New Delhi, India and grew up in a small town called Chandigarh, a couple hundred miles away from the capital. I moved to Canada while in grade 12 to town called Brantford and completed my high school there. Thereafter, I enrolled into the University of Toronto's Computer Science program and subsequently moved to Toronto as well.", image: UIImage(named: "profileImage")!)
		array.insert(university, atIndex: 2)
		
		var kikAndCbc = KTStory(storyTitle: "Kik & CBC", storyBody: "I was born in New Delhi, India and grew up in a small town called Chandigarh, a couple hundred miles away from the capital. I moved to Canada while in grade 12 to town called Brantford and completed my high school there. Thereafter, I enrolled into the University of Toronto's Computer Science program and subsequently moved to Toronto as well.", image: UIImage(named: "profileImage")!)
		array.insert(kikAndCbc, atIndex: 3)
		
		var shopify = KTStory(storyTitle: "Shopify", storyBody: "I was born in New Delhi, India and grew up in a small town called Chandigarh, a couple hundred miles away from the capital. I moved to Canada while in grade 12 to town called Brantford and completed my high school there. Thereafter, I enrolled into the University of Toronto's Computer Science program and subsequently moved to Toronto as well.", image: UIImage(named: "profileImage")!)
		array.insert(shopify, atIndex: 4)
		
		var mcHackAndCFK = KTStory(storyTitle: "McHacks 2015 & \nCode For Kids", storyBody: "I was born in New Delhi, India and grew up in a small town called Chandigarh, a couple hundred miles away from the capital. I moved to Canada while in grade 12 to town called Brantford and completed my high school there. Thereafter, I enrolled into the University of Toronto's Computer Science program and subsequently moved to Toronto as well.", image: UIImage(named: "profileImage")!)
		array.insert(mcHackAndCFK, atIndex: 5)
		
		return array
	}
   
}
