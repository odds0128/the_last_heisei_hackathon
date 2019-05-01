//
//  ItemCustomView.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/28.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class HSItemCustomView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var playersItemLabel: UILabel!
    @IBOutlet weak var itemScrollView: UIScrollView!
    @IBOutlet weak var shopScrollView: UIScrollView!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var shopCollectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIButton!
    
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    
    private var itemAlertView: HSItemAlert!
    
    var delegate: ItemAlertDelegate!
    
    var items: [HSItemStack]!
    var shopItems: [HSItem]
    
    var selectedRow: Int!
    
    init(frame: CGRect, name: String, items: [HSItemStack], shopItems: [HSItem]) {
        self.shopItems = shopItems
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
        self.shopItems = [] // TODO: Storyboardでの遷移時でもアイテムを渡せるようにする
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
    
    ///アイテムCollectionViewのサイズ設定など
    private func setupItemCollectionView() {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        itemCollectionView.register(UINib(nibName: "HSItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HSItemCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        itemCollectionView.collectionViewLayout = layout
    }
    
    ///ショップCollectionViewのサイズ設定など
    private func setupShopCollectionView() {
        shopCollectionView.delegate = self
        shopCollectionView.dataSource = self
        
        shopCollectionView.register(UINib(nibName: "HSShopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HSShopCollectionViewCell")
        
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
            return shopItems.count
        }
    }
    ///CollectionViewの内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        ///itemCollectionViewの場合
        if (collectionView == itemCollectionView) {
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HSItemCollectionViewCell", for: indexPath) as! HSItemCollectionViewCell
            cell = setupItemCollectionViewCell(cell: cell, indexPath: indexPath)
            return cell
        ///shopCollectionViewの場合
        } else {
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HSShopCollectionViewCell", for: indexPath) as! HSShopCollectionViewCell
            cell = setupShopCollectionViewCell(cell: cell, indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case shopCollectionView:
            delegate.showPurchaseAlert(item: shopItems[indexPath.row])
        case itemCollectionView:
            delegate.generateItemAlert(row: indexPath.row)
        default:
            break
        }
    }
    
    ///アイテムのセルを設定
    private func setupItemCollectionViewCell(cell: HSItemCollectionViewCell, indexPath: IndexPath) -> HSItemCollectionViewCell {
        cell.layer.cornerRadius = 10
        cell.itemNameLabel.text = items![indexPath.row].item.name
        cell.itemNameLabel.adjustsFontSizeToFitWidth = true
        cell.itemNameLabel.sizeToFit()
        cell.itemImageView.image = UIImage(named: items![indexPath.row].item.imageName)
        cell.itemNumLabel.text = "x\(items![indexPath.row].count)"
        cell.itemNumLabel.adjustsFontSizeToFitWidth = true
        cell.itemNumLabel.sizeToFit()
        return cell
    }
    
    
    ///ショップのセルを設定
    private func setupShopCollectionViewCell(cell: HSShopCollectionViewCell, indexPath: IndexPath) -> HSShopCollectionViewCell {
        let item = shopItems[indexPath.item]
        
        cell.layer.cornerRadius = 10
        cell.shopItemNameLabel.text = item.name
        cell.shopItemNameLabel.adjustsFontSizeToFitWidth = true
        cell.shopItemNameLabel.sizeToFit()
        cell.shopItemPriceLabel.text = "¥\(item.price)"
        cell.shopItemPriceLabel.adjustsFontSizeToFitWidth = true
        cell.shopItemPriceLabel.sizeToFit()
        return cell
    }
    
    @objc func itemBtnTapped(_ sender: UIButton) {
        
        delegate.generateItemAlert(row: sender.tag)
    }
    
    @objc func shopBtnTapped() {
        print("shopBtnTapped")
    }
   
}
