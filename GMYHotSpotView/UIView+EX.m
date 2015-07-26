//
//  UIView+EX.m
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/26.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import "UIView+EX.h"

@implementation UIView (EX)
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    if(!isnan(height)){
        frame.size.height = height;
    }
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGFloat)bottom{
    return (self.frame.origin.y + self.frame.size.height);
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    if(!isnan(bottom)){
        frame.origin.y = bottom - frame.size.height;
    }
    self.frame = frame;
}
@end
