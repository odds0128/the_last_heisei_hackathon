//
//  AnimateEachBlock.swift
//  Heisei_Jinsei_Game
//
//  source:
//  https://qiita.com/lovee/items/460cbb02a345e0ff7910
//
//  Created by 伊藤凌也 on 2019/04/26.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

private extension ArraySlice {
    
    var startItem: Element {
        return self[self.startIndex]
    }
    
}

extension UIView {
    
    private typealias `Self` = UIView
    
    private static func animate(eachBlockDuration duration: TimeInterval, eachBlockDelay delay: TimeInterval, eachBlockOptions options: UIView.AnimationOptions, animationArraySlice: ArraySlice<() -> Void>, completion: ((_ finished: Bool) -> Void)?) {
        
        let animation = animationArraySlice.startItem
        
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: animation) { (finished) in
            
            let remainedAnimations = animationArraySlice.dropFirst()
            
            if remainedAnimations.isEmpty {
                completion?(finished)
                
            } else {
                Self.animate(eachBlockDuration: duration, eachBlockDelay: delay, eachBlockOptions: options, animationArraySlice: remainedAnimations, completion: completion)
            }
            
        }
        
    }
    
    public static func animate(eachBlockDuration duration: TimeInterval, eachBlockDelay delay: TimeInterval = 0, eachBlockOptions options: UIView.AnimationOptions = .curveEaseInOut, animationBlocks: [() -> Void], completion: ((_ finished: Bool) -> Void)? = nil) {
        
        let isFinished = animationBlocks.isEmpty
        
        guard isFinished == false else {
            completion?(isFinished)
            return
        }
        
        let animationArraySlice = ArraySlice(animationBlocks)
        
        Self.animate(eachBlockDuration: duration, eachBlockDelay: delay, eachBlockOptions: options, animationArraySlice: animationArraySlice, completion: completion)
        
    }
    
}

