//
//  SpreadView.swift
//  UIPlayground
//
//  Created by 陈禹志 on 16/4/26.
//  Copyright © 2016年 com.insta. All rights reserved.
//

import UIKit

class SpreadView: UIView {
    
    var layers = 3
    var buttonWidth:CGFloat = 30
    
    lazy var addNodeButton: [AddButton] = {
        let view = AddButton()
        view.frame = CGRect(x: 50, y: 100, width: 30, height: 30)
        var views = [view]
        for i in 2...6 {
            let view = AddButton()
            view.frame = CGRect(x: i*50, y: 100, width: 30, height: 30)
            views.append(view)
        }
        return views
    }()
    
    lazy var subNodeButton: [AddButton] = {
        let view = AddButton()
        view.frame = CGRect(x: 50, y: 150, width: 30, height: 30)
        view.isAddButton = false
        var views = [view]
        for i in 2...6 {
            let view = AddButton()
            view.isAddButton = false
            view.frame = CGRect(x: i*50, y: 150, width: 30, height: 30)
            views.append(view)
        }
        return views
    }()
    
    // MARK: - SetData
    var setCircleData: (() -> Void)?
    var setExclusiveOrData: (() -> Void)?
    var setGaussianData: (() -> Void)?
    var setSpiralData: (() -> Void)?
    
    @IBOutlet weak var setCircleButton: SelectDataButton!
    @IBOutlet weak var setExclusiveOrButton: SelectDataButton!
    @IBOutlet weak var setGaussianButton: SelectDataButton!
    @IBOutlet weak var setSpiralButton: SelectDataButton!
    func resetAlpha(sender: SelectDataButton) {
        let setDataButtons = [setCircleButton,setExclusiveOrButton,setGaussianButton,setSpiralButton]
        for i in setDataButtons {
            if i == sender {
                i.isChosen = true
            }
            else {
                i.isChosen = false
            }
        }
    }
    
    @IBAction func setCircle(sender: SelectDataButton) {
        setCircleData?()
        resetAlpha(sender)
    }
    @IBAction func setExclusiveOr(sender: SelectDataButton) {
        setExclusiveOrData?()
        resetAlpha(sender)
    }
    @IBAction func setGaussian(sender: SelectDataButton) {
        setGaussianData?()
        resetAlpha(sender)
    }
    @IBAction func setSpiral(sender: SelectDataButton) {
        setSpiralData?()
        resetAlpha(sender)
    }
    
    // MARK: - UISlider
    @IBOutlet weak var ratioTrainingTest: UISlider!
    
    // MARK: - AddLayer
    var addLayer: (() -> Void)?
    
    func addLayerButtons(sender:AddButton) {
        if sender.isAddButton && layers < 8 {
            layers += 1
            addNodeButton[layers - 3].hidden = false
            subNodeButton[layers - 3].hidden = false
        }
        if !sender.isAddButton && layers > 2 {
            layers -= 1
            addNodeButton[layers - 2].hidden = true
            subNodeButton[layers - 2].hidden = true
        }
        print("\(layers)")
        addLayer?()
    }
    
    @IBOutlet weak var addLayerButtons: AddButton!
    @IBAction func addLayerButton(sender: AddButton) {
        addLayerButtons(sender)
    }
    @IBAction func subLayerButton(sender: AddButton) {
        addLayerButtons(sender)
    }

    // MARK: - DropDown
    @IBOutlet weak var learningRateButton: DropDownButton!
    var setLearningRate: ((num: Int) -> Void)?
    private lazy var learningRateDropView: DropDownView = {
        let view = DropDownView()
        view.labelName = ["0.00001","0.0001","0.001","0.003","0.01","0.03","0.1","0.3","1","3","10"]
        view.showSelectedLabel = {(name: String, num: Int) in
            self.learningRateButton.setTitle(name, forState: .Normal)
            view.hide()
            self.setLearningRate?(num: num)
        }
        view.labelIsSelected = 5
        return view
    }()
    
    @IBAction func learningRateDrop(sender: DropDownButton) {
        if let window = self.window {
            learningRateDropView.showInView(window,button: sender)
        }
    }
    
    
    @IBOutlet weak var activationButton: DropDownButton!
    var setActivation: ((num: Int) -> Void)?
    private lazy var activationDropView: DropDownView = {
        let view = DropDownView()
        view.labelName = ["ReLU","Tanh","Sigmoid","Linear"]
        view.showSelectedLabel = {(name: String, num: Int) in
            self.activationButton.setTitle(name, forState: .Normal)
            view.hide()
            self.setActivation?(num: num)
        }
        view.labelIsSelected = 1
        return view
    }()
    
    @IBAction func activationDrop(sender: DropDownButton) {
        if let window = self.window {
            activationDropView.showInView(window,button: sender)
        }
    }
    
    
    @IBOutlet weak var regularizationButton: DropDownButton!
    var setRegularization: ((num: Int) -> Void)?
    private lazy var regularizationDropView: DropDownView = {
        let view = DropDownView()
        view.labelName = ["None","L1","L2"]
        view.showSelectedLabel = {(name: String, num: Int) in
            self.regularizationButton.setTitle(name, forState: .Normal)
            view.hide()
            self.setRegularization?(num: num)
        }
        view.labelIsSelected = 0
        return view
    }()
    
    @IBAction func regularizationDrop(sender: DropDownButton) {
        if let window = self.window {
            regularizationDropView.showInView(window,button: sender)
        }
    }
    
    
    @IBOutlet weak var regularizationRateButton: DropDownButton!
    var setRegularizationRate: ((num: Int) -> Void)?
    private lazy var regularizationRateDropView: DropDownView = {
        let view = DropDownView()
        view.labelName = ["0","0.001","0.003","0.01","0.03","0.1","0.3","1","3","10"]
        view.showSelectedLabel = {(name: String, num: Int) in
            self.regularizationRateButton.setTitle(name, forState: .Normal)
            view.hide()
            self.setRegularizationRate?(num: num)
        }
        view.labelIsSelected = 0
        return view
    }()
    
    @IBAction func regularizationRateDrop(sender: DropDownButton) {
        if let window = self.window {
            regularizationRateDropView.showInView(window,button: sender)
        }
    }
    
    
    @IBOutlet weak var problemTypeButton: DropDownButton!
    var setProblemType: ((num: Int) -> Void)?
    private lazy var problemTypeDropView: DropDownView = {
        let view = DropDownView()
        view.labelName = ["Classification","Regression"]
        view.showSelectedLabel = {(name: String, num: Int) in
            self.problemTypeButton.setTitle(name, forState: .Normal)
            view.hide()
            self.setProblemType?(num: num)
        }
        view.labelIsSelected = 0
        return view
    }()
    
    @IBAction func problemTypeDrop(sender: DropDownButton) {
        if let window = self.window {
            problemTypeDropView.showInView(window,button: sender)
        }
    }
    
    //MARK: - View
    func showInView(view:UIView) {
        frame = view.bounds
        view.addSubview(self)
        
        layoutIfNeeded()
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseIn, animations: {[weak self]  _ in
            self?.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            }, completion: { _ in
        })
        
    }
    
    func hide() {
        UIView.animateWithDuration(0.2, delay: 0.1, options: .CurveEaseOut, animations: {[weak self]  _ in
            self?.backgroundColor = UIColor.clearColor()
            }, completion: {[weak self]  _ in
                self?.removeFromSuperview()
            })
    }
    
    var isFirstTimeBeenAddAsSubview = true
    
    func OriginImage(image:UIImage, size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let thumbImage = UIImage(named: "Slider")
        
        ratioTrainingTest.setThumbImage(OriginImage(thumbImage!, size: CGSize(width: 20, height: 20)), forState: .Normal)
        if isFirstTimeBeenAddAsSubview {
            isFirstTimeBeenAddAsSubview = false
            
            makeUI()
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(SpreadView.hide))
            self.addGestureRecognizer(tap)
            
            tap.cancelsTouchesInView = true
            tap.delegate = self
        }
    }
    
    func makeUI() {
        setCircleButton.isChosen = true
        for i in 0...5 {
            self.addSubview(addNodeButton[i])
            self.addSubview(subNodeButton[i])
            if i != 0 {
                addNodeButton[i].hidden = true
                subNodeButton[i].hidden = true
            }
        }
        
    }
    
}

extension SpreadView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if touch.view != self {
            return false
        }
        return true
    }
    
}
