//
//  RRErrorLog.h
//  RRBizCommon
//
//  Created by yanan.zhu on 2024/7/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define RRErrorLog(format,...) Log(__FILE__,__FUNCTION__,__LINE__,format,##__VA_ARGS__)
void Log(const char *file,const char *func, int lineNumber, NSString *format, ...);


@interface RRErrorLog : NSObject

@end

NS_ASSUME_NONNULL_END
