//
//  TargetProxy.swift
//  ABLoadingView
//
//  Created by Ali Can Batur on 30/12/2017.
//

import Foundation

class TargetProxy {
    private weak var target: (UIView & ABLoadingViewProtocol)?
    
    init(target: (UIView & ABLoadingViewProtocol)?) {
        self.target = target
    }
    
    @objc func step(displaylink: CADisplayLink) {
        self.target?.step(displaylink: displaylink)
    }
}
