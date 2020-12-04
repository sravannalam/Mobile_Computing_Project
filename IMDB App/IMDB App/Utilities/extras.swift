//
//  extras.swift
//  IMDB App
//
//  Created by Kashif Rizwan on 11/19/20.
//

import UIKit

@IBDesignable
class CustomView: UIView{

    @IBInspectable var borderWidth: CGFloat = 0.0{

        didSet{

            self.layer.borderWidth = borderWidth
        }
    }


    @IBInspectable var borderColor: UIColor = UIColor.clear {

        didSet {

            self.layer.borderColor = borderColor.cgColor
        }
    }

    override func prepareForInterfaceBuilder() {

        super.prepareForInterfaceBuilder()
    }

}

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension UIViewController{
    
    func showAlert(title: String, message: String, completion: @escaping (_ done: String?) -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(_) in
            completion(nil)
        }))
        self.present(alert, animated: true)
    }
}
