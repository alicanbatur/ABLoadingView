//
//  File.swift
//  ABLoadingView
//
//  Created by Ali Can Batur on 29/12/2017.
//

import Foundation

public struct ABLoadingViewConfiguration {
    var progress: CGFloat = 0
    var widthRatio: CGFloat = 0.1
    var speed: CGFloat = 0.005
    
    var radius: CGFloat = 0
    var lineWidth: CGFloat = 3
    var lineColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    var fillColor: UIColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 0)
}

public protocol Configuration: class {
    var configuration: ABLoadingViewConfiguration { get set }
}

public protocol ABLoadingViewProtocol: Configuration {
    var shapeLayer1: CAShapeLayer! { get set }
    var shapeLayer2: CAShapeLayer! { get set }
}

extension ABLoadingViewProtocol where Self: UIView {
    
    var progress: CGFloat {
        get { return configuration.progress }
        set { configuration.progress = newValue }
    }
    
    var widthRatio: CGFloat {
        get { return configuration.widthRatio }
        set { configuration.widthRatio = newValue }
    }
    
    var speed: CGFloat {
        get { return configuration.speed }
        set { configuration.speed = newValue }
    }
    
    /*
     * If this was not overriden, then view take layer.cornerRadius as default value.
     */
    var radius: CGFloat {
        get { return configuration.radius == 0 ? layer.cornerRadius : configuration.radius }
        set { configuration.radius = newValue }
    }
    
    var lineWidth: CGFloat {
        get { return configuration.lineWidth }
        set { configuration.lineWidth = newValue }
    }
    
    var lineColor: UIColor {
        get { return configuration.lineColor }
        set { configuration.lineColor = newValue }
    }
    
    var fillColor: UIColor {
        get { return configuration.fillColor }
        set { configuration.fillColor = newValue }
    }
    
    func createAnimation() {
        shapeLayer1 = createShapeLayer()
        shapeLayer2 = createShapeLayer()
        createDisplayLink()
    }
    
    func createDisplayLink() {
        let displayLink = CADisplayLink(target: TargetProxy(target: self), selector: #selector(TargetProxy.step(displaylink:)))
        displayLink.add(to: .current, forMode: .defaultRunLoopMode)
    }
    
    func createShapeLayer() -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.actions = ["strokeStart" : NSNull(), "strokeEnd" : NSNull()]
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapRound
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0
        
        layer.addSublayer(shapeLayer)
        return shapeLayer
    }
    
    public func step(displaylink: CADisplayLink) {
        if (1 - progress >= widthRatio) {
            shapeLayer1.strokeStart = progress
            shapeLayer1.strokeEnd = progress + widthRatio
            
            shapeLayer2.strokeStart = 0
            shapeLayer2.strokeEnd = 0
        } else {
            let ratio1 = 1 - progress
            let ratio2 = widthRatio - ratio1
            
            shapeLayer1.strokeStart = progress
            shapeLayer1.strokeEnd = 1
            
            shapeLayer2.strokeStart = 0
            shapeLayer2.strokeEnd = ratio2
        }
        
        progress += speed
        if (progress > 1) {
            progress = 0
        }
        
        setNeedsDisplay()
    }
    
}
