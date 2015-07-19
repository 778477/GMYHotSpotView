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
    NSMutableArray *hotSpotBtns;
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
- (void)updateHotSpotWithArray:(NSArray *)hotspots{
    
}

#pragma mark - Private Mathod

@end
