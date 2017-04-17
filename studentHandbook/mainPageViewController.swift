//
//  mainPageViewController.swift
//  studentHandbook
//
//  Created by Rengar Tsoi on 10/4/2017.
//  Copyright © 2017年 Rengar Tsoi. All rights reserved.
//

import UIKit

class mainPageViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func logoutBtn(_ sender: Any) {
        
        UserDefaults.standard.set(nil, forKey: "username");
        UserDefaults.standard.set(nil, forKey: "password");
        UserDefaults.standard.synchronize()
        
        let username = UserDefaults.standard.string(forKey: "username");
        let password = UserDefaults.standard.string(forKey: "password");
        
        if(username == nil && password == nil){
            
            performSegue(withIdentifier: "loginPage", sender: self)
            
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
