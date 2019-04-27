//
//  Car.swift
//  Heisei_Jinsei_Game
//
//  Created by 伊藤凌也 on 2019/04/25.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

enum CarImage {
    case red
    case blue
    case green
    case orange
    case yellow
    
    /// 車の画像を取得する
    ///
    /// - Returns: 車の画像
    func image() -> UIImage {
        let defaultImage: UIImage = UIImage(named: "car-red")!
        var imageName = ""
        
        switch self {
        case .red:
            imageName = "car-red"
        case .blue:
            imageName = "car-blue"
        case .green:
            imageName = "car-green"
        case .orange:
            imageName = "car-orange"
        case .yellow:
            imageName = "car-yellow"
        }
        guard let image = UIImage(named: imageName) else {
            print("use default")
            return defaultImage
            
        }
        return image
    }
    
    /// 車の画像のイメージビューを取得する
    ///
    /// - Returns: イメージビュー
    func imageView() -> UIImageView {
        return UIImageView(image: image())
    }
}

/// プレイヤーの車ビュークラス
class Car: UIView {
    
    @IBOutlet weak var carImageView: UIImageView!
    
    var carImage: CarImage = .red
    var currentPosition: Int = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, carImage: CarImage) {
        self.init(frame: frame)
        self.carImage = carImage
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadNib() {
        guard let view = Bundle(for: type(of: self)).loadNibNamed("Car", owner: self, options: nil)?.first as? UIView else { return }
        view.frame = bounds
        let v = view as! Car
        v.carImageView.image = carImage.image()
        self.addSubview(v)
    }
    
    /// 指定した座標に移動します.
    ///
    /// - Parameter toPosition: 移動先の座標
    func moveTo(positions toPositions: [CGPoint], moveCount: Int, completion: ((Bool) -> Void)?) {
        print(toPositions)
        self.currentPosition += moveCount
        let blocks = toPositions.map { (point) -> () -> Void in
            return { [weak self] in
                self?.frame.origin = point
            }
        }
        UIView.animate(eachBlockDuration: 1, animationBlocks: blocks, completion: completion)
        
    }
}
