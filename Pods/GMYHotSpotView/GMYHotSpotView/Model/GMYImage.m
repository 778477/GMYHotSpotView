//
//  GMYImage.m
//  Pods
//
//  Created by miaoyou.gmy on 15/11/22.
//
//

#import "GMYImage.h"

@implementation GMYImage


+ (UIImage *)imageNamed:(NSString *)name{
    return [GMYImage imageNamed:name useJPG:NO];
}

+ (UIImage *)imageNamed:(NSString *)name useJPG:(BOOL)useJPG{
    if(!name || !name.length) return nil;
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Resources.bundle" ofType:nil]];
    NSString *fileType = useJPG ? @"jpg":@"png";
    NSString *imgPath = [bundle pathForResource:[name stringByAppendingString:@"@2x"] ofType:fileType];
    if([UIScreen mainScreen].bounds.size.width > 375.f){
        imgPath = [bundle pathForResource:[name stringByAppendingString:@"@3x"] ofType:fileType];
    }
    
    if(!imgPath){
        imgPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:fileType];
    }
    
    return [self imageWithContentsOfFile:imgPath];
}
@end
