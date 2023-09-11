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
    @IBOutlet weak var colorView: UIView! {
        didSet {
            colorView.backgroundColor = color
        }
    }
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    @IBOutlet weak var opacity: UISlider!
    @IBOutlet weak var opacityTF: UITextField!
    @IBOutlet weak var hexColorTF: UITextField!

    var color: UIColor?
    var delegate: ColorUpdateProtocol?
    var changeColorWithClosure: ( (UIColor) -> (UIColor) )?
    
    @IBAction func rSliderAction(_ sender: UISlider) {
        let shortValue = round(Double(sender.value) * 10) / 10
        redTF.text = String(shortValue)
        changeColor()
    }
    @IBAction func gSliderAction(_ sender: UISlider) {
        let shortValue = round(Double(sender.value) * 10) / 10
        greenTF.text = String(shortValue)
        changeColor()
    }
    @IBAction func bSliderAction(_ sender: UISlider) {
        let shortValue = round(Double(sender.value) * 10) / 10
        blueTF.text = String(shortValue)
        changeColor()
    }
    
    @IBAction func redTFAction(_ sender: UITextField) {
        guard let value = sender.text else { return }
        redSlider.value = Float(value) ?? 0
    }
    
    @IBAction func gTFAction(_ sender: UITextField) {
        guard let value = sender.text else { return }
        greenSlider.value = Float(value) ?? 0
    }
    
    @IBAction func bTFAction(_ sender: UITextField) {
        guard let value = sender.text else { return }
        blueSlider.value = Float(value) ?? 0
    }
    
    
    @IBAction func opacitySliderAction(_ sender: UISlider) {
        let shortValue = round(Double(sender.value) * 10) / 10
        opacityTF.text = String(shortValue)
        changeColor()
    }
    @IBAction func opacityTFAction(_ sender: UITextField) {
        guard let value = sender.text else { return }
        opacity.value = Float(value) ?? 0
    }
    
    @IBAction func doneWithDelegates() {
        delegate?.colorUpdate(color: colorView.backgroundColor ?? .green)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneWithClosure() {
        guard let changeColorWithClosure = changeColorWithClosure else { return }
        color = changeColorWithClosure(colorView.backgroundColor ?? .green)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    @IBAction func hexColorAction(_ sender: UITextField) {
        guard let hexValue = sender.text,
              let color = UIColor(hex: hexValue),
              let red = color.cgColor.components?[0],
              let green = color.cgColor.components?[1],
              let blue = color.cgColor.components?[2],
              let alfa = color.cgColor.components?[3] else { return }
        colorView.backgroundColor = color
        redSlider.value = Float(red)
        redTF.text = String(round((Double(red.description) ?? 0) * 10) / 10)
        greenSlider.value = Float(green)
        greenTF.text = String(round((Double(green.description) ?? 0) * 10) / 10)
        blueSlider.value = Float(blue)
        blueTF.text = String(round((Double(blue.description) ?? 0) * 10) / 10)
        opacity.value = Float(alfa)
                opacityTF.text = String(round((Double(alfa.description) ?? 0) * 10) / 10)
    }
    
    func changeColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(opacity.value))
    }
}
