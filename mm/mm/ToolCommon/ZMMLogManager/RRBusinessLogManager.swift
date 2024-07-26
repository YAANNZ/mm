//
//  RRBusinessLogManager.swift
//  RRTools
//
//  Created by yanan.zhu on 2024/7/23.
//

/**
 日志系统包括：业务日志、网络日志
    RRBusinessLogManager 负责记录业务日志
    设计数据库：
        发生时间：yyyyMMddHHmmssSSSSSS
        设备信息
        App 信息
        网络信息
        用户信息
    日志上传：
        主动上传：
            重要日志发生时，上传到 Aws s3 的地址：doc/appLogs/userid/recapcheLogs/202407090944000.txt
            每日 App 进入前台时：检测上一日日志，以天为单位筛选后合并数据，上传到 Aws s3 的地址：doc/appLogs/userid/recapcheLogs/20240709.txt
        被动捞取：长连接通道、静默 push（达成率有问题），app 收到需求后，根据所需要的时间段上传具体数据：doc/appLogs/userid/recapcheLogs/202407090944000.txt
        手动导出：UIDocumentInteractionController，筛选后合并数据后写入本地，导出后及时删除本地文件
    安全性
 */

import Foundation
import AFNetworking

@objc public class RRBusinessLogManager: NSObject {
    
    static let RRBusinessLogUserDefaultsKey = "RRBusinessLogUserDefaultsKey"
    
    @objc public static let sharedInstance = RRBusinessLogManager()
    
    private override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Public
    @objc public func logWithContent(content: String) {
//        let account = RRAppContext.sharedInstance().currentUser.account ?? "";
//        logWithContent(content: content, account: account)
    }
    
    @objc public func logWithContent(content: String, account: String) {
        
//        if (isLoginApp) { // 写入数据库
//            
//            
//           
//        } else { // 先存本地文件
//            saveDataToUserDefaults(content, account)
//        }
        
    }
    
    @objc public func fetchLog(_ startDate: Date, _ endDate: Date) {
        
    }
    
    // MARK: - Notification
    @objc func afterLogin() {
        // 读取本地存储的数据，存入数据库，根据 instantUpload 判断是否要立刻上传
        let dataAry = UserDefaults().array(forKey: getRRBusinessLogUserDefaultsKey(nil))
        if dataAry != nil {
            let dataArray = NSArray.yy_modelArray(with: RRBusinessLogModel.self, json: dataAry!) as? NSArray
            for index in 0..<(dataArray?.count ?? 0) {
                let logModel = dataArray?.object(at: index) as? RRBusinessLogModel
                addAccountInfoToLogModel(logModel)
                if (logModel?.instantUpload == true) {
                    uploadLogModel(logModel)
                }
            }
        }
        
        
    }
    
    @objc func willEnterForeground() {
//        let isLoginApp = RRAppContext.sharedInstance().isLoginApp()
//        if !isLoginApp { return }
        
        
        
        // 获取今天之前的数据，立刻上传，上传后删除
        
        
        /** 筛选数据库未上传或者上传失败的数据，以天为单位上传
         */
        
        //        let filePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        //        let createSuccess = FileManager.default.createFile(atPath: filePath ?? "", contents: contentData)
        //        if (createSuccess) {
        //        }
        
    }
    
    
    // MARK: - Private
    // 保存到本地
    func saveDataToUserDefaults(_ content: String, _ account: String) {
        /**
         发生时间：yyyyMMddHHmmssSSSSSS
         设备信息
         App 信息
         网络信息
         用户信息
         */
        
        var dataAry = UserDefaults().value(forKey: getRRBusinessLogUserDefaultsKey(account)) as? NSMutableArray
        if dataAry == nil {
            dataAry = NSMutableArray()
        } else {
            dataAry = NSMutableArray(array: dataAry!)
        }
        
        let logModel = RRBusinessLogModel()
        logModel.content = content
        logModel.account = account
        
        addBaseInfoToLogModel(logModel)
        
        let jsonObject = logModel.yy_modelToJSONObject()
        if jsonObject != nil {
            dataAry?.add(jsonObject!)
            UserDefaults().set(dataAry, forKey: getRRBusinessLogUserDefaultsKey(account))
        }
    }
    
    // 上传到 Aws
    func uploadLogModel(_ logModel: RRBusinessLogModel?) {
        if logModel == nil {return}
        guard let contentData = getLogContentData(logModel!) else { return }
        
        
    }
    
    // MARK: - Tool
    func addBaseInfoToLogModel(_ logModel: RRBusinessLogModel) {
        let dateForrmat = DateFormatter()
        dateForrmat.dateFormat = "yyyyMMddHHmmssSSS"
        let createTime = dateForrmat.string(from: Date())
        logModel.createTime = createTime
        logModel.createTimeInterval = Date().timeIntervalSince1970
        
        addAccountInfoToLogModel(logModel)
        addDeviceInfoToLogModel(logModel)
        addAppInfoToLogModel(logModel)
        addNetworkInfoToLogModel(logModel)
    }
    
    func addAccountInfoToLogModel(_ logModel: RRBusinessLogModel?) {
    }
    
    func addDeviceInfoToLogModel(_ logModel: RRBusinessLogModel) {
        logModel.systemInfo = RRAppInfo.sharedInstance().systemInfo
        logModel.machineModel = RRAppInfo.sharedInstance().machineModel
    }
    
    func addAppInfoToLogModel(_ logModel: RRBusinessLogModel) {
        logModel.appVersion = RRAppInfo.sharedInstance().appVersion
        logModel.appBundleID = RRAppInfo.sharedInstance().appBundleID
        logModel.appBundleName = RRAppInfo.sharedInstance().appBundleName
    }
    
    func addNetworkInfoToLogModel(_ logModel: RRBusinessLogModel) {
        logModel.networkReachableType = AFNetworkReachabilityManager.shared().networkReachabilityStatus
    }
    
    func getLogContentData(_ logModel: RRBusinessLogModel) -> Data? {
        let dataString = logModel.description
        return dataString.data(using: String.Encoding.utf8)
    }
    
    func getRRBusinessLogUserDefaultsKey(_ account: String?) -> String {
        var accountStr = account
        if (account == nil) {
//            accountStr = RRAppContext.sharedInstance().currentUser.account ?? ""
        }
        
        return RRBusinessLogManager.RRBusinessLogUserDefaultsKey + accountStr!
    }
    
    
    
    
    
    
    
//    //读取文件
//    NSString *fileName = [[newURL URLByDeletingPathExtension] lastPathComponent];
//    NSString *fileType = [newURL pathExtension];
//    fileName = [fileName stringByRemovingPercentEncoding];
//    NSData *data = [NSData dataWithContentsOfURL:newURL];
//    
//    [self.view showLoadingView];
//    [[RRFileUploadTools shareInstance] uploadData:data
//                                 fileCategoryType:RRFileCategoryDoc
//                                      bizCategory:RRUploadBizCategoryEmailExtra
//                                         fileName:fileName
//                                      contentType:nil
//                                    fileExtension:fileType
//                                         progress:^(NSProgress * _Nonnull progress) {
//        //        NSLog(@"%f",progress.fractionCompleted);
//    }
//                                completionHandler:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull url, NSError * _Nonnull error) {
//        [self.view hideLoadingView];
//        if(error == nil){
//            
//            RREmailAttachmentItem *item = [RREmailAttachmentItem new];
//            item.contentType = fileType;
//            item.fileName = [newURL lastPathComponent];
//            item.queryLink = url;
//            item.size = [NSNumber numberWithLongLong:data.length]; // data.lenght单位byte
//
//            [self.extraListAry addObject:item];
//            [self.tableView reloadData];
//            [self.tableView scrollToBottom];
//            
//        } else {
//            [self.view makeToast:error.localizedDescription];
//        }
//    }];
}


