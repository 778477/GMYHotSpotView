//
//  GMYHotSpotView.h
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/19.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GMYHotSpotViewLayout;

typedef void(^HotspotClickHandle)(NSInteger index,NSString *title);

typedef NS_ENUM(NSUInteger, HotspotState) {
    HotspotStateNormal = 0,
    HotspotStateEditing,
};

@interface GMYHotSpotView : UIView
/**
 *  按钮 标题文字的大小
 */
@property (nonatomic, assign) CGFloat fontSize;
/**
 *  按钮的宽度
 */
@property (nonatomic, assign) CGFloat buttonWidth;
/**
 *  按钮的高度
 */
@property (nonatomic, assign) CGFloat buttonHeight;
/**
 *  按钮两行之间的距离
 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;
/**
 *  按钮之间的距离
 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property (nonatomic, strong) UIColor *buttonBackgroundColor;

@property (nonatomic, strong) UIColor *buttonTitleColor;
/**
 *  按钮标题到边框的距离
 */
@property (nonatomic, assign) CGFloat titleSpace;
/**
 *  支持最大热点行数
 */
@property (nonatomic, assign) NSInteger maxLines;
/**
 *  热点 点击回调
 */
@property (nonatomic, copy) HotspotClickHandle clickHandle;
/**
 *  热点数据源
 */
@property (nonatomic, strong) NSMutableArray *hotspots;

- (instancetype)initWithFrame:(CGRect)frame hotspotViewLayout:(id<GMYHotSpotViewLayout>)layout; //the designated initializer

- (void)updateHotSpotWithArray:(NSArray *)hotspots ClickHandle:(HotspotClickHandle)clickHandle;

- (CGFloat)calcluateViewHeightWithHotspots:(NSArray *)hotspots;
@end

