//
//  AppDelegate.swift
//  uploadDemo
//
//  Created by liwenban on 2017/8/21.
//  Copyright © 2017年 hellomiao. All rights reserved.
//

//TODO

/*
 上传功能 内存管理 关键点：
 1.队列
 2.autoreleasepool
 3.DispatchSemaphore
 4.runloop
 
 */


//dev 
import UIKit
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //        Alamofire.request("http://207.148.19.37/multipChocies/remoteLogin.php").responseJSON { (response) in
        //            switch response.result {
        //            case .success(let value):
        //                let json = JSON(value)
        ////                print ("JSON: \(json)")
        //
        //                let arr = json.arrayValue
        //
        //                print(arr[0])
        //
        //            case .failure(let error):
        //                print("Error while querying database: \(String(describing: error))")
        //
        //                return
        //            }
        //        }
        
        print("master")
        
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
       
        print("codes in dev branch")
        
        
        
        print("do a lots of things in new dev ")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

