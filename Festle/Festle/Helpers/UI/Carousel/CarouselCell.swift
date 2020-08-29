//
//  CarouselCell.swift
//  Festle
//
//  Created by Евгений Уланов on 19.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

final class CarouselCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tourImage: UIImageView!
    @IBOutlet weak var tourName: UILabel!
    override func awakeFromNib() {
          super.awakeFromNib()
          configureAppearance()
      }

      // MARK: - Configuration

      func configure(title: String, image: UIImage?) {
          tourName.text = title
          tourImage.image = image
          tourImage.layer.cornerRadius = 10
        
      }

      // MARK: - Private Configuration

      private func configureAppearance() {
          containerView.layer.cornerRadius = 10
          containerView.layer.masksToBounds = true
      }
}
