//
//  DashboardCarousel.swift
//  Festle
//
//  Created by Евгений Уланов on 19.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class DashboardCarousel: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cells = [CarouselTourModel]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CarouselCell.reuseId, for: indexPath)
        return cell
       }
}
