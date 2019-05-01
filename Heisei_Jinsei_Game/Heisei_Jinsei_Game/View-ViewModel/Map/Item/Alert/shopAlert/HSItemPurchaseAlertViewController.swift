//
//  HSItemPurchaseAlertViewController.swift
//  Heisei_Jinsei_Game
//
//  Created by 伊藤凌也 on 2019/04/30.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class HSItemPurchaseAlertViewController: UIViewController {
    
    private var price: Int = 0 {
        didSet {
            price = max(price, 0)
        }
    }
    private let item: HSItem
    private var purchaseCount = 0 {
        didSet {
            purchaseCount = max(purchaseCount, 0)
        }
    }

    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var sumPrice: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    
    init(item: HSItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.titleLabel.text = "\"\(item.name)\"を一つ￥\(item.price)で購入しますか？"
        self.itemImage.image = UIImage(named: item.imageName)
        self.countLabel.text = "\(purchaseCount)"
        self.sumPrice.text = "￥\(price)"
    }
    
    @IBAction func decreaseCount(_ sender: Any) {
        purchaseCount -= 1
        self.countLabel.text = "\(purchaseCount)"
        price = purchaseCount * item.price
        self.sumPrice.text = "￥\(price)"
    }
    
    @IBAction func increaseCount(_ sender: Any) {
        purchaseCount += 1
        self.countLabel.text = "\(purchaseCount)"
        price = purchaseCount * item.price
        self.sumPrice.text = "￥\(price)"
    }
    
    
    private func setupView() {
        modalView.layer.cornerRadius = 20
        modalView.clipsToBounds = true
        purchaseButton.layer.cornerRadius = 15
        purchaseButton.clipsToBounds = true
        decreaseButton.layer.cornerRadius = 5
        decreaseButton.clipsToBounds = true
        increaseButton.layer.cornerRadius = 5
        increaseButton.clipsToBounds = true
    }
}
