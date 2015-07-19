//
//  GMYHotSpotView.h
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/19.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GMYHotSpotViewLayout;
@interface GMYHotSpotView : UIView
- (instancetype)initWithFrame:(CGRect)frame hotspotViewLayout:(id<GMYHotSpotViewLayout>)layout; //the designated initializer
- (void)updateHotSpotWithArray:(NSArray *)hotspots;
@end

