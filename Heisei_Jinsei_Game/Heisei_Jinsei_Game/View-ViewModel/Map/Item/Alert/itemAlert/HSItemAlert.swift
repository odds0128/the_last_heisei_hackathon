//
//  HSItemAlert.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/29.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class HSItemAlert: UIView {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemCancelBtn: UIButton!
    @IBOutlet weak var itemOKBtn: UIButton!
    
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        
        viewWidth = frame.width
        viewHeight = frame.height
        setupItemAlert()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib(){
        let view1 = Bundle.main.loadNibNamed("HSItemAlert", owner: self, options: nil)?.first as! UIView
        view1.frame = self.bounds
        self.addSubview(view1)
    }
    
    private func setupItemAlert() {
        
        itemOKBtn.addTarget(self, action: #selector(itemOKBtnTapped), for: .touchUpInside)
        itemCancelBtn.addTarget(self, action: #selector(itemCancelBtnTapped), for: .touchUpInside)
    }
    
    @objc func itemOKBtnTapped() {
        print("OK")
    }
    
    @objc func itemCancelBtnTapped() {
        print("cancel")
    }
}
