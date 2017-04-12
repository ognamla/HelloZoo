//
//  HelloZooTableViewController.swift
//  HelloZoo
//
//  Created by Ognam.Chen on 2017/4/10.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit

class HelloZooTableViewController: UITableViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    
    var dataArray = [AnyObject]() // 儲存資料
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 台北市立動物園公開資料網址
        let url = URL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=a3e2b221-75e0-45c1-8f97-75acbd43d613")
        
        // 設定URL配置
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)

        // 設定會話任務
        let dataTask = session.downloadTask(with: url!)
        
        dataTask.resume()
        
    }
    
    // 將下載下來的資料 JSON處理
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        // 利用 do - try - catch
        do {
            
            // 台北市政府動物園 資料結構為 [String : [String : AnyObject(這裡是Array)]]
            let dataDic = try JSONSerialization.jsonObject(with: Data(contentsOf: location), options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: [String: AnyObject]]
            
            dataArray = dataDic["result"]!["results"] as! [AnyObject]
            tableView.reloadData()
            
        } catch {
            
            print("ERROR!")
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = dataArray[indexPath.row]["A_Name_Ch"] as? String
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = dataArray[indexPath.row]
                let detailVewController = segue.destination as! DetailViewController
                detailVewController.animalDetail = object
                
            }
        }
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
