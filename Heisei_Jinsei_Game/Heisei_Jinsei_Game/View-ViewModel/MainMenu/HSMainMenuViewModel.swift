//
//  HSMainMenuViewModel.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

protocol HSMainMenuViewModelBinder:class {
    
}

class HSMainMenuViewModel<Binder:HSMainMenuViewModelBinder>{
    weak var binder:Binder!
    
    init(binder:Binder) {
        self.binder = binder
    }
}
