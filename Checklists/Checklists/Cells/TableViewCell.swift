//
//  TableViewCell.swift
//  Checklists
//
//  Created by Евгений Уланов on 25.09.2020.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var exampleName: UILabel!
    var checkLists: [Checklist] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "collectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return checkLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionViewCell
        let checklist = checkLists[indexPath.row]
        cell.checkListName.text = checklist.name
        cell.checkListDesc.text = checklist.desc
        cell.checkListEmoji.image = checklist.icon
        return cell
    }
    
    
}
