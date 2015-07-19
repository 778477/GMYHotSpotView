//
//  ViewController.m
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/19.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import "ViewController.h"
#import "GMYHotSpotView.h"
#import "UIDevice+iOSVersion.h"
@interface ViewController ()
@property (nonatomic, strong) GMYHotSpotView *hotspotView;
@end

@implementation ViewController
#pragma mark -
#pragma mark - life cycle
- (instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.hotspotView];
}

#pragma mark -
- (GMYHotSpotView *)hotspotView{
    if(!_hotspotView){
        CGFloat yOffset = [[UIDevice currentDevice] systemVersionGeraterThanOrEqualTo:@"7.0"] ? 20.f :0.f;
        _hotspotView = [[GMYHotSpotView alloc] initWithFrame:CGRectMake(0, yOffset, self.view.frame.size.width, self.view.frame.size.height/2)];
        
        _hotspotView.backgroundColor = [UIColor blueColor];
    }
    return _hotspotView;
}
@end
