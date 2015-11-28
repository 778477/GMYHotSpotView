//
//  GMYHotSpotViewLayout.h
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/19.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class GMYHotSpotView;
@protocol GMYHotSpot;
typedef void(^eachLineCompletion)(NSInteger line,NSArray *fixedHotspots);
@protocol GMYHotSpotViewLayout <NSObject>
@required
@property (nonatomic, weak) GMYHotSpotView *hotspotView;
- (void)layoutHotSpotView:(NSArray *)hotspots eachLineCompletion:(eachLineCompletion)completion;
- (void)updateHotSpotViewLayoutByRemoveHotspot:(id<GMYHotSpot>)hotspot withRemovedSpot:(UIView *)spotView;
- (CGFloat)calculateViewHeightWithHotSpot:(NSArray *)hotspots;
@end
