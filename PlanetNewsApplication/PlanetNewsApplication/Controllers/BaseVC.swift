//
//  ViewController.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 21.10.2021.
//

import UIKit

class BaseVC : UIViewController {

    lazy var contentBox : UIView = {
        let yOffSet = self.view.bounds.height * 0.25
        let view = UIView(frame: CGRect(x: 0, y: yOffSet, width: self.view.bounds.width, height: self.view.bounds.height * 0.75))
        return view
    }()
    
    lazy var mainLabel: UILabel = {
        let yOffSet = 83
        let label = UILabel()
        label.frame = CGRect(x: 27, y: yOffSet, width: 280, height: 90)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.textColor = .white
        label.font = UIFont(name: FontNameDefaults.encodeSansBold, size: 36)
        return label
    }()
    
    lazy var joinLabel:UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 27, y: 62, width: 160, height: 21)
        label.textColor = FontColors.baseGrayColor
        label.font = UIFont(name: FontNameDefaults.robotoRegular, size: 18)
        return label
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImage(named: "planet_logo")
        let view = UIImageView(image:image)
        view.frame = CGRect(x: self.mainLabel.bounds.maxX + 32, y: 51, width: 32, height: 32)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackgroundColors.baseScreenDarkGray
        addContentBox()
        self.view.addSubview(self.mainLabel)
        self.view.addSubview(joinLabel)
        self.view.addSubview(logoImage)
    }

    private func addContentBox(){
        self.view.addSubview(self.contentBox)
        self.contentBox.backgroundColor = .clear
        self.contentBox.layer.cornerRadius = 30
        self.contentBox.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner]
        // draw shadow
        let shadow = CALayer()
        shadow.frame = self.contentBox.bounds
        shadow.shadowColor = ShadowColors.baseContentShadow.cgColor
        shadow.shadowPath = UIBezierPath(roundedRect: self.contentBox.bounds, cornerRadius: 30).cgPath
        shadow.shadowOpacity = 1
        shadow.shadowRadius = 13
        shadow.shadowOffset = CGSize(width: 0, height: -4)
        shadow.zPosition = -10
        shadow.cornerRadius = self.contentBox.layer.cornerRadius
        shadow.maskedCorners = self.contentBox.layer.maskedCorners
        
        // draw background
        
        let bgLayer = CALayer()
        bgLayer.frame = self.contentBox.bounds
        bgLayer.backgroundColor = BackgroundColors.baseContentDarkGray.cgColor
        bgLayer.zPosition = -9
        bgLayer.cornerRadius = self.contentBox.layer.cornerRadius
        bgLayer.maskedCorners = self.contentBox.layer.maskedCorners
        
        self.contentBox.layer.addSublayer(shadow)
        self.contentBox.layer.addSublayer(bgLayer)
    }

    
}

