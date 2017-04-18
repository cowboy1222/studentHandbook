//
//  attendanceViewController.swift
//  studentHandbook
//
//  Created by Rengar Tsoi on 11/4/2017.
//  Copyright © 2017年 Rengar Tsoi. All rights reserved.
//

import UIKit

class attendanceViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        let username = UserDefaults.standard.string(forKey: "username");
        let password = UserDefaults.standard.string(forKey: "password");

        
        let urlString = "https://lenchan139.org/myWorks/fyp/android/attendDetails.php?username=" + username! + "&password=" + password!;
        
        get_data("http://www.kaleidosblog.com/tutorial/tutorial.json")
        
        print(get_data(urlString))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    var list:[MyStruct] = [MyStruct]()
    
    struct MyStruct
    {
        var abc = ""
        var code = ""
        
        init(_ abc:String, _ code:String)
        {
            self.abc = abc
            self.code = code
        }
    }
    
    
    
    
    func get_data(_ link:String)
    {
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            self.extract_data(data)
            
        })
        
        task.resume()
    }
    
    
    func extract_data(_ data:Data?)
    {
        let json:Any?
        
        if(data == nil)
        {
            return
        }
        
        do{
            json = try JSONSerialization.jsonObject(with: data!, options: [])
        }
        catch
        {
            return
        }
        
        guard let data_array = json as? NSArray else
        {
            return
        }
        
        
        for i in 0 ..< data_array.count
        {
            if let data_object = data_array[i] as? NSDictionary
            {
                if let data_code = data_object["code"] as? String,
                    let data_country = data_object["country"] as? String
                {
                    list.append(MyStruct(data_code, data_country))
                }
                
            }
        }
        
        
        refresh_now()
        
        
    }
    
    func refresh_now()
    {
        DispatchQueue.main.async(
            execute:
            {
                self.table.reloadData()
                
        })
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        cell.textLabel?.text = list[indexPath.row].code + " " +  list[indexPath.row].abc
        
        
        return cell
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
