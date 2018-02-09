//
//  ViewController.swift
//  uploadDemo
//
//  Created by liwenban on 2017/8/21.
//  Copyright © 2017年 hellomiao. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import AssetsLibrary
import AVKit
import Alamofire
import MediaPlayer
import SwiftyJSON
import PhotosUI
import Photos
import SVProgressHUD
import Kingfisher
import MJRefresh

//设置服务器地址
let mainURL = "http://207.148.19.37/uploadFile"
//上传图片
let uploadURL = "\(mainURL)/upload.php"
//下载图片
let downLoadURL = "\(mainURL)/bringBackAllPics.php"


class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate ,M80RecentImageFinderDelegate ,UITableViewDelegate,UITableViewDataSource{
    
    let cache = KingfisherManager.shared.cache
    var tableView : UITableView?
    var dataArray = [JSON]()
    let cell = "cell"
    //设置标志，用于标识上传那种类型文件（图片／视频）
    var flag = ""
    var finder = M80RecentImageFinder()
    
    let header = MJRefreshNormalHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set max disk cache to 50 mb. Default is no limit.
        cache.maxDiskCacheSize = 50 * 1024 * 1024
        
        // Set max disk cache to duration to 3 days, Default is 1 week.
        cache.maxCachePeriodInSecond = 60 * 60 * 24 * 3
        
        finder.delegate  = self
      
 
        
        setupTableView()
        
        setRefresh()
    }
    
    func setupTableView(){
        tableView = UITableView(frame:  CGRect(x: 0 , y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height ), style: UITableViewStyle.plain)
        tableView?.dataSource = self
        tableView?.delegate = self
        self.view.addSubview(tableView!)
        self.tableView?.register(UINib.init(nibName: "PictureCell", bundle: nil), forCellReuseIdentifier: cell)
        
        
    }
    
    
    func setRefresh() {
        
        
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(request))
        // 现在的版本要用mj_header
        tableView?.mj_header = header
        
     header.beginRefreshing()
        
       
        
    }
    
    
 
    
    
    func request() {
        SVProgressHUD.show()
        Alamofire.request(downLoadURL).responseJSON { response in
            guard response.result.isSuccess else {
                return
            }
            SVProgressHUD.dismiss()
            if let value = response.result.value {
                let json = JSON(value).arrayValue
                self.dataArray = [JSON]()
                json.reversed().forEach { (pic) in
                    self.dataArray.append(pic)
                }
                self.tableView?.reloadData()
                
                self.tableView?.mj_header.endRefreshing()
            }
        }
    }
//

  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PictureCell
        cell.picName.text = self.dataArray[indexPath.row].stringValue
        var str = "\(mainURL)/pics/\(self.dataArray[indexPath.row].stringValue)"
        str = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: str)
        cell.imageV.kf.setImage(with: url) //  dataArray[indexPath.row]
        return cell

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    
    func onFindRecentImages(_ images: [PHAsset]!) {

     
        let options :PHImageRequestOptions = PHImageRequestOptions()
        options.version = .current
        let manager :PHImageManager = PHImageManager.default()

        //1.发送多次请求
        for i in 0..<images.count {
            
                manager.requestImageData(for: images[i], options: options) { (imageData, string, orientation, info) in
                    let data = NSData.init(data: imageData!)
                    
                    
                    let mediaT :PHAsset = images[i]
                    //获取照片原始创建时间
                    var date:NSDate = mediaT.creationDate! as NSDate
                    let zone = NSTimeZone.local
                    let second:Int = zone.secondsFromGMT()
                    
                    //获取照片正确创建时间
                    date = date.addingTimeInterval(TimeInterval(second))
                    
                    let formatter = DateFormatter()
                    let timeZone = TimeZone.init(identifier: "UTC")
                    formatter.timeZone = timeZone
                    formatter.locale = Locale.init(identifier: "zh_CN")
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"  //格式有问题
                    let creatTime = formatter.string(from: date as Date)
                    
                    //转换成string
                    print(creatTime)
                    let number = "\(i+1)"
                    
                    let imageD : UIImage = UIImage.init(data: data as Data)!
                    let compressData  = UIImageJPEGRepresentation(imageD, 0.01)
                    
                    
                    self.uploadImage(imageData: compressData!  , time: creatTime as String ,count: number )
                    
                }
     
                
            }

    }
    
    
    
    @IBOutlet weak var myImageV: UIImageView!
    

    
    //图库 - 照片
    func photoLib(){
        //
        flag = "图片"
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    

    //图库 - 视频
    func videoLib(){
        flag = "视频"
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            //初始化图片控制器
            let imagePicker = UIImagePickerController()
            //设置代理
            imagePicker.delegate = self
            //指定图片控制器类型
            imagePicker.sourceType = .photoLibrary;
            //只显示视频类型的文件
            imagePicker.mediaTypes =  [kUTTypeMovie as String]
            //不需要编辑
            imagePicker.allowsEditing = false
            //弹出控制器，显示界面
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            print("读取相册错误")
        }
    }
    
    

    
    //选择视频成功后代理
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        if flag == "视频" {
            //获取选取的视频路径
            let videoURL = info[UIImagePickerControllerReferenceURL] as! URL
            let  fetchResult :PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [videoURL], options: nil)
            fetchResult.enumerateObjects({ (phAsset, idx, nil) in
                
                let options :PHVideoRequestOptions = PHVideoRequestOptions()
                options.version = .current
                let manager :PHImageManager = PHImageManager.default()
                manager.requestAVAsset(forVideo: phAsset, options: options, resultHandler: { (asset, audioMix, info) in
        
                    let urlAsset:AVURLAsset = asset as! AVURLAsset;
                    let url :NSURL = urlAsset.url as NSURL;
                    print(url) //file:///var/mobile/Media/PhotoData/Metadata/PhotoData/CPLAssets/group337/66DB0587-A13C-4D8A-97E5-D9975DEF971F.medium.MP4
                    self.uploadVideo(mp4Path: url as URL)
                })
            })
            

            self.dismiss(animated: true, completion: nil)
//            let outpath = NSHomeDirectory() + "/Documents/\(Date().timeIntervalSince1970).mp4"
//            //视频转码
//            self.transformMoive(inputPath: pathString, outputPath: outpath)
            
          
            
        }else{
            //flag = "图片"
            
//            //获取选取后的图片
//            var pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//
//
//
//
//            //转成jpg格式图片
//            guard let jpegData = UIImageJPEGRepresentation(pickedImage, 0.01) else {
//                return
//            }
//
          
            //上传
//            self.uploadImage(imageData: jpegData)
            
            //图片控制器退出
//            self.dismiss(animated: true, completion:nil)
        }
    }
    
    //上传图片到服务器
    func uploadImage(imageData : Data ,time :String,  count:String  ){
        
      
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //采用post表单上传
                // 参数解释：
                
         
                
                multipartFormData.append( (time.data(using: String.Encoding.utf8)!), withName: "time")
                
                //withName:和后台服务器的name要一致 fileName:自己随便写，但是图片格式要写对 mimeType：规定的，要上传其他格式可以自行百度查一下
                multipartFormData.append(imageData, withName: "file", fileName: "123456.png", mimeType: "image/jpeg")
                

                
        },to: uploadURL,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    guard let result = response.result.value else {
                        return
                    }
                    print("\(result)")
                    //须导入 swiftyJSON 第三方框架，否则报错
                    let message = JSON(result)["messsage"].stringValue
                    print(message)
                      SVProgressHUD.dismiss()
                    
//                      self.request()
                    
                    self.tableView?.mj_header.beginRefreshing()
      
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
  
                   
                    SVProgressHUD.showProgress(Float(progress.fractionCompleted), status: "正在上传第\(count)张")
  
                }
            case .failure(let encodingError):
                //打印连接失败原因
                print(encodingError)
            }
        })
    }
    
    //上传视频到服务器
    func uploadVideo(mp4Path : URL){
        Alamofire.upload(
            //同样采用post表单上传
            multipartFormData: { multipartFormData in
                multipartFormData.append(mp4Path, withName: "file", fileName: "123456.mp4", mimeType: "video/mp4")
                //服务器地址
        },to: uploadURL,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //json处理
                upload.responseJSON { response in
                    //解包
                    guard let result = response.result.value else { return }
                    print("\(result)")
                   
                    //须导入 swiftyJSON 第三方框架，否则报错
                    //                    let message = JSON(result)["message"].int ?? -1
                    let message = JSON(result)["messsage"].stringValue
      
                    if message == "1" {
                        print("上传成功")
                        let alert = UIAlertController(title:"提示",message:"上传成功", preferredStyle: .alert)
                        let action2 = UIAlertAction(title: "关闭", style: .default, handler: nil)
                        alert.addAction(action2)
                        self.present(alert , animated: true , completion: nil)
                    }else{
                        print("上传失败")
                        let alert = UIAlertController(title:"提示",message:"上传失败", preferredStyle: .alert)
                        let action2 = UIAlertAction(title: "关闭", style: .default, handler: nil)
                        alert.addAction(action2)
                        self.present(alert , animated: true , completion: nil)
                    }
                }
                //上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("视频上传进度: \(progress.fractionCompleted)")
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    /// 转换视频
    ///
    /// - Parameters:
    ///   - inputPath: 输入url
    ///   - outputPath:输出url
    func transformMoive(inputPath:String,outputPath:String){
        
        
        let avAsset:AVURLAsset = AVURLAsset(url: URL.init(fileURLWithPath: inputPath), options: nil)
        let assetTime = avAsset.duration
        
        let duration = CMTimeGetSeconds(assetTime)
        print("视频时长 \(duration)");
        let compatiblePresets = AVAssetExportSession.exportPresets(compatibleWith: avAsset)
        if compatiblePresets.contains(AVAssetExportPresetLowQuality) {
            let exportSession:AVAssetExportSession = AVAssetExportSession.init(asset: avAsset, presetName: AVAssetExportPresetMediumQuality)!
            let existBool = FileManager.default.fileExists(atPath: outputPath)
            if existBool {
            }
            exportSession.outputURL = URL.init(fileURLWithPath: outputPath)
            
            
            exportSession.outputFileType = AVFileTypeMPEG4
            exportSession.shouldOptimizeForNetworkUse = true;
            exportSession.exportAsynchronously(completionHandler: {
                
                switch exportSession.status{
                    
                case .failed:
                    
                    print("失败...\(String(describing: exportSession.error?.localizedDescription))")
                    break
                case .cancelled:
                    print("取消")
                    break;
                case .completed:
                    print("转码成功")
                    //转码成功后获取视频视频地址
                    let mp4Path = URL.init(fileURLWithPath: outputPath)
                    //上传
                    self.uploadVideo(mp4Path: mp4Path)
                    break;
                default:
                    print("..")
                    break;
                }
            })
        }
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Clear memory cache right away.
        cache.clearMemoryCache()
        
        // Clear disk cache. This is an async operation.
        cache.clearDiskCache()
        
        // Clean expired or size exceeded disk cache. This is an async operation.
        cache.cleanExpiredDiskCache()
    }
    

   

}

