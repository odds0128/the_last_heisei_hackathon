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
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    
    @IBOutlet var title: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var comment: UILabel!
    @IBOutlet var completionBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        viewWidth = frame.width
        viewHeight = frame.height
        drawView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
//    func loadNib(){
//        let view = Bundle.main.loadNibNamed("HSBalloonCustomView.xib", owner: self, options: nil)?.first as! UIView
//        view.frame = self.bounds
//        self.addSubview(view)
//    }
    
    private func drawView() {
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        HSShadow.init(layer: view.layer, offset: CGSize.zero, opacity: 0.5, radius: 10)
        addSubview(view)
        
        setTitle()
        setImageView()
        setComment()
        setCompletionBtn()
    }
    
    private func setTitle() {
        if title != nil {
            print(title)
        } else {
            print("nil")
        }
        title.text = "元号発表"
        title.layer.cornerRadius = 30
        title.clipsToBounds = true
    }
    
    private func setImageView() {
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = HSColor().grayColor.cgColor
        imageView.layer.borderWidth = 10
        let image = UIImage(named: "keizo.png")
        imageView.clipsToBounds = true
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        
    }
    
    private func setComment() {
        comment.text = "小渕恵三官房長官が記者会見室で、\n平成と書かれた生乾きの\n2文字を掲げた。"
    }
    
    private func setCompletionBtn() {
        completionBtn.layer.cornerRadius = 20
    }
    @IBAction func completionBtnTapped(_ sender: Any) {
        print("OKボタンがタップされた")
    }
    
    
}
