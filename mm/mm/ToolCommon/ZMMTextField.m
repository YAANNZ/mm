//
//  ZMMTextField.m
//  mm
//
//  Created by yanan.zhu on 2022/8/24.
//

#import "ZMMTextField.h"

@interface ZMMTextFieldModel: NSObject

@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) NSUInteger maxNumber;
@property (nonatomic, assign) NSUInteger decimalCount;
@property (nonatomic, assign) NSUInteger IntMaxCount;

@end


@interface ZMMTextField ()

@property (nonatomic, strong) ZMMTextFieldModel *item;

@end

@implementation ZMMTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.item.keyboardType == UIKeyboardTypeDecimalPad) { // 不允许输入正小数之外类型的逻辑
        if (self.item.maxNumber > 0) { // 限制最大数和小数长度
            return [self checkMaxDecimalContentTextField:textField changeRange:range replaceString:string];
        } else { // 限制整数长度、小数长度
            return [self checkDecimalContentTextField:textField changeRange:range replaceString:string];
        }
    }
    
    if (self.item.keyboardType == UIKeyboardTypeNumberPad) { // 只允许正整数
        return [self checkIntContentTextField:textField changeRange:range replaceString:string];
    }
    
    return YES;
}

- (BOOL)checkMaxDecimalContentTextField:(UITextField *)textField changeRange:(NSRange)range replaceString:(NSString *)string {
    NSUInteger max = 2; // 默认最多两位小数
    if (self.item.decimalCount > 0) {
        max = self.item.decimalCount;
    }
    
    if ([string isEqualToString:@" "]) {
        [textField.text stringByReplacingCharactersInRange:range withString:@""];
        return NO;
    }
    BOOL hasDecimal = YES;
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        hasDecimal = NO;
    }
    
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0];
        if ((single >= '0' && single <= '9') || single == '.') { // 输入符合要求
            if ([textField.text length] == 0) {
                if (single == '.') {
                    // 不能 . 开头
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if (single == '.') {
                if (hasDecimal == NO) {
                    hasDecimal = YES;
                    return YES;
                } else {  // 不能多个 .
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if (hasDecimal) {
                NSRange ran = [textField.text rangeOfString:@"."];
                if (range.location <= ran.location) { // 在小数点前输入
                    NSMutableString *textStr = [[NSMutableString alloc] initWithString:textField.text];
                    [textStr insertString:string atIndex:range.location];
                    if (textStr.doubleValue > self.item.maxNumber) {
                        return NO;
                    }
                    return YES;
                } else { // 在小数点后输入
                    if ((textField.text.length - (ran.location + ran.length)) + 1 > max) {
                        return NO;
                    }
                    NSString *totalStr = [textField.text stringByAppendingString:string];
                    if (totalStr.doubleValue > self.item.maxNumber) {
                        return NO;
                    }
                    return YES;
                }
            } else {
                NSString *totalStr = [textField.text stringByAppendingString:string];
                if (totalStr.doubleValue > self.item.maxNumber) {
                    return NO;
                }
                return YES;
            }
        }
        // 输入不符合要求
        [textField.text stringByReplacingCharactersInRange:range withString:@""];
        return NO;
    }
    
    return YES;
}

- (BOOL)checkDecimalContentTextField:(UITextField *)textField changeRange:(NSRange)range replaceString:(NSString *)string {
    NSUInteger max = 2; // 默认最多两位小数
    if (self.item.decimalCount > 0) {
        max = self.item.decimalCount;
    }
    
    if ([string isEqualToString:@" "]) {
        [textField.text stringByReplacingCharactersInRange:range withString:@""];
        return NO;
    }
    BOOL hasDecimal = YES;
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        hasDecimal = NO;
    }
    
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0];
        if ((single >= '0' && single <= '9') || single == '.') { // 输入符合要求
            if (self.item.IntMaxCount > 0) { // 小数点前有长度限制
                if (hasDecimal == NO) {
                    if (textField.text.length == self.item.IntMaxCount && single != '.') {
                        return NO;
                    }
                    return YES;
                }
            }
            
            if ([textField.text length] == 0) {
                if (single == '.') {
                    // 不能 . 开头
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if (single == '.') {
                if (hasDecimal == NO) {
                    hasDecimal = YES;
                    return YES;
                } else {  // 不能多个 .
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            
            if (hasDecimal) {
                NSRange ran = [textField.text rangeOfString:@"."];
                if (range.location <= ran.location) { // 在小数点前输入
                    if (self.item.IntMaxCount > 0) {
                        if (range.location == self.item.IntMaxCount) {
                            return NO;
                        }
                    }
                    return YES;
                } else { // 在小数点后输入
                    if ((textField.text.length - (ran.location + ran.length)) + 1 > max) {
                        return NO;
                    }
                    return YES;
                }
            } else {
                if (self.item.IntMaxCount > 0) { // 小数点前有长度限制
                    if (textField.text.length == self.item.IntMaxCount) {
                        return NO;
                    }
                    return YES;
                }
                return YES;
            }
        }
        // 输入不符合要求
        [textField.text stringByReplacingCharactersInRange:range withString:@""];
        return NO;
    }
    
    return YES;
}

- (BOOL)checkIntContentTextField:(UITextField *)textField changeRange:(NSRange)range replaceString:(NSString *)string {
    if ([string length] > 0) {
        if (self.item.IntMaxCount > 0) {
            if (textField.text.length == self.item.IntMaxCount) {
                return NO;
            }
        }
    }
    return YES;
}

@end
