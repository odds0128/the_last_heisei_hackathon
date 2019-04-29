//
//  HSBalloonCustomView.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/26.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class HSBalloonCustomView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet var title: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var comment: UILabel!
    @IBOutlet var completionBtn: UIButton!
    
    weak var delegate: BalloonViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setView()
    }
    
    convenience init(frame: CGRect, event: HSEraEvent) {
        self.init(frame: frame)
        setView(event: event)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib(){
        let view1 = Bundle.main.loadNibNamed("HSBalloonCustomView", owner: self, options: nil)?.first as! UIView
        view1.frame = self.bounds
        self.addSubview(view1)
    }
    
    private func setView(event: HSEraEvent) {
        setView()
        title.text = event.title
        imageView.image = UIImage(named: event.imageName)
        comment.text = event.eventDescription
    }
    
    private func setView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        HSShadow.makeShadow(to: view.layer, offset: .zero, opacity: 0.5, radius: 10)
        
        title.text = "元号発表"
        title.layer.cornerRadius = 30
        title.clipsToBounds = true
        
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = HSColor().grayColor.cgColor
        imageView.layer.borderWidth = 10
        let image = UIImage(named: "keizo.png")
        imageView.clipsToBounds = true
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        
        comment.text = "小渕恵三官房長官が記者会見室で、\n平成と書かれた生乾きの\n2文字を掲げた。"
        comment.adjustsFontSizeToFitWidth = true
        comment.minimumScaleFactor = 0.3
        completionBtn.layer.cornerRadius = 20
    }
    
    @IBAction func completionBtnTapped(_ sender: Any) {
        self.view.fadeOut(duration: 0.3, completed: {
            self.delegate?.removeBalloonView()
        })
        
    }
    
    
    
}
