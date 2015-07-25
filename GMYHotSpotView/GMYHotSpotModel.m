//
//  GMYHotSpotModel.m
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/25.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import "GMYHotSpotModel.h"

@implementation GMYHotSpotModel
@synthesize title = _title;
@synthesize line = _line;

- (instancetype)initWithTitle:(NSString *)title Line:(NSInteger)line{
    if(self = [super init]){
        self.title = title;
        self.line = line;
    }
    return self;
}
@end
