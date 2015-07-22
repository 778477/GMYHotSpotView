//
//  GMYHotSpotViewNormalLayout.m
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/19.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import "GMYHotSpotViewNormalLayout.h"
#import <CoreGraphics/CoreGraphics.h>
@implementation GMYHotSpotViewNormalLayout
@synthesize hotspotView = _hotspotView;
#pragma mark - life cycle
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}


-(void)dealloc{
    
}
#pragma mark - override
- (void)layoutHotSpotView:(NSArray *)hotspots{
    CGFloat limitWidth = CGRectGetWidth(_hotspotView.frame);
    
}
@end
