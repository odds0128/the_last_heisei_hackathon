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
    @IBOutlet weak var rouletteBtn: UIButton!
    @IBOutlet weak var shopBtn: UIButton!
    
    private var playerName: String!
    private var money: Int!
    
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    
    let image = UIImage(named: "roulette_button.png")
 
    var delegate: PlayerAreaDelegate?
    
    init(frame: CGRect, name: String, money: Int) {
        super.init(frame: frame)
        loadNib()
        
        viewWidth = frame.width
        viewHeight = frame.height
        
        self.playerName = name
        self.money = money
        
        setPlaeyerArea()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func setMoney(_ money:Int){
        self.money = money
        moneyLabel.text = "¥\(money)"
    }
    
    func loadNib(){
        let view1 = Bundle.main.loadNibNamed("HSPlayerAreaCustomView", owner: self, options: nil)?.first as! UIView
        view1.frame = self.bounds
        self.addSubview(view1)
    }
    
    func setPlaeyerArea() {
        
        self.playerNameLabel.text = playerName
        smallRouletteImageView.contentMode = .scaleAspectFit
        moneyLabel.text = "¥\(self.money!)"
        moneyLabel.layer.cornerRadius = 10
        moneyLabel.adjustsFontSizeToFitWidth = true
        moneyLabel.minimumScaleFactor = 0.3
        playerNameLabel.adjustsFontSizeToFitWidth = true
        playerNameLabel.minimumScaleFactor = 0.3
        shopBtn.imageView?.contentMode = .scaleAspectFit
    }
    
//    func reloadMoneyLabel() {
//        self.moneyLabel.text = self.
//    }
    
    @IBAction func shopBtnTapped(_ sender: Any) {
        print("shop tapped")
        delegate?.generateItemView()
    }
    
    @IBAction func rouletteBtnTapped(_ sender: Any) {
        delegate?.generateRoulette()
    }
    
    ///ルーレットボタンを黒くして使用できなくする
    func disableRouletteBtn() {
        rouletteBtn.isEnabled = false
        let blackImage = darken(image: image!, level: 0.5)
        smallRouletteImageView.image = blackImage
    }
    
    //ルーレットボタンを使用可能にする
    func enableRouletteBtn() {
        rouletteBtn.isEnabled = true
        smallRouletteImageView.image = image
    }
    
    func darken(image:UIImage, level:CGFloat) -> UIImage{
        
        let frame = CGRect(origin:CGPoint(x:smallRouletteImageView.bounds.minX,y:smallRouletteImageView.bounds.minY),size:image.size)
        let tempView = UIView(frame:frame)
        tempView.backgroundColor = UIColor.black
        tempView.alpha = level
        
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        image.draw(in: frame)
        
        context!.translateBy(x: 0, y: frame.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        context!.clip(to: frame, mask: image.cgImage!)
        tempView.layer.render(in: context!)
        
        let imageRef = context!.makeImage()
        let toReturn = UIImage(cgImage:imageRef!)
        UIGraphicsEndImageContext()
        return toReturn
    }

}
