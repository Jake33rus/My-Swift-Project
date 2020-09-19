//
//  UICollectionView.swift
//  Festle
//
//  Created by Евгений Уланов on 19.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

extension UICollectionView {

    func register(_ cellClasses: UICollectionViewCell.Type...) {
        cellClasses.forEach { cellClass in
            register(UINib(nibName: cellClass.nib, bundle: nil), forCellWithReuseIdentifier: cellClass.identifier)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellClass.identifier, for: indexPath) as? T else {
            fatalError("Can't dequeue cell with identifier \(cellClass.identifier)")
        }
        return cell
    }

    func showNullIndicator() {
        DispatchQueue.main.async {
            let view = UIView()
            view.center = self.center
            let label = UILabel()
            label.text = "No Stream online Now"
            label.numberOfLines = 0
            label.center = view.center
            label.textAlignment = .center
            label.sizeToFit()
            view.addSubview(label)
            self.backgroundView = view
        }
    }

    func hideNullIndicator() {
        DispatchQueue.main.async {
            self.backgroundView = nil
        }
    }
}
