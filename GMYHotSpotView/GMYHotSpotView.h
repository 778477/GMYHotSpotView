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
 *  按钮两行之间的巨鹿
 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;
/**
 *  按钮之间的距离
 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
/**
 *  按钮标题到边框的距离
 */
@property (nonatomic, assign) CGFloat titleSpace;
@property (nonatomic, assign) NSInteger maxLines;
@property (nonatomic, copy) HotspotClickHandle clickHandle;
- (instancetype)initWithFrame:(CGRect)frame hotspotViewLayout:(id<GMYHotSpotViewLayout>)layout; //the designated initializer
- (void)updateHotSpotWithArray:(NSArray *)hotspots ClickHandle:(HotspotClickHandle)clickHandle;
@end

