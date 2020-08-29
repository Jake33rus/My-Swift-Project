//
//  CollectionViewDataSource.swift
//  Festle
//
//  Created by Евгений Уланов on 19.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

final class CollectionViewDataSource<Cell: UICollectionViewCell, Model>: NSObject, UICollectionViewDataSource {

    // MARK: - Nested Types

    typealias CellConfigurator = (Model, Cell) -> Void

    // MARK: - Pirivate Properties

    private var data: [Model]
    private var cellClass: Cell.Type
    private var cellConfigurator: CellConfigurator

    // MARK: - Initialization

    init(data: [Model], cellClass: Cell.Type, cellConfigurator: @escaping CellConfigurator) {
        self.data = data
        self.cellClass = cellClass
        self.cellConfigurator = cellConfigurator
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass, for: indexPath)
        let model = data[indexPath.item]
        cellConfigurator(model, cell)
        return cell
    }

}
