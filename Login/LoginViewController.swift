//
//  LoginViewController.swift
//  MyDaangnMarket
//
//  Created by 유현진 on 2022/07/26.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var getAuthMessageButton: UIButton!
    @IBOutlet weak var inputAuthNumberTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    var verifyId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initGetAuthMessageButtonStyle()
        initphoneNumberTextFieldStyle()
        initConfirmButtonStyle()
        initObserverTextField()
    }
    // MARK: TODO
    // 로그인 성공 시 화면 이동
    // 앱 재실행 시 이전 로그인 성공 시 Home화면으로
    

    @IBAction func getAuthMessageButton(_ sender: Any) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+15555551111", uiDelegate: nil) { verificationID, error in
              if let error = error {
//                self.showMessagePrompt(error.localizedDescription)
                  print("Error : \(error.localizedDescription) ")
                return
              }
              // Sign in using the verificationID and the code sent to the user
                self.verifyId = verificationID
                print("verifyId -->\(self.verifyId)")
                UserDefaults.standard.set(verificationID, forKey: "verificationID")
          }
    }
    @IBAction func confirmLogin(_ sender: Any) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: self.verifyId ?? "",
            verificationCode: self.inputAuthNumberTextField.text ?? ""
        )
        
        Auth.auth().signIn(with: credential){ (success, error) in
            if let error = error{
                print("Error ---> \(error.localizedDescription)")
                return
            }
            print("success --->\(success)")
        
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainStoryboard")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
    func initConfirmButtonStyle(){
        self.confirmButton.layer.cornerRadius = 4
        self.confirmButton.layer.borderWidth = 1
        self.confirmButton.layer.borderColor = UIColor.lightGray.cgColor
        self.confirmButton.isEnabled = false
        self.confirmButton.backgroundColor = .systemGray
        self.confirmButton.setTitleColor(.lightGray, for: .disabled)
    }
    func initInputAuthNumberTextFieldStyle(){
        self.inputAuthNumberTextField.delegate = self
        self.inputAuthNumberTextField.placeholder = "인증번호 입력"
        self.inputAuthNumberTextField.layer.cornerRadius = 4
        self.inputAuthNumberTextField.layer.borderWidth = 1
        self.inputAuthNumberTextField.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    func initphoneNumberTextFieldStyle(){
        self.phoneNumberTextField.delegate = self
        self.phoneNumberTextField.placeholder = "휴대폰 번호(- 없이 숫자만 입력)"
        self.phoneNumberTextField.becomeFirstResponder()
        self.phoneNumberTextField.layer.cornerRadius = 4
        self.phoneNumberTextField.layer.borderWidth = 1
        self.phoneNumberTextField.layer.borderColor = UIColor.lightGray.cgColor
    }
    func initGetAuthMessageButtonStyle(){
        self.getAuthMessageButton.isEnabled = false
        self.getAuthMessageButton.setTitleColor(.lightGray, for: .disabled)
        self.getAuthMessageButton.layer.cornerRadius = 4
        self.getAuthMessageButton.layer.borderWidth = 1
        self.getAuthMessageButton.layer.borderColor = UIColor.lightGray.cgColor
    }

}
extension LoginViewController: UITextFieldDelegate{
    func initObserverTextField(){
        self.inputAuthNumberTextField.addTarget(self, action: #selector(switchConfirmButton), for: .editingChanged)
        self.phoneNumberTextField.addTarget(self, action: #selector(switchGetAuthMessageButton), for: .editingChanged)
    }
    @objc func switchGetAuthMessageButton(){
        if let numberLen = self.phoneNumberTextField.text{
            if numberLen.count > 7{
                self.getAuthMessageButton.isEnabled = true
            }else{
                self.getAuthMessageButton.isEnabled = false
            }
        }
    }
    @objc func switchConfirmButton(){
        if let numberLen = self.inputAuthNumberTextField.text{
            if numberLen.count > 5{
                self.confirmButton.isEnabled = true
                self.confirmButton.backgroundColor = .orange
            }else{
                self.confirmButton.isEnabled = false
                self.confirmButton.backgroundColor = .systemGray
            }
        }
    }
    
    
    
}
