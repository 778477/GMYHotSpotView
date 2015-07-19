//
//  UIDevice+iOSVersion.m
//  
//
//  Created by 郭妙友 on 15/7/19.
//
//

#import "UIDevice+iOSVersion.h"

@implementation UIDevice (iOSVersion)
- (BOOL)systemVersionGeraterThanOrEqualTo:(NSString *)version{
    return NSOrderedAscending != [[UIDevice currentDevice].systemVersion compare:version options:NSNumericSearch];
}
@end
