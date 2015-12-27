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
#pragma mark - Top Getter & Setter
- (CGFloat)top{
    return (self.frame.origin.y);
}

- (void)setTop:(CGFloat)top{
    CGRect frame = self.frame;
    if(!isnan(top)){
        frame.origin.y = top;
    }
    self.frame = frame;
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
#pragma mark - Right Getter & Setter
- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    if(!isnan(right)){
        frame.origin.x = right - frame.size.width;
    }
    self.frame = frame;
}

#pragma mark - Point Getter & Setter
- (CGPoint)point{
    return CGPointMake(self.frame.origin.x, self.frame.origin.y);
}

- (void)setPoint:(CGPoint)point{
    CGRect frame = self.frame;
    if(!isnan(point.x) && !isnan(point.y)){
        frame.origin = point;
    }
    self.frame = frame;
}
@end
