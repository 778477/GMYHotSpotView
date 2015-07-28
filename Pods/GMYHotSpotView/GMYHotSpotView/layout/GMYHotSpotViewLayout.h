//
//  GMYHotSpotViewLayout.h
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/19.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GMYHotSpotView;
typedef void(^eachLineCompletion)(NSInteger line,NSArray *fixedHotspots);
@protocol GMYHotSpotViewLayout <NSObject>
@required
@property (nonatomic, weak) GMYHotSpotView *hotspotView;
- (void)layoutHotSpotView:(NSArray *)hotspots eachLineCompletion:(eachLineCompletion)completion;
@end
