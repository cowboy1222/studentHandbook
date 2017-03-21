//
//  ViewController.swift
//  studentHandbook
//
//  Created by Rengar Tsoi on 23/1/2017.
//  Copyright © 2017年 Rengar Tsoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        
        if (userEmail!.isEmpty || userPassword!.isEmpty)
        {
            displayMyAlertMessage(userMessage: "All fields are equired.");
            return;
        }
        
        let myUrl = URL(string: "https://lenchan139.org/myWorks/fyp/android/login.php?username=admin&password=pw")
        let request = NSMutableURLRequest(url: myUrl!);
        request.httpMethod = "POST";
        
        let postString = "userEmail=\(userEmail)&userPassword=\(userPassword)";
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        
        let task = URLSession.shared.dataTask(with: myUrl!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        }
        
        task.resume()
        
        
        
    }
    
    func displayMyAlertMessage(userMessage:String)
    {
        var loginAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle:UIAlertControllerStyle.alert);
        
        let doneAction =  UIAlertAction(title:"done", style:UIAlertActionStyle.default, handler:nil);
        
        loginAlert.addAction(doneAction);
        
        self.present(loginAlert, animated:true, completion:nil);
    }
    


}

