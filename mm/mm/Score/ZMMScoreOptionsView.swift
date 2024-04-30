//
//  ZMMScoreOptionsView.swift
//  mm
//
//  Created by zhuyn on 2024/3/1.
//

import UIKit

// https://www.cnblogs.com/chglog/p/4837070.html
class ZMMScoreOptionsView: UIView {

    var animator: UIDynamicAnimator!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        animator = UIDynamicAnimator.init(referenceView: self)
        
        configSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configSubViews() {
        
    }
}
