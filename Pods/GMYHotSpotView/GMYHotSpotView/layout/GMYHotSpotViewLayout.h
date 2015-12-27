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
/**
 *  block 回调
 *
 *  @param line          当前行号
 *  @param fixedHotspots 当前行数据
 */
typedef void(^eachLineCompletion)(NSInteger line,NSArray *fixedHotspots);

@protocol GMYHotSpotViewLayout <NSObject>
@required
/**
 *  weak 持有hotspotview,方便访问属性
 */
@property (nonatomic, weak) GMYHotSpotView *hotspotView;
/**
 *  针对 hotspots 数据源使用回调定义的布局方法进行布局
 *
 *  @param hotspots   数据源
 *  @param completion 单行布局方式
 */
- (void)layoutHotSpotView:(NSArray<id<GMYHotSpot> > *)hotspots eachLineCompletion:(eachLineCompletion)completion;
/**
 *  针对 删除一项数据之后 自动重新排版布局
 *
 *  @param hotspot  删除数据项
 *  @param spotView 删除视图
 */
- (void)updateHotSpotViewLayoutByRemoveHotspot:(id<GMYHotSpot>)hotspot withRemovedSpot:(UIView *)spotView;
/**
 *  针对 数据源提供的数据 计算视图高度
 *
 *  @param hotspots 数据源
 *
 *  @return 高度
 */
- (CGFloat)calculateViewHeightWithHotSpot:(NSArray<id<GMYHotSpot> > *)hotspots;
@end
