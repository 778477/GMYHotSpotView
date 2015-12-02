//
//  GMYImage.h
//  Pods
//
//  Created by miaoyou.gmy on 15/11/22.
//
//

#import <UIKit/UIKit.h>

@interface GMYImage : UIImage

+ (UIImage *)imageNamed:(NSString *)name;
+ (UIImage *)imageNamed:(NSString *)name useJPG:(BOOL)useJPG;

@end
