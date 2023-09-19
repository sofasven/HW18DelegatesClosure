//
//  ViewController.swift
//  DelegatesClosureSendDataApp
//
//  Created by Sofa on 6.09.23.
//

import UIKit

protocol SetViewBackground {
    func setViewBackground(colorModel: ColorModel)
}

class ViewController: UIViewController {
    
    @IBAction func goToChangeBGVC() {
        performSegue(withIdentifier: "GoToChangeBG", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let changeBGVC = segue.destination as? ChangeBGVC,
           segue.identifier == "GoToChangeBG"
        {
            if let backColor = view.backgroundColor,
               let colorModel = getModelFromUIColor(uiColor: backColor) {
                changeBGVC.clrModel = colorModel
            }
            changeBGVC.delegate = self
        }
    }
}


extension ViewController: SetViewBackground {
    func setViewBackground(colorModel: ColorModel) {
        let red = CGFloat(Float(colorModel.red) / 255)
        let green = CGFloat(Float(colorModel.green) / 255)
        let blue = CGFloat(Float(colorModel.blue) / 255)
        let alpha = CGFloat(Float(colorModel.alpha) / 100)
        let newColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        view.backgroundColor = newColor
    }
}

extension UIViewController {
    func getModelFromUIColor(uiColor: UIColor) -> ColorModel? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        
        uiColor.getRed(&red,
                       green: &green,
                       blue: &blue,
                       alpha: &alpha)
        let redInt = Int(red * 255)
        let greenInt = Int(green * 255)
        let blueInt = Int(blue * 255)
        let alphaInt = Int(alpha * 100)
        
        let colorModel = ColorModel(red: redInt,
                                    green: greenInt,
                                    blue: blueInt,
                                    alpha: alphaInt)
        return colorModel
    }
}


