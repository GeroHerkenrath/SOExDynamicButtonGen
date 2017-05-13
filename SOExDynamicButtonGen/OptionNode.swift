//
//  OptionNode.swift
//  SOExDynamicButtonGen
//
//  Created by Gero Herkenrath on 12.05.17.
//  Copyright © 2017 Gero Herkenrath. All rights reserved.
//

import Foundation

class OptionNode{
	var value: String
	
	weak var parent: OptionNode?
	var children = [OptionNode]()
	
	init(value: String){
		self.value = value
	}
	
	func addOption(node: OptionNode){
		children.append(node)
		node.parent = self
	}
}
