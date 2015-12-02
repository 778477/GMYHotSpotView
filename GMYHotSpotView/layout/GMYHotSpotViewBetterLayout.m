//
//  GMYHotSpotViewBetterLayout.m
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/26.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import "GMYHotSpotViewBetterLayout.h"
#import "GMYHotSpotView.h"
#import "GMYHotSpot.h"
#import "UIView+EX.h"
#import "GMYHotSpotViewDefines.h"
typedef long long Int64;
typedef unsigned long uInt64;

@implementation GMYHotSpotViewBetterLayout
@synthesize hotspotView = _hotspotView;
#pragma mark - Override
- (void)layoutHotSpotView:(NSArray *)hotspots eachLineCompletion:(eachLineCompletion)completion{
    NSMutableArray *models = [NSMutableArray arrayWithArray:hotspots];
    NSInteger count = models.count;
    int line = 0;
    [_hotspotView.hotspots removeAllObjects];
    while (count > 0) {
        NSArray *arr = [self adjustHotspotsSort:models limitWidth:_hotspotView.width];
        [_hotspotView.hotspots addObjectsFromArray:arr];
        [arr enumerateObjectsUsingBlock:^(id<GMYHotSpot> obj, NSUInteger idx, BOOL *stop) {
            obj.line = line;
            
            printf("%s ",[obj.title UTF8String]);
        }];
        printf("\n");
        completion(line,arr);
        line++;
        count -= arr.count;
        [models removeObjectsInArray:arr];
    }
}

- (void)updateHotSpotViewLayoutByRemoveHotspot:(id<GMYHotSpot>)hotspot withRemovedSpot:(UIView *)spotView{
    NSMutableArray *modelShoots = [_hotspotView.hotspots mutableCopy];
    NSMutableArray *models = [_hotspotView.hotspots mutableCopy];
    NSMutableArray *rejusetViews = [NSMutableArray arrayWithCapacity:models.count];
    [_hotspotView.hotspots removeAllObjects];
    __block CGFloat offsetX = 0.f;
    NSUInteger nowLine = 0;
    
    while (models.count >= 1) {
        NSArray *adjustModels = [self adjustHotspotsSort:models limitWidth:_hotspotView.width];
        
        [adjustModels enumerateObjectsUsingBlock:^(id<GMYHotSpot> obj, NSUInteger idx, BOOL *stop) {
            UIView *view = [_hotspotView viewWithTag:[modelShoots indexOfObject:obj] + kGMYHotSpotViewTagBaseIndex];
            
            [UIView animateWithDuration:0.3f animations:^{
                view.point = CGPointMake(offsetX, nowLine*_hotspotView.buttonHeight + nowLine*_hotspotView.minimumLineSpacing);
            }];
            
            [rejusetViews addObject:view];
            offsetX += (view.width + _hotspotView.minimumInteritemSpacing);
            obj.line = nowLine;
            printf("%s ",[obj.title UTF8String]);
        }];
         printf("\n");
        nowLine++;
        offsetX = 0.f;
        [models removeObjectsInArray:adjustModels];
        [_hotspotView.hotspots addObjectsFromArray:adjustModels];
    }
    
    [rejusetViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        obj.tag = idx + kGMYHotSpotViewTagBaseIndex;
    }];
    
    if(_hotspotView.hotspots.count >= 1){
        id<GMYHotSpot> lastHotSpot = [_hotspotView.hotspots lastObject];
        _hotspotView.height = (lastHotSpot.line+1) * _hotspotView.buttonHeight + lastHotSpot.line*_hotspotView.minimumLineSpacing;
    }
    else{
        _hotspotView.height = 0;
    }
}

- (CGFloat)calculateViewHeightWithHotSpot:(NSArray *)hotspots{
    NSUInteger line = 0;
    NSMutableArray *models = [NSMutableArray arrayWithArray:hotspots];
    NSUInteger count = models.count;
    while (line < _hotspotView.maxLines && count > 0) {
        NSArray *arr = [self adjustHotspotsSort:models limitWidth:CGRectGetWidth(_hotspotView.frame)];
        count -= arr.count;
        [models removeObjectsInArray:arr];
        line++;
    }
    return (MAX(0, line - 1) * _hotspotView.minimumLineSpacing + line* _hotspotView.buttonHeight);
}

#pragma mark - 01 背包
/**
 *  f[i,j] = Max{f[i-1,j-Wi]+Pi( j >= Wi ),  f[i-1,j]}
 *  f[i,j] 表示在前i件物品中选择若干件放在承重为 j 的背包中，可以取得的最大价值。
 *  *承重j为 limitWidth, CGRectgetWidth(hotspotView)，即视图的宽度
 *  *Wi 为第i个hotspot所占的宽度， boundingRectWithSize....
 *  *Pi 为第i个hotspot的价值，这里我们也用自身的宽度表示， 因为我们希望一个好的热点布局，一行是没有剩余空间的(类似内存对齐的概念)
 *
 *  @param hotspots   所有物品
 *  @param limitWidth 背包容量
 *
 *  @return 当前所有物品中 能放入背包且总价值最高
 */
- (NSArray *)adjustHotspotsSort:(NSArray *)hotspots limitWidth:(CGFloat)limitWidth{
    NSMutableArray *ans = [[NSMutableArray alloc] initWithCapacity:5];
    /**
     *  CGfloat to unsigned long lost accuracy
     */
    uInt64 v = limitWidth;
    uInt64 n = hotspots.count;
    uInt64 itemspace =_hotspotView.minimumInteritemSpacing;
    uInt64 *value = (uInt64 *)malloc(n * sizeof(uInt64));
    uInt64 *weight = (uInt64 *)malloc(n * sizeof(uInt64));
    uInt64 *dp = (uInt64 *)malloc(2 * v * sizeof(unsigned long));
    
    
    [hotspots enumerateObjectsUsingBlock:^(id<GMYHotSpot> obj, NSUInteger idx, BOOL *stop) {
        value[idx] = weight[idx] = ceilf(([obj.title boundingRectWithSize:CGSizeMake(limitWidth, _hotspotView.buttonHeight)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_hotspotView.fontSize]}
                                                            context:nil].size.width + 2*_hotspotView.titleSpace ));
    }];

    memset(dp, 0,  2 * v * sizeof(uInt64));
    bool path[v][n];
    memset(path, false, sizeof(bool)*v*n);
    
    Int64 tmpval = 0;
    for(Int64 i = 0; i < n ; i++){
        for(Int64 j = v; j >= weight[i];j--){
            if(dp[j]) tmpval = weight[i] + itemspace;
            else tmpval = weight[i];
            
            if(j >= tmpval && dp[j - tmpval] + value[i] > dp[j]){
                dp[j] = dp[j - tmpval] + value[i];
                
                path[dp[j]][i] = true;
            }
        }
    }
    
    Int64 val = dp[v];
    unsigned index = 0;
    printf("value : %lld \n",val);
    while (val > 0) {
        for(int i=0;i<n;i++){
            if(path[val][i]){
                index = i;
                break;
            }
        }
        [ans addObject:hotspots[index]];
        val -= weight[index];
        printf("weights : %lu\n",weight[index]);
    }
    printf("\n");
    
    free(value);
    free(weight);
    free(dp);
    return ans;
}

@end
