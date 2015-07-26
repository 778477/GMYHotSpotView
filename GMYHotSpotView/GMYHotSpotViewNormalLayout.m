//
//  GMYHotSpotViewNormalLayout.m
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/19.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import "GMYHotSpotViewNormalLayout.h"
#import "GMYHotSpotView.h"
#import "GMYHotSpot.h"
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
            if(textSize.width + lineTotalWidth + itemSpace + 2*_hotspotView.titleSpace> limitWidth){
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
@end
