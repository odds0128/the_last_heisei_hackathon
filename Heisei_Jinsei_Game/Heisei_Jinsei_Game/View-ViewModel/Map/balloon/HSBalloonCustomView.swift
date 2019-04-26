//
//  HSBalloonCustomView.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/26.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation
import UIKit

class HSBalloonCustomView: UIView {
    
    private var view: UIView!
    private var title: UILabel!
    private var imageView: UIImageView!
    private var comment: UILabel!
    private var completionBtn: UIButton!
    
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewWidth = frame.width
        viewHeight = frame.height
        drawView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func drawView() {
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        HSShadow.init(layer: view.layer, offset: CGSize.zero, opacity: 0.5, radius: 10)
        addSubview(view)
        
        drawTitle()
        drawImageView()
        drawComment()
        drawCompletionBtn()
    }
    
    private func drawTitle() {
        title = UILabel(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight/9))
        title.textAlignment = NSTextAlignment.center
        title.text = "元号発表"
        title.layer.cornerRadius = 30
        title.clipsToBounds = true
        
        title.font = UIFont(name: HSFont().boldFont, size: 30)
        title.textColor = .black
        view.addSubview(title)
    }
    
    private func drawImageView() {
        imageView = UIImageView(frame: CGRect(x: (viewWidth/2) - ((viewWidth/1.1)/2), y: viewHeight/9, width: viewWidth/1.1, height: viewHeight/1.8))
        imageView.backgroundColor = .yellow
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = HSColor().grayColor.cgColor
        imageView.layer.borderWidth = 10
        let image = UIImage(named: "keizo.png")
        imageView.clipsToBounds = true
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
    }
    
    private func drawComment() {
        comment = UILabel(frame: CGRect(x: (viewWidth/2) - ((viewWidth/1.1)/2), y: viewHeight/1.5, width: viewWidth, height: viewHeight/5))
        comment.text = "小渕恵三官房長官が記者会見室で、\n平成と書かれた生乾きの\n2文字を掲げた。"
        comment.numberOfLines = 3
        comment.font = UIFont(name: HSFont().boldFont, size: 20)
        view.addSubview(comment)
    }
    
    private func drawCompletionBtn() {
        
    }
}
