//
//  ItemCustomView.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/28.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class HSItemCustomView: UIView {
    
    @IBOutlet weak var playersItemLabel: UILabel!
    @IBOutlet weak var itemScrollView: UIScrollView!
    @IBOutlet weak var shopScrollView: UIScrollView!
    
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    
    init(frame: CGRect, name: String) {
        super.init(frame: frame)
        loadNib()
        
        viewWidth = frame.width
        viewHeight = frame.height
        playersItemLabel.text = "\(name)のアイテム"
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
    
    private func setItemView() {
        
    }
}
