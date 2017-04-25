//
//  attendanceViewController.swift
//  studentHandbook
//
//  Created by Rengar Tsoi on 11/4/2017.
//  Copyright © 2017年 Rengar Tsoi. All rights reserved.
//

import UIKit

class attendanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var table: UITableView!
    var studArray: [attendance]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //table.dataSource = self
        //table.delegate = self
        
        
        
        
        fetchstDetails()
        
    }
    


    
    
    
    func fetchstDetails(){
        
        let username = "parentX"
        let password = "pw"
        
        
        let urlString = "https://lenchan139.org/myWorks/fyp/android/attendDetails.php?username=" + username + "&password=" + password
        
        let urlRequest = URLRequest(url:URL(string: urlString)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil{
            
                print(error!)
                return
            
            }
            self.studArray = [attendance]()
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                if let attJson = json["studArray"] as? [[String : AnyObject]] {
                    
                    //let attDate = json["student_attend"]?["student_date"]
                    //print(attDate)
                    //for i in 0...(attDate?.count)!-1{
                    for stDetails in attJson{
                        
                        let stdAtt = attendance()
                        if let stdId = stDetails["student_id"] as? String, let stdClass = stDetails["student_class"] as? String,let stdName = stDetails["student_name"] as? String, let stdDate = stDetails["studend_attend"] as? Array<AnyObject>{
                            
                            stdAtt.stdId = stdId
                            stdAtt.stdClass = stdClass
                            //stdAtt.attDate = eachAttDate
                            stdAtt.stdName = stdName
                            
                            
                            for dateArray in stdDate{
                                stdAtt.attDate = dateArray as? [String:AnyObject]
                                let date = dateArray["attend_date"] as! String
                                print(date)
                            }
                            print(stdAtt.attDate!)
                        }
                        self.studArray?.append(stdAtt)
                    }
                }
                //}
                
                DispatchQueue.main.sync {
                    self.table.reloadData()
                }
                
            } catch let error {
                print(error)
            }
    }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attCell", for: indexPath) as! TableViewCell
        cell.attDate.text = self.studArray?[indexPath.item].attDate?["attend_date"] as? String
        //cell.attDate.text = "hehehe"
        cell.stdName.text = self.studArray?[indexPath.item].stdName
        cell.stdClass.text = self.studArray?[indexPath.item].stdClass
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studArray?.count ?? 0
        
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
