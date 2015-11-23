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
@implementation GMYHotSpotViewBetterLayout
@synthesize hotspotView = _hotspotView;
#pragma mark - Override
- (void)layoutHotSpotView:(NSArray *)hotspots eachLineCompletion:(eachLineCompletion)completion{
    NSMutableArray *models = [NSMutableArray arrayWithArray:hotspots];
    NSInteger count = models.count;
    int line = 0;
    
    while (count > 0) {
        NSArray *arr = [self adjustHotspotsSort:models limitWidth:CGRectGetWidth(_hotspotView.frame)];

        [arr enumerateObjectsUsingBlock:^(id<GMYHotSpot> obj, NSUInteger idx, BOOL *stop) {
            obj.line = line;
        }];
        
        completion(line,arr);
        line++;
        count -= arr.count;
        [models removeObjectsInArray:arr];
    }
}

- (void)updateHotSpotViewLayoutByRemoveHotspot:(id<GMYHotSpot>)hotspot{
    
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

#pragma mark - 01 knapsack
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
     *  CGfloat to int64_t lost accuracy
     */
    int64_t v = limitWidth;
    int64_t n = hotspots.count;
    int64_t itemspace =_hotspotView.minimumInteritemSpacing;
    int64_t *value = (int64_t *)malloc(n * sizeof(int64_t));
    int64_t *weight = (int64_t *)malloc(n * sizeof(int64_t));
    int64_t *dp = (int64_t *)malloc(2 * v * sizeof(int64_t));
    
    [hotspots enumerateObjectsUsingBlock:^(id<GMYHotSpot> obj, NSUInteger idx, BOOL *stop) {
        value[idx] = weight[idx] = (int64_t)([obj.title boundingRectWithSize:CGSizeMake(limitWidth, _hotspotView.buttonHeight)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_hotspotView.fontSize]}
                                                            context:nil].size.width + 2*_hotspotView.titleSpace );

    
    }];
    
    bool path[n][v];   // mark the path
    bool flag = false; // mark the first object,becase the first not need itemspace [hotspot1] -> itemSpace<- [hotspot2]
    memset(dp, 0,  2 * v * sizeof(int64_t));
    memset(path, false, n*v*sizeof(bool));
    
    for(int64_t i = 0; i < n ; i++){
        for(int64_t j = v; j >= weight[i];j--){
            if(flag){
                if(j >= weight[i] + itemspace && dp[j - weight[i] - itemspace] + value[i] > dp[j]){
                    dp[j] = dp[j - weight[i] - itemspace] + value[i];
                    path[i][j] = true;
                }
            }
            else if(dp[j - weight[i]] + value[i] > dp[j]){
                dp[j] = dp[j - weight[i]] + value[i];
                flag = true;
                path[i][j] = true;
            }
        }
    }
    
    int64_t i = n-1, j = v;
    flag = false;
    while(i>-1 && j >-1){
        if(path[i][j]){
            j = j - weight[i] - (flag ? itemspace : 0);
            [ans addObject:hotspots[i]];
            flag = true;
        }
        i--;
    }
    free(value);
    free(weight);
    free(dp);
    return ans;
}

@end
