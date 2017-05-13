//
//  DynamicLevelController.swift
//  SOExDynamicButtonGen
//
//  Created by Gero Herkenrath on 12.05.17.
//  Copyright © 2017 Gero Herkenrath. All rights reserved.
//

import UIKit

// general note about instantiating and pushing manually here:
// I played around a bit with cyclic segues a bit (i.e. a segues targeting the same view controller it starts in), but
// the way interface builder works seems to indicate that this is "not recommended". It works if the segues comes
// from a table cell, but you can't just create a "manual" segues like this, i.e. a segues that is not started
// by a specific UI element like a cell or button, but just belongs to the view controller itself.
// This is fine if you ALWAYS target the same view controller, but if you want to keep a collection of segues
// around, one of which is self-targeting and the others target different view controllers that doesn't work.
// In this case you'd have to have multiple prototype cells, one with the self-targeting segue and some with the others
// or none. I guess this is confusing enough to read, so the resulting code is probably messy and ugly, too.
// I'd advise against this.


class DynamicLevelController: UITableViewController {
	
	var mySubtree = OptionNode(value: "")
	// I am using a "stupid" init value to avoid an optional and clutter the code here
	// also, it *is*, in a way, a meaningful default, because I need something to display
	// In the app, right after this VC is instantiated, but before its view is shown, 
	// the presenting controller sets this to the correct node

	@IBOutlet weak var sectionHeader: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		sectionHeader.text = mySubtree.value
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return mySubtree.children.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dynamicCell", for: indexPath)
		if let view = cell.viewWithTag(1) as? UILabel {
			view.text = mySubtree.children[indexPath.row].value
		}
        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// same as before...
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		if let dynVC = storyboard.instantiateViewController(withIdentifier: "dynamicLevelController") as? DynamicLevelController {
			// but this time, we give our relevant child!
			dynVC.mySubtree = self.mySubtree.children[indexPath.row]
			self.navigationController?.pushViewController(dynVC, animated: true)
		}
	}
	
}
