//
//  BubbleButton.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import UIKit
protocol BubbleButtonProtocol {
    var onTap: (() -> Void)? { get set }
}
class BubbleButton: UIButton, BubbleButtonProtocol {
    var onTap: (() -> Void)?
    var isDragging = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        backgroundColor = UIColor.Pallete.green
        clipsToBounds = true
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func commonInit() {
        addTarget(self, action: #selector(dragged(_:for:)), for: .touchDragInside)
        addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        addTarget(self, action: #selector(dragEnded(_:)), for: [.touchUpInside, .touchUpOutside])
    }
    @objc private func dragged(_ sender: UIButton, for event: UIEvent) {
        guard let touch = event.allTouches?.first else { return }
        let currentLocation = touch.location(in: self.superview)
        let previousLocation = touch.previousLocation(in: self.superview)
        
        let dx = currentLocation.x - previousLocation.x
        let dy = currentLocation.y - previousLocation.y
        
        let newX = self.center.x + dx
        let newY = self.center.y + dy
        
        let minX = self.bounds.size.width / 2.0
        let maxX = UIScreen.main.bounds.size.width - self.bounds.size.width / 2.0
        let minY = self.superview?.safeAreaInsets.top ?? 0
        let maxY = UIScreen.main.bounds.size.height - self.bounds.size.height / 2.0 - (self.superview?.safeAreaInsets.bottom ?? 0.0)
        
        let clampedX = min(maxX, max(minX, newX))
        let clampedY = min(maxY, max(minY, newY))
        
        self.center = CGPoint(x: CGFloat(clampedX), y: CGFloat(clampedY))
        isDragging = true
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        })
    }
    @objc func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        })
    }
    override var frame: CGRect {
        didSet {
            if frame.width > 0 {
                layer.cornerRadius = frame.width / 2
            }
        }
    }
    @objc private func dragEnded(_ sender: UIButton) {
        if !isDragging {
            onTap?()
        }
        isDragging = false
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
