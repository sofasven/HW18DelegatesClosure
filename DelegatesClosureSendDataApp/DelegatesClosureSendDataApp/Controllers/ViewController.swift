//
//  ViewController.swift
//  DelegatesClosureSendDataApp
//
//  Created by Sofa on 6.09.23.
//

import UIKit

protocol ColorUpdateProtocol {
    func colorUpdate(color: UIColor)
}

class ViewController: UIViewController {
    @IBOutlet var viewBG: UIView!
    @IBAction func goToChangeBGVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let changeBGVC = storyboard.instantiateViewController(withIdentifier: "ChangeBGVC") as? ChangeBGVC else { return }
        changeBGVC.color = viewBG.backgroundColor
        changeBGVC.delegate = self
        changeBGVC.changeColorWithClosure = { [weak self] newColor in
            self?.viewBG.backgroundColor = newColor
            return newColor
        }
        navigationController?.pushViewController(changeBGVC, animated: true)
    }
    
    


}


