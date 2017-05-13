//
//  SecondLevelController.swift
//  SOExDynamicButtonGen
//
//  Created by Gero Herkenrath on 12.05.17.
//  Copyright © 2017 Gero Herkenrath. All rights reserved.
//

import UIKit


class SecondLevelController: UICollectionViewController {
	
	var nodeName = ""
	var children = [OptionNode]()

	@IBOutlet weak var headerLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		headerLabel.text = nodeName
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? LeafController, let cell = sender as? UICollectionViewCell {
			let index = self.collectionView?.indexPath(for: cell)?.row
			dest.leafName = self.children[index!].value
		}
	}

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.children.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondLevelCell", for: indexPath)
		if let label = cell.viewWithTag(1) as? UILabel {
			label.text = children[indexPath.row].value
		}
        return cell
    }

}
