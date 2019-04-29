//
//  ActionAlertViewController.swift
//  Heisei_Jinsei_Game
//
//  Created by 伊藤凌也 on 2019/04/26.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

protocol ActionAlertViewControllerBinder:class {
    func endActionAlertView()
}

class ActionAlertViewController: UIViewController {
    
    private let actionLabelViewHeight: CGFloat = 80
    private let innerActionLabelViewHeight: CGFloat = 66
    private let action: HSEraEventAction
    private weak var binder:ActionAlertViewControllerBinder!

    @IBOutlet weak private var actionLabel: UILabel!
    @IBOutlet weak private var actionLabelView: UIView!
    @IBOutlet weak private var innerActionLabelView: UIView!
    @IBOutlet weak private var infoView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var detailLabel: UILabel!
    @IBOutlet weak private var okButton: UIButton!
    
    init(binder:ActionAlertViewControllerBinder,action: HSEraEventAction) {
        self.binder = binder
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.titleLabel.text = action.title
        self.detailLabel.text = action.description
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
    @IBAction private func okButtonDidTapped(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        binder.endActionAlertView()
    }
}
