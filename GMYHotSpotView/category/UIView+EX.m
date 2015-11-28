//
//  UIView+EX.m
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/26.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import "UIView+EX.h"

@implementation UIView (EX)
#pragma mark - Height Getter & Setter
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
#pragma mark - Width Getter & Setter
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    if(!isnan(width)){
        frame.size.width = width;
    }
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}
#pragma mark - Bottom Getter & Setter
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
#pragma mark - Left Getter & Setter
- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left{
    CGRect frame = self.frame;
    if(!isnan(left)){
        frame.origin.x = left;
    }
    self.frame = frame;
}
@end
