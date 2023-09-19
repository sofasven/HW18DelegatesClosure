//
//  ChangeBGVC.swift
//  DelegatesClosureSendDataApp
//
//  Created by Sofa on 6.09.23.
//

import UIKit

class ChangeBGVC: UIViewController {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    @IBOutlet weak var opacity: UISlider!
    @IBOutlet weak var opacityTF: UITextField!
    @IBOutlet weak var hexColorTF: UITextField!
    @IBOutlet weak var doneBtnOutlet: UIButton!
    var clrModel: ColorModel?
    var delegate: SetViewBackground?
    
    private var red: Int = 0 {
        didSet {
            сolorController()
            setMinMaxSliderColor()
            checkModels()
        }
    }
    private var green: Int = 0 {
        didSet {
            сolorController()
            setMinMaxSliderColor()
            checkModels()
        }
    }
    private var blue: Int = 0 {
        didSet {
            сolorController()
            setMinMaxSliderColor()
            checkModels()
        }
    }
    private var alpha: Int = 1 {
        didSet {
            сolorController()
            setMinMaxSliderColor()
            checkModels()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColor()
    }
    
    @IBAction func rSliderAction(_ sender: UISlider) {
        redTF.text = String(Int(redSlider.value))
        red = Int(redSlider.value)
    }
    @IBAction func gSliderAction(_ sender: UISlider) {
        greenTF.text = String(Int(greenSlider.value))
        green = Int(greenSlider.value)
    }
    @IBAction func bSliderAction(_ sender: UISlider) {
        blueTF.text = String(Int(blueSlider.value))
        blue = Int(blueSlider.value)
    }
    
    @IBAction func redTFAction(_ sender: UITextField) {
        if let text = redTF.text,
           let number = Float(text) {
            redSlider.value = number
            red = Int(number)
        }
    }
    
    @IBAction func gTFAction(_ sender: UITextField) {
        if let text = greenTF.text,
           let number = Float(text) {
            greenSlider.value = number
            green = Int(number)
        }
    }
    
    @IBAction func bTFAction(_ sender: UITextField) {
        if let text = blueTF.text,
           let number = Float(text) {
            blueSlider.value = number
            blue = Int(number)
        }
    }
    
    
    @IBAction func opacitySliderAction(_ sender: UISlider) {
        opacityTF.text = String(Int(opacity.value))
        alpha = Int(opacity.value)
    }
    @IBAction func opacityTFAction(_ sender: UITextField) {
        if let text = opacityTF.text,
           let number = Float(text) {
            opacity.value = number
            alpha = Int(number)
        }
    }
    
    @IBAction func doneBtnAction() {
        let colorModel = ColorModel(red: red, green: green, blue: blue, alpha: alpha)
        delegate?.setViewBackground(colorModel: colorModel)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func hexColorAction(_ sender: UITextField) {
        if let hex = hexColorTF.text,
           let color = UIColor(hex: hex),
           let model = getModelFromUIColor(uiColor: color) {
            red = model.red
            green = model.green
            blue = model.blue
            alpha = model.alpha
        }
    }
    
    private func сolorController() {
        let redCGFloat = CGFloat(Float(red) / 255)
        let greenCGFloat = CGFloat(Float(green) / 255)
        let blueCGFloat = CGFloat(Float(blue) / 255)
        let alphaCGFloat = CGFloat(Float(alpha) / 100)
        
        let color = UIColor(red: redCGFloat, green: greenCGFloat, blue: blueCGFloat, alpha: alphaCGFloat)
        let model = ColorModel(red: red, green: green, blue: blue, alpha: alpha)
        hexColorTF.text = getHexColor(model: model)
        colorView.backgroundColor = color
    }
    
    private func setMinMaxSliderColor() {
        let redCG = CGFloat(Float(red) / 255)
        let greenCG = CGFloat(Float(green) / 255)
        let blueCG = CGFloat(Float(blue) / 255)
        let alphaCG = CGFloat(Float(alpha) / 100)
        
        redSlider.minimumTrackTintColor = UIColor(red: 0, green: greenCG, blue: blueCG, alpha: alphaCG)
        redSlider.maximumTrackTintColor = UIColor(red: 1, green: greenCG, blue: blueCG, alpha: alphaCG)
        redSlider.thumbTintColor = UIColor(red: redCG, green: greenCG, blue: blueCG, alpha: alphaCG)

        greenSlider.minimumTrackTintColor = UIColor(red: redCG, green: 0, blue: blueCG, alpha: alphaCG)
        greenSlider.maximumTrackTintColor = UIColor(red: redCG, green: 1, blue: blueCG, alpha: alphaCG)
        greenSlider.thumbTintColor = UIColor(red: redCG, green: greenCG, blue: blueCG, alpha: alphaCG)
        
        blueSlider.minimumTrackTintColor = UIColor(red: redCG, green: greenCG, blue: 0, alpha: alphaCG)
        blueSlider.maximumTrackTintColor = UIColor(red: redCG, green: greenCG, blue: 1, alpha: alphaCG)
        blueSlider.thumbTintColor = UIColor(red: redCG, green: greenCG, blue: blueCG, alpha: alphaCG)
    }
    
    private func checkModels() {
        let newColorModel = ColorModel(red: red, green: green, blue: blue, alpha: alpha)
        doneBtnOutlet.isEnabled = clrModel != newColorModel
    }
    
    private func setupColor() {
        if let colorModel = clrModel {
            red = colorModel.red
            green = colorModel.green
            blue = colorModel.blue
            alpha = colorModel.alpha

            redSlider.value = Float(red)
            greenSlider.value = Float(green)
            blueSlider.value = Float(blue)
            opacity.value = Float(alpha)
            
            hexColorTF.text = getHexColor(model: colorModel)
            redTF.text = String(red)
            greenTF.text = String(green)
            blueTF.text = String(blue)
            opacityTF.text = String(alpha)
        }
    }
    
    private func getHexColor(model: ColorModel) -> String {
        let red = model.red
        let green = model.green
        let blue = model.blue
        
        let hexValue = String(format: "%02X", Int(red)) + String(format: "%02X", Int(green)) + String(format: "%02X", Int(blue))
        return hexValue
    }
}
