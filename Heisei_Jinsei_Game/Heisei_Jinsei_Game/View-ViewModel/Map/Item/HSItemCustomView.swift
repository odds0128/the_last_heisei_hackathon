//
//  ItemCustomView.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/28.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class HSItemCustomView: UIView, UICollectionViewDataSource {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var playersItemLabel: UILabel!
    @IBOutlet weak var itemScrollView: UIScrollView!
    @IBOutlet weak var shopScrollView: UIScrollView!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var shopCollectionView: UICollectionView!
    
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    
    private var itemAlertView: HSItemAlert!
    
    var delegate: ItemAlertDelegate!
    
    var items: [HSItemStack]!
    
    init(frame: CGRect, name: String, items: [HSItemStack]) {
        super.init(frame: frame)
        loadNib()
        
        self.items = items
        view.layer.cornerRadius = 30
        viewWidth = frame.width
        viewHeight = frame.height
        playersItemLabel.text = "\(name)のアイテム"
        
        setupItemCollectionView()
        setupShopCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib(){
        let view1 = Bundle.main.loadNibNamed("HSItemCustomView", owner: self, options: nil)?.first as! UIView
        view1.frame = self.bounds
        self.addSubview(view1)
    }
    
}

//MARK: - CollectionViewの設定
extension HSItemCustomView {
    
    private func setupItemCollectionView() {
        itemCollectionView.dataSource = self
        
        itemCollectionView.register(UINib(nibName: "HSItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HSItemCollectionViewCell")
        
        /// セルの大きさを設定
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        itemCollectionView.collectionViewLayout = layout
    }
    
    private func setupShopCollectionView() {
        shopCollectionView.dataSource = self
        
        shopCollectionView.register(UINib(nibName: "HSShopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HSShopCollectionViewCell")
        
        /// セルの大きさを設定
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        shopCollectionView.collectionViewLayout = layout
    }
    
    ///CollectionViewの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == itemCollectionView) {
            return items.count
        } else {
            return 5
        }
    }
    ///CollectionViewの内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        ///itemCollectionViewの場合
        if (collectionView == itemCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HSItemCollectionViewCell", for: indexPath) as! HSItemCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.itemNameLabel.text = items![indexPath.row].item.name
            cell.itemNameLabel.adjustsFontSizeToFitWidth = true
            cell.itemNameLabel.sizeToFit()
            cell.itemImageView.image = UIImage(named: items![indexPath.row].item.imageName)
            
            cell.itemNumLabel.text = "x\(items![indexPath.row].count)"
            cell.itemNumLabel.adjustsFontSizeToFitWidth = true
            cell.itemNumLabel.sizeToFit()
            cell.itemButton.addTarget(self, action: #selector(itemBtnTapped), for: .touchUpInside)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HSShopCollectionViewCell", for: indexPath) as! HSShopCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.shopItemNameLabel.text = "ガラケー"
            cell.shopItemNameLabel.adjustsFontSizeToFitWidth = true
            cell.shopItemNameLabel.sizeToFit()
            cell.shopItemPriceLabel.text = "¥15000"
            cell.shopItemPriceLabel.adjustsFontSizeToFitWidth = true
            cell.shopItemPriceLabel.sizeToFit()
            cell.shopButton.addTarget(self, action: #selector(shopBtnTapped), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func itemBtnTapped() {
        delegate.generateItemAlert()
    }
    
    @objc func shopBtnTapped() {
        print("shopBtnTapped")
    }
   
}
