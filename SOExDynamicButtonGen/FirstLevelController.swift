//
//  FirstLevelController.swift
//  SOExDynamicButtonGen
//
//  Created by Gero Herkenrath on 12.05.17.
//  Copyright © 2017 Gero Herkenrath. All rights reserved.
//

import UIKit

class FirstLevelController: UITableViewController {
	
	var nodeName = ""
	var childrenNodes = [OptionNode]()
	// note I split this a little different here just for fun...

	@IBOutlet weak var headerLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		headerLabel.text = self.nodeName
	}
	
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenNodes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstLevelCell", for: indexPath)
		if let nameLabel = cell.viewWithTag(1) as? UILabel {
			nameLabel.text = childrenNodes[indexPath.row].value
		}
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? SecondLevelController {
			let index = self.tableView.indexPathForSelectedRow?.row
			dest.nodeName = self.childrenNodes[index!].value
			dest.children = self.childrenNodes[index!].children
		}
    }

}
