//
//  ExtensionVC.swift
//  DelegatesClosureSendDataApp
//
//  Created by Sofa on 7.09.23.
//

import UIKit


extension ViewController: ColorUpdateProtocol {
    func colorUpdate(color: UIColor) {
        viewBG.backgroundColor = color
    }
    
    
}
