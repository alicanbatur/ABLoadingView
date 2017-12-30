//
//  ABLoadingView.swift
//  ABLoadingView
//
//  Created by Ali Can Batur on 29/12/2017.
//

import Foundation

public class ABLoadingView: UIView, ABLoadingViewProtocol {
    
    // FIXME: Take these shapeLayers out of the class which implements ABLoadingViewProtocol
    
    public var shapeLayer1: CAShapeLayer!
    public var shapeLayer2: CAShapeLayer!
    
    public var configuration = ABLoadingViewConfiguration()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        createAnimation()
    }

}
