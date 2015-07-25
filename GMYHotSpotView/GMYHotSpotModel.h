//
//  GMYHotSpotModel.h
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/25.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMYHotSpot.h"
@interface GMYHotSpotModel : NSObject<GMYHotSpot>
- (instancetype)initWithTitle:(NSString *)title Line:(NSInteger)line;
@end
