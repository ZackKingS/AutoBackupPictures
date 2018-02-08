//
//  AppDelegate.swift
//  uploadDemo
//
//  Created by liwenban on 2017/8/21.
//  Copyright © 2017年 hellomiao. All rights reserved.
//

//TODO
//1.自动上传【视频】
//2.图片以日期命名 👌
//3.progress hud
import UIKit
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
//        let group = DispatchGroup(); //1.DispatchGroup
//        let  queueRequest = DispatchQueue.global(); //2.DispatchQueue
//
//        queueRequest.async(group:group){
//            let semaphore = DispatchSemaphore(value: 0); //3.DispatchSemaphore
//            print("第1个")
//            Alamofire.request("http://207.148.19.37/uploadFile/bringBackAllPics.php").responseJSON { response in
//                semaphore.signal()
//
//                print(response)
//            }
//            let result = semaphore.wait(timeout: DispatchTime.distantFuture)
//            if(result == DispatchTimeoutResult.success)
//            {
//                print("第1个请求回来")
//            }
//
//        }

//        queueRequest.async(group:group){
//            let semaphore = DispatchSemaphore(value: 1);
//            print("第2个")
//            Alamofire.request("https://httpbin.org/get").responseJSON { response in
//                semaphore.signal()
//            }
//            let result = semaphore.wait(timeout: DispatchTime.distantFuture)
//            if(result == DispatchTimeoutResult.success)
//            {
//                print("第2个请求回来")
//            }
//        }
//
//        queueRequest.async(group:group){
//            let semaphore = DispatchSemaphore(value: 2);
//            print("第3个")
//            Alamofire.request("https://httpbin.org/get").responseJSON { response in
//                semaphore.signal()
//            }
//            let result = semaphore.wait(timeout: DispatchTime.distantFuture)
//            if(result == DispatchTimeoutResult.success)
//            {
//                print("第3个请求回来")
//            }
//        }

//        group.notify(queue: queueRequest){
//            print("请求结束")
//        }

//        print("其他任务");
//
    
    

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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

