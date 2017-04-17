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
        
        let username = UserDefaults.standard.string(forKey: "username");
        let password = UserDefaults.standard.string(forKey: "password");
        if(username != nil && password != nil){
        
            performSegue(withIdentifier: "homePage", sender: self)
        
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func loginButton(sender: AnyObject) {
        
        let username = userEmailTextField.text;
        let password = userPasswordTextField.text;
        
        if (username!.isEmpty || password!.isEmpty)
        {
            displayMyAlertMessage(userMessage: "All fields are equired.");
            return;
        }
        
        let urlString = "https://lenchan139.org/myWorks/fyp/android/attendDetails.php?username=" + username! + "&password=" + password!;
        
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    //print(parsedData);
                    let isVaild = parsedData["isVaild"] as! Bool;
                    let loggedUser = parsedData["username"] as? String;
                    let dictStudAttend = parsedData["studArray"] as! NSArray;
                    
                    
                    var output : String;
                    if(isVaild && loggedUser != nil){
                        output = loggedUser! + " is vaild";
                        for i in 0...dictStudAttend.count-1{
                            let row = dictStudAttend[i] as! NSDictionary;
                            let name = row["student_name"] as! String;
                            print("student " + String(i) + "'s name is " + name);
                        }
                        
                        UserDefaults.standard.set(true, forKey: "isLoggedIn");
                        UserDefaults.standard.synchronize();
                        
                        UserDefaults.standard.set(username, forKey: "username");
                        UserDefaults.standard.set(password, forKey: "password");
                        UserDefaults.standard.synchronize()
                        let username = UserDefaults.standard.string(forKey: "username");
                        print(username!);
                        
                    }else if(loggedUser != nil){
                        output = loggedUser! + " is not vaild";
                    }else{
                        output = "InVaild!";
                    }
                    print(output);
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn");
        if (isLoggedIn) {
            performSegue(withIdentifier: "homePage", sender: self)
        }
        
        
    }
    
    func displayMyAlertMessage(userMessage:String)
    {
        let loginAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle:UIAlertControllerStyle.alert);
        
        let doneAction =  UIAlertAction(title:"done", style:UIAlertActionStyle.default, handler:nil);
        
        loginAlert.addAction(doneAction);
        
        self.present(loginAlert, animated:true, completion:nil);
    }
    


}

