//
//  RRBusinessLogModel.m
//  RRBizCommon
//
//  Created by yanan.zhu on 2024/7/24.
//

#import "RRBusinessLogModel.h"

@implementation RRBusinessLogModel

- (NSString *)description {
    return [NSString stringWithFormat:
            @"RRBusinessLog:\n"
            "Content: %@\n"
            "Account: %@\n"
            "UserId: %lld\n"
            "CreateTime: %@\n"
            "CreateTimeInterval: %f\n"
            "SystemInfo: %@\n"
            "MachineModel: %@\n"
            "AppVersion: %@\n"
            "AppBundleID: %@\n"
            "AppBundleName: %@\n"
            "NetworkReachableType: %@\n"
            , _content, _account, _userId, _createTime, _createTimeInterval, _systemInfo, _machineModel, _appVersion, _appBundleID, _appBundleName, [self getNetworkReachableTypeString]];
}

- (NSString *)getNetworkReachableTypeString {
    NSString *typeStr = @"unknown";
    switch (self.networkReachableType) {
        case AFNetworkReachabilityStatusUnknown:
            typeStr = @"Unknown";
            break;
        case AFNetworkReachabilityStatusNotReachable:
            typeStr = @"NotReachable";
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            typeStr = @"ReachableViaWWAN";
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            typeStr = @"ReachableViaWiFi";
            break;
        default:
            break;
    }
    return typeStr;
}

- (AFNetworkReachabilityStatus)networkReachableType {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

@end



