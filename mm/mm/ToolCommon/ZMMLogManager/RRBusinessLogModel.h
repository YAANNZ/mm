//
//  RRBusinessLogModel.h
//  RRBizCommon
//
//  Created by yanan.zhu on 2024/7/24.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@import YYModel;

NS_ASSUME_NONNULL_BEGIN

@interface RRBusinessLogModel : NSObject <YYModel>

@property (copy, nonatomic) NSString *content;

@property (assign, nonatomic) NSTimeInterval createTimeInterval;
@property (copy, nonatomic) NSString *createTime;

@property (copy, nonatomic) NSString *account;
@property (assign, nonatomic) long long userId;

@property (nonatomic,copy) NSString *systemInfo; /// 拼接systemName+systemVersion
@property (nonatomic,copy) NSString *machineModel;

@property (nonatomic,copy) NSString *appVersion;
@property (nonatomic,copy) NSString *appBundleID;
@property (nonatomic,copy) NSString *appBundleName;

@property (assign, nonatomic) BOOL instantUpload;

@property (assign, nonatomic) AFNetworkReachabilityStatus networkReachableType;

@end

NS_ASSUME_NONNULL_END
