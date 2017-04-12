//
//  DetailViewController.swift
//  HelloZoo
//
//  Created by Ognam.Chen on 2017/4/11.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    
    // 設定一個可以從上一頁傳遞來的“容器”
    var animalDetail: AnyObject?
    
    @IBOutlet var animalImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 從 animalDetail 裏頭取出 url
        let url = (animalDetail as! [String:AnyObject])["A_Pic01_URL"]
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        // 因為這裡的 url 是藏在 [AnyObject] 裡面
        let dataTask = session.downloadTask(with: URL(string: url as! String)!)
        dataTask.resume()
        
        // Do any additional setup after loading the view.
        
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {

        // 因為已經是 JSON 過濾完的資料，因此不需要再 使用 JSON
        guard let imageData = NSData(contentsOf: location) else {
            return
        }
        
        animalImage.image = UIImage(data: imageData as Data)
        
        
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
