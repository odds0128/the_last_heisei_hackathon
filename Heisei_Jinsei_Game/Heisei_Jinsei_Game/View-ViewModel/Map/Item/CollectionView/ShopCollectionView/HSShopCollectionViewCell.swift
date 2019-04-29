//
//  ShopCollectionViewCell.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/29.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class HSShopCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var shopItemImageView: UIImageView!
    @IBOutlet weak var shopItemNameLabel: UILabel!
    @IBOutlet weak var shopItemPriceLabel: UILabel!
    @IBOutlet weak var shopButton: UIButton!
    
    func setupCell() {
        if let view = Bundle.main.loadNibNamed("HSShopCollectionViewCell", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
