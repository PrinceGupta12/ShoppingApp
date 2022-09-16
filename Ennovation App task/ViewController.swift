//
//  ViewController.swift
//  Ennovation App task
//
//  Created by Shiv on 15/09/22.
//

import UIKit

var cartItem: [Product?] = []
var wishListItem: [Product?] = []

class ViewController: UIViewController {
    
    @IBOutlet weak var ennovImg: UIImageView!
    @IBOutlet weak var EmailLbl: UILabel!
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var fgtBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartItem = []
        wishListItem = []
//        emailtxt.text = "flutter@ennovations.com"
//        passwordTxt.text = "Flutter@1122021"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginBtnClick(_ sender: Any) {
        
        let isValidemailValue = isValidEmail(email: emailtxt.text ?? "")
        let isValidpassValue = isValidPassword(Password: passwordTxt.text ?? "")
        
        if isValidemailValue == true && isValidpassValue == true {
            
            UserDefaults.standard.set(true, forKey: "isLogin")
            UserDefaults.standard.set(emailtxt.text, forKey: "EmailId")
            UserDefaults.standard.set(passwordTxt.text, forKey: "Password")
            
            
            let HomeVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            
            HomeVc.emailId = emailtxt.text
            HomeVc.Password = passwordTxt.text
            self.navigationController?.pushViewController(HomeVc, animated: true)
        }
    }
    
    
    func isValidEmail(email: String) -> Bool {
        if email == "" {
            let alert = UIAlertController(title: "Alert", message: "Please enter your email id", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if email.contains("@") == false {
            let alert = UIAlertController(title: "Alert", message: "Please enter valid email id", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if email.contains(".") == false {
            let alert = UIAlertController(title: "Alert", message: "Please enter valid email id", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if email.trimmingCharacters(in: .whitespacesAndNewlines) != "flutter@ennovations.com" {
            let alert = UIAlertController(title: "Alert", message: "Unathorize email id", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    
    func isValidPassword(Password: String) -> Bool {
        if Password == "" {
            let alert = UIAlertController(title: "Alert", message: "Please enter password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if Password.count < 8 {
            let alert = UIAlertController(title: "Alert", message: "Please enter 8 char password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if Password.trimmingCharacters(in: .whitespacesAndNewlines) != "Flutter@1122021" {
            let alert = UIAlertController(title: "Alert", message: "Unathorize Password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
        @IBAction func fgtBtnClick(_ sender: Any) {
            let alert = UIAlertController(title: "Alert", message: "Forget Password feature coming soon..", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
    
        @IBAction func signUpBtnclick(_ sender: Any) {
            
        let alert = UIAlertController(title: "Alert", message: "SignUp feature coming soon..", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    
    
}


