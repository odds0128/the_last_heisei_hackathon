//
//  ActionAlertViewController.swift
//  Heisei_Jinsei_Game
//
//  Created by 伊藤凌也 on 2019/04/26.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class ActionAlertViewController: UIViewController {
    
    private let actionLabelViewHeight: CGFloat = 80
    private let innerActionLabelViewHeight: CGFloat = 66

    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var actionLabelView: UIView!
    @IBOutlet weak var innerActionLabelView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    /// ビューのセットアップ
    private func setupView() {
        //  アクション発生を知らせるたラベルのセットアップ
        actionLabelView.layer.cornerRadius = actionLabelViewHeight / 2
        actionLabelView.clipsToBounds = true
        innerActionLabelView.layer.cornerRadius = innerActionLabelViewHeight / 2
        innerActionLabelView.clipsToBounds = true
        
        // アクション情報ビューのセットアップ
        infoView.layer.cornerRadius = 20
        infoView.clipsToBounds = true
        
        // OKボタンのセットアップ
        okButton.layer.cornerRadius = 20
        okButton.clipsToBounds = true
    }
    
    /// OKボタンがタップされた時の処理(Touch up inside)
    ///
    /// - Parameter sender: 押されたボタン
    @IBAction func okButtonDidTapped(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
