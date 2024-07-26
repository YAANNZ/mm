//
//  RRErrorLog.m
//  RRBizCommon
//
//  Created by yanan.zhu on 2024/7/26.
//

#import "RRErrorLog.h"

@implementation RRErrorLog

void Log(const char *file,const char *func, int lineNumber, NSString *format, ...){
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSString *logContent = [NSString stringWithFormat:@"\nRRErrorLog: [file:%s] \n[function:%s] \n[lineNumber:%d] \n%@ \n", file,func,lineNumber,string];
    NSLog(@"%@", logContent);
    
}

@end
