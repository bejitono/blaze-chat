//
//  LoadingView.swift
//  BlazeChat
//
//  Created by Stefano on 16.01.21.
//

import UIKit

final class LoadingAnimationView: UIView {
    
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        let diameter = min(bounds.width, bounds.height)
        let path = UIBezierPath(ovalIn:
            CGRect(x: 0, y: 0, width: diameter, height: diameter)
        )
        shapeLayer.path = path.cgPath
    }
    
    func start() {
        animateStroke()
        animateRotation()
    }
    
    func end() {
        shapeLayer.removeFromSuperlayer()
        layer.removeAllAnimations()
    }
}

// MARK: - View Animation

private extension LoadingAnimationView {
    
    func animateRotation() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.fromValue = CGFloat.fromValue
        animation.toValue = CGFloat.pi * 2
        animation.duration = .duration
        animation.repeatCount = .greatestFiniteMagnitude
    }
    
    func animateStroke() {
        let startAnimation = makeStrokeAnimation(
            beginTime: .startAnimationBeginTime,
            fromValue: .fromValue,
            toValue: .toValue,
            duration: .strokeAnimationDuration
        )
        let endAnimation = makeStrokeAnimation(
            isStartAnimation: false,
            beginTime: 0.0,
            fromValue: .fromValue,
            toValue: .toValue,
            duration: .strokeAnimationDuration
        )
        let animationGroup = makeAnimationGroup(start: startAnimation, end: endAnimation)
        let colorAnimation = makeColorAnimation(in: animationGroup)
        
        shapeLayer.add(animationGroup, forKey: nil)
        shapeLayer.add(colorAnimation, forKey: nil)
        layer.addSublayer(shapeLayer)
    }
    
    func makeStrokeAnimation(
        isStartAnimation: Bool = true,
        beginTime: Double = 0.0,
        fromValue: CGFloat,
        toValue: CGFloat,
        duration: Double
    ) -> CABasicAnimation {
        let animation = CABasicAnimation()
        animation.keyPath = isStartAnimation ? "strokeStart" : "strokeEnd"
        animation.beginTime = beginTime
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.timingFunction = .init(name: .easeInEaseOut)
        return animation
    }
    
    func makeColorAnimation(in group: CAAnimationGroup) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "strokeColor"
//        animation.values = [Theme.color.primary.cgColor, Theme.color.lightPrimary.cgColor]
        animation.values = [Theme.color.primary.cgColor, Theme.color.lightPrimary.cgColor]
        animation.duration = .groupAnimationBeginTime
        animation.repeatCount = .greatestFiniteMagnitude
        animation.timingFunction = .init(name: .easeInEaseOut)
        return animation
    }
    
    func makeAnimationGroup(start: CABasicAnimation, end: CABasicAnimation) -> CAAnimationGroup {
        let group = CAAnimationGroup()
        group.duration = .groupAnimationBeginTime
        group.repeatDuration = .infinity
        group.animations = [start, end]
        return group
    }
}

// MARK: - View Setup

private extension LoadingAnimationView {
    
    func setupViews() {
        setupShapeLayer()
    }
    
    func setupShapeLayer() {
        shapeLayer.strokeColor = Theme.color.primary.cgColor
        shapeLayer.lineWidth = .lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
    }
}

// MARK: - View Constants

private extension CGFloat {
    static let lineWidth: CGFloat = 8
    static let fromValue: CGFloat = 0.0
    static let toValue: CGFloat = 1.0
}

private extension CFTimeInterval {
    static let duration: CFTimeInterval = 2
    static let strokeAnimationDuration: CFTimeInterval = 0.75
    static let startAnimationBeginTime: CFTimeInterval = 0.5
    static let groupAnimationBeginTime: CFTimeInterval = strokeAnimationDuration + startAnimationBeginTime
}
