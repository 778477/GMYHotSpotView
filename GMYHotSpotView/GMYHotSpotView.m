//
//  GMYHotSpotView.m
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/19.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import "GMYHotSpotView.h"
#import "GMYHotSpotViewLayout.h"
#import "GMYHotSpotViewNormalLayout.h"
@interface GMYHotSpotView(){
    NSMutableArray *_hotspots;
    id<GMYHotSpotViewLayout> _hotspotViewLayout;
}
@end

@implementation GMYHotSpotView
#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame hotspotViewLayout:(id<GMYHotSpotViewLayout>)layout{
    if(self =[super initWithFrame:frame]){
        _hotspotViewLayout = layout;
        _hotspotViewLayout.hotspotView = self;
    }
    return self;
}

#pragma mark - Public Method
- (void)updateHotSpotWithArray:(NSArray *)hotspots ClickHandle:(HotspotClickHandle)clickHandle{
    [self p_clean];
    _hotspots = [hotspots copy];
    _clickHandle = clickHandle;
    [_hotspotViewLayout layoutHotSpotView:hotspots];
}


#pragma mark - Private Mathod
- (void)p_clean{
    [_hotspots removeAllObjects];
}

@end
