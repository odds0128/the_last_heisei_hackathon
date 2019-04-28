//
//  playerAreaCustomView.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/27.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class HSPlayerAreaCustomView: UIView {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var smallRouletteImageView: UIImageView!
    @IBOutlet weak var shopBtn: UIButton!
    
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    
    var delegate: PlayerAreaDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        viewWidth = frame.width
        viewHeight = frame.height
        setPlaeyerArea()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib(){
        let view1 = Bundle.main.loadNibNamed("HSPlayerAreaCustomView", owner: self, options: nil)?.first as! UIView
        view1.frame = self.bounds
        self.addSubview(view1)
    }
    
    private func setPlaeyerArea() {
        
        smallRouletteImageView.contentMode = .scaleAspectFit
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        moneyLabel.layer.cornerRadius = 10
        moneyLabel.adjustsFontSizeToFitWidth = true
        moneyLabel.minimumScaleFactor = 0.3
        playerNameLabel.adjustsFontSizeToFitWidth = true
        playerNameLabel.minimumScaleFactor = 0.3
        
        shopBtn.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction func shopBtnTapped(_ sender: Any) {
        print("shop tapped")
    }
    
    @IBAction func rouletteBtnTapped(_ sender: Any) {
        delegate?.generateRoulette()
    }
    
    

}
