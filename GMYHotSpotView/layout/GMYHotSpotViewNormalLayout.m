//
//  GMYHotSpotViewNormalLayout.m
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/19.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import "GMYHotSpotViewNormalLayout.h"
#import "GMYHotSpotViewDefines.h"
#import "GMYHotSpotView.h"
#import "GMYHotSpot.h"
#import "UIView+EX.h"

@implementation GMYHotSpotViewNormalLayout
@synthesize hotspotView = _hotspotView;
#pragma mark - Override
- (void)layoutHotSpotView:(NSArray *)hotspots eachLineCompletion:(eachLineCompletion)completion{
    NSMutableArray *models = [NSMutableArray arrayWithArray:hotspots];
    NSMutableArray *fixedModels = [[NSMutableArray alloc] initWithCapacity:3];
    NSInteger modelCount = models.count;
    CGFloat limitWidth = CGRectGetWidth(self.hotspotView.frame);
    CGFloat lineTotalWidth;
    NSInteger line = 0;
    while (modelCount > 0) {
        lineTotalWidth = 0.f;
        for(NSInteger i=0;i<modelCount;i++){
            id<GMYHotSpot> spot = models[i];
            
            CGSize textSize = [spot.title boundingRectWithSize:CGSizeMake(limitWidth, _hotspotView.buttonHeight)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_hotspotView.fontSize]}
                                                       context:nil].size;
            
            CGFloat itemSpace = MAX(0, fixedModels.count)*self.hotspotView.minimumInteritemSpacing;
            if(textSize.width + lineTotalWidth + itemSpace + 2*_hotspotView.titleSpace > limitWidth){
                break;
            }
            spot.line = line;
            lineTotalWidth += (textSize.width + 2*_hotspotView.titleSpace);
            [fixedModels addObject:spot];
        }
        completion(line,fixedModels);
        line++;
        modelCount -= (fixedModels.count);
        [models removeObjectsInArray:fixedModels];
        [fixedModels removeAllObjects];
    }
}

- (void)updateHotSpotViewLayoutByRemoveHotspot:(id<GMYHotSpot>)hotspot withRemovedSpot:(UIView *)spotView{
    CGFloat offsetX = spotView.left;
    CGFloat wellOff = _hotspotView.width - offsetX;
    NSUInteger nowLine = hotspot.line;
    NSUInteger endIndex = kGMYHotSpotViewTagBaseIndex + _hotspotView.subviews.count;
    if(spotView.left - 0.f < 1e-6 && spotView.tag >= kGMYHotSpotViewTagBaseIndex+1){
        UIView *front = [_hotspotView viewWithTag:spotView.tag - 1];
        UIView *back = [_hotspotView viewWithTag:spotView.tag];
        
        if(_hotspotView.width - front.left - front.width - _hotspotView.minimumInteritemSpacing >= back.width){
            --nowLine;
            offsetX =  front.right + _hotspotView.minimumInteritemSpacing;
            wellOff = _hotspotView.width - offsetX;
        }
    }
    
    for (NSUInteger idx = spotView.tag; idx < endIndex; idx++) {
        UIView *btn = [_hotspotView viewWithTag:idx];
        id<GMYHotSpot> model = _hotspotView.hotspots[idx - kGMYHotSpotViewTagBaseIndex];
        if(model.line != nowLine){
            if(wellOff >= btn.width){
                [UIView animateWithDuration:0.3f animations:^{
                    btn.point = CGPointMake(offsetX, nowLine*_hotspotView.buttonHeight+nowLine*_hotspotView.minimumLineSpacing);
                }];
                model.line = nowLine;
            }
            else{
                if(btn.left - 0.f > 1e-6){
                    --idx;
                    offsetX = 0;
                    wellOff = _hotspotView.width - offsetX;
                    nowLine = model.line;
                    continue;
                }
                else if(model.line - nowLine > 1){
                    --idx;
                    offsetX = 0;
                    wellOff = _hotspotView.width - offsetX;
                    nowLine++;
                    continue;
                }
                else{
                    break;
                }
            }
        }
        else{
            [UIView animateWithDuration:0.3f animations:^{
                btn.left = offsetX;
            }];
        }
        offsetX += (btn.width + _hotspotView.minimumInteritemSpacing);
        wellOff = _hotspotView.width - offsetX;
    }
    
    if(_hotspotView.hotspots.count >= 1){
        id<GMYHotSpot> lastHotSpot = [_hotspotView.hotspots lastObject];
        _hotspotView.height = (lastHotSpot.line+1) * _hotspotView.buttonHeight + lastHotSpot.line*_hotspotView.minimumLineSpacing;
    }
    else{
        _hotspotView.height = 0;
    }
}

- (CGFloat)calculateViewHeightWithHotSpot:(NSArray *)hotspots{
    __block NSUInteger line = 0;
    __block CGFloat totalWidth = 0.f;
    __block NSUInteger totalCount = 0;
    const CGFloat limitWidth = CGRectGetWidth(_hotspotView.frame);
    [hotspots enumerateObjectsUsingBlock:^(id<GMYHotSpot> obj, NSUInteger idx, BOOL *stop) {
        CGSize textSize = [obj.title boundingRectWithSize:CGSizeMake(limitWidth, _hotspotView.buttonHeight)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_hotspotView.fontSize]}
                                                  context:nil].size;
        
        CGFloat tmp = textSize.width + 2*_hotspotView.titleSpace + _hotspotView.minimumInteritemSpacing * totalCount;;
        
        if( totalWidth + tmp <= limitWidth){
            totalWidth += tmp;
            totalCount += 1;
        }
        else{
            ++line;
            if(textSize.width + 2*_hotspotView.titleSpace <= limitWidth){
                totalWidth = textSize.width + 2*_hotspotView.titleSpace;
                totalCount = 1;
            }
            else{
                totalCount = 0;
                totalWidth = 0.f;
            }
        }
        
        if(line == _hotspotView.maxLines) *stop = YES;
    }];
    
    if(totalCount && line < _hotspotView.maxLines) ++line;
    
    return (MAX(0, line - 1)* _hotspotView.minimumLineSpacing + line * _hotspotView.buttonHeight);
}
@end
