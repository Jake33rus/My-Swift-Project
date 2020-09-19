//
//  CircleProgressView.swift
//  ONETRAK_iOS_Intern_TEST
//
//  Created by Евгений Уланов on 14.09.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class CircleProgressView: UIView {
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var infoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    
    func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                                           y: frame.size.height / 2.0),
                                        radius: 80,
                                        startAngle: -.pi / 2,
                                        endAngle: 3 * .pi / 2,
                                        clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 20.0
        circleLayer.strokeColor = UIColor.black.cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = #colorLiteral(red: 0, green: 0.693600595, blue: 0.9541637301, alpha: 1)
        infoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont(name: "Roboto", size: 72)
        infoLabel.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        infoLabel.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.addSubview(infoLabel)
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval, progress: Double) {
        infoLabel.text = "\(String(format:"%.1f", progress))%"
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = progress/100
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
