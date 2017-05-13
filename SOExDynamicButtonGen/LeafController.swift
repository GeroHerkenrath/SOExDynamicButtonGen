//
//  LeafController.swift
//  SOExDynamicButtonGen
//
//  Created by Gero Herkenrath on 12.05.17.
//  Copyright © 2017 Gero Herkenrath. All rights reserved.
//

import UIKit

class LeafController: UIViewController {
	
	var leafName = ""

	@IBOutlet weak var leafNameLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		leafNameLabel.text = leafName
    }

}
