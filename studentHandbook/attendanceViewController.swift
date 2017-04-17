//
//  attendanceViewController.swift
//  studentHandbook
//
//  Created by Rengar Tsoi on 11/4/2017.
//  Copyright © 2017年 Rengar Tsoi. All rights reserved.
//

import UIKit

class attendanceViewController: UIViewController {
    
    var cellDescriptors: NSMutableArray!
    var visibleRowsPerSection = [[Int]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTableView()
        
        loadCellDescriptors()
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
    
    func getIndicesOfVisibleRows() {
        visibleRowsPerSection.removeAll()
        
        for currentSectionCells in cellDescriptors {
            var visibleRows = [Int]()
            
            for row in 0...((currentSectionCells as! [[String: AnyObject]]).count - 1) {
                if currentSectionCells[row]["isVisible"] as! Bool == true {
                    visibleRows.append(row)
                }
            }
            
            visibleRowsPerSection.append(visibleRows)
        }
    }
    
    func loadCellDescriptors() {
        if let path = Bundle.main.path(forResource: "CellDescriptor", ofType: "plist") {
            cellDescriptors = NSMutableArray(contentsOfFile: path)
            getIndicesOfVisibleRows()
            tblExpandable.reloadData()
        }
    }
    
    func getCellDescriptorForIndexPath(indexPath: NSIndexPath) -> [String: AnyObject] {
        let indexOfVisibleRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let cellDescriptor = cellDescriptors[indexPath.section][indexOfVisibleRow] as! [String: AnyObject]
        return cellDescriptor
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
