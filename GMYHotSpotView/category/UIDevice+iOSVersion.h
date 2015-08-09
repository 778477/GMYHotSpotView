//
//  UIDevice+iOSVersion.h
//  
//
//  Created by 郭妙友 on 15/7/19.
//
//

#import <UIKit/UIKit.h>

@interface UIDevice (iOSVersion)
/**
 *  判断 当前iOS系统版本 是否大于 version
 *
 *  @param version 要比较的版本号
 *
 *  @return YES/NO （当前系统版本号是否大于要比较的版本号）
 */
- (BOOL)systemVersionGeraterThanOrEqualTo:(NSString *)version;
@end
