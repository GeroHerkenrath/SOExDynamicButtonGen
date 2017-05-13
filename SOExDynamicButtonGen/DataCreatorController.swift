//
//  DataCreatorController.swift
//  SOExDynamicButtonGen
//
//  Created by Gero Herkenrath on 12.05.17.
//  Copyright © 2017 Gero Herkenrath. All rights reserved.
//

import UIKit

class DataCreatorController: UIViewController {
	
	static var menuOptions: OptionNode {
		
		let mainMenu = OptionNode(value: "Main Menu")
		let vehicle = OptionNode(value: "vehicle Menu")
		let food = OptionNode(value: "Food Menu")
		let computer = OptionNode(value: "Computer Menu")
		
		let ford = OptionNode(value: "Ford Menu")
		let toyota = OptionNode(value: "Toyota Menu")
		let honda = OptionNode(value: "Honda Menu")
		
		let apple = OptionNode(value: "Apple Menu")
		let orange = OptionNode(value: "Orange Menu")
		let pear = OptionNode(value: "Pear Menu")
		
		let hp = OptionNode(value: "HP Menu")
		let chrome = OptionNode(value: "Chrome Menu")
		let samsung = OptionNode(value: "Samsung Menu")
		
		mainMenu.addOption(node: vehicle)
		mainMenu.addOption(node: food)
		mainMenu.addOption(node: computer)
		
		vehicle.addOption(node: ford)
		vehicle.addOption(node: toyota)
		vehicle.addOption(node: honda)
		
		food.addOption(node: apple)
		food.addOption(node: orange)
		food.addOption(node: pear)
		
		computer.addOption(node: hp)
		computer.addOption(node: chrome)
		computer.addOption(node: samsung)
		
		return mainMenu
	}

	@IBAction func doDynamic(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil) // this could be any storyboard, not necessarily the main one
		
		// the identifier is defined in the storyboard
		if let dynVC = storyboard.instantiateViewController(withIdentifier: "dynamicLevelController") as? DynamicLevelController {
			dynVC.mySubtree = DataCreatorController.menuOptions
			
			// note I rely on having a navigation controller here, I just designed my app so.
			self.navigationController?.pushViewController(dynVC, animated: true)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? FirstLevelController {
			dest.nodeName = DataCreatorController.menuOptions.value
			dest.childrenNodes = DataCreatorController.menuOptions.children
		}
	}

}

