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
		
		var lifeInIndia = KTStory(storyTitle: "Life in India", storyBody: "I was born in New Delhi, India and grew up in a small town called Chandigarh. From an early age I was interested in computers and loved to tinker with the desktop and my flip phone. In middle school I got the chance to take up programming courses in C++ and Visual Basic which sparked my interest in this field. Apart from academics, I learnt how to play the keyboard and and enjoyed a game of tennis. Right after graduating grade 10, I got an opportunity to move to Canada to finish high school and pursue post secondary education.", image: UIImage(named: "indiaMap")!)
		array.insert(lifeInIndia, atIndex: 0)
		
		var highSchool = KTStory(storyTitle: "High School & \nFIRST Robotics", storyBody: "I attended Georges Vanier Secondary School in North York, Toronto during my last two years of high school. My interest in programming continued and grew in school where I where I learnt Java and C++. I was also a part of the FIRST robotics team for the 2011 season and was the captain for the 2012 season. Each year we, designed, built and programmed a robot to compete in Toronto regionals. Currently I mentor a FIRST robotics team in Waterloo (Team 3683).", image: UIImage(named: "roboticsImage")!)
		array.insert(highSchool, atIndex: 1)
		
		var university = KTStory(storyTitle: "University", storyBody: "Upon graduation in 2012, I decided to attend University of Waterloo for Systems Design Engineering. For the first two years, I did not have an opportunity to take more than a couple of programming courses and thus pursued my interest in the field by learning Objective C and iOS development.", image: UIImage(named: "universityImage")!)
		array.insert(university, atIndex: 2)
		
		var kikAndCbc = KTStory(storyTitle: "Kik & CBC", storyBody: "After my first semester, I interned with Kik interactive as a QA specialist, responsible for writing automated test scripts and manually testing the application before every release. While at Kik, I started to get serious about iOS development and made a simple tip calculator. \n\nDuring my internship with Canadian Broadcasting Corporation, as an iOS developer, I built a fully native new client for iOS 7.\n\nAround the same time I built and released my first iOS application to the App Store called Remembr! which is a simple note taking application. ", image: UIImage(named: "kikImage")!)
		array.insert(kikAndCbc, atIndex: 3)
		
		var shopify = KTStory(storyTitle: "Shopify", storyBody: "Due to my experience with iOS development, I got hired as a Software Developer intern by the Retail team at Shopify Inc. During my two internships at the company, I got the chance to work on the Shopify for iPhone application and Shopify Point of Sale application. I was part of the team that helped turn Shopify POS from an iPad only app to a universal one. \n\nApart from iOS, I helped implement Passbook integration for gift cards on Shopify and improve tools available to the support team in order to make it easier to assist retail customers. Both these projects primarily used Ruby on Rails.", image: UIImage(named: "shopifyImage")!)
		array.insert(shopify, atIndex: 4)
		
		var mcHacksAndCFK = KTStory(storyTitle: "McHacks 2015 & \nCode For Kids", storyBody: "My friends and I teamed up to build an iOS application with Ruby on Rails backend called Tendr at a hackathon in Montreal in February 2015 (McHacks 2015). We won first place at the hackathon and got invited to the Global Hackathon in Seoul, South Korea which is scheduled for the end of July 2015.\n\nApart from programming, I was involved with a not for profit called Code for Kids. I helped and run events in Ottawa and organized similar events in Waterloo. These events were aimed at kids aged 7-13 to teach them the basics of programming and popularize STEM.", image: UIImage(named: "tendrImage")!)
		array.insert(mcHacksAndCFK, atIndex: 5)
		
		return array
	}
   
}
