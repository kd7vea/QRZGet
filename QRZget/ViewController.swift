//
//  ViewController.swift
//  QRZget
//
//  Created by Jake Estepp on 2/1/17.
//  Copyright © 2017 Jake Estepp. All rights reserved.
//



import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var callSignTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!

    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var Sessionkey: UITextField!
  
    @IBOutlet var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func loginButton(_ sender: Any) {
        guard  let callSign = callSignTextField.text
            else {
                return
        }
        guard  let password = passwordTextField.text
            else {
                return
        }
    
        if(callSign == "" || password == ""){
            warningLabel.text = "Enter Callsign and Password"
    }else{
          QRZlogin("http://xmldata.qrz.com/xml/current/?username=\(callSign);password=\(password);agent=q5.0")
            warningLabel.text = ""
        }
    }
    
    func QRZlogin (_ url:String){
        
        
        guard let url:NSURL = NSURL(string: url)
        else {
            return
        }
                    let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
        //let paramString = "data=test"
       // request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print ("error")
                self.warningLabel.text = "No connection to QRZ.com Database"
                return
            }
            
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
            }
        }
        
        task.resume()
    }
}

