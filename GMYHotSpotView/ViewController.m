//
//  ViewController.m
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/19.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import "ViewController.h"
#import "GMYHotSpotView.h"
#import "GMYHotSpotViewNormalLayout.h"
#import "GMYHotSpotModel.h"
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
    /**
     *  https://top.taobao.com/index.php?spm=a1z5i.1.2.1.hUTg2J&topId=HOME
     */
    NSArray *arr = @[@"立体涂鸦笔",@"紫外线牙刷消毒器",@"茶桌椅组合",@"雨伞",@"大圣归来公仔",@"套装女夏装2015",@"苹果6手机壳",@"秘密花园",@"沙滩裙",@"跑步机",@"皮鞋",@"水杯",@"凉鞋女",@"夹烟机 钓烟机",@"婚纱",@"iphone6plus手机壳",@"花盆",@"茶具",@"背带裙",@"对讲机"];
    NSArray *formatedArr = [self formatHotspot:arr];
    
    [self.hotspotView updateHotSpotWithArray:formatedArr ClickHandle:^(NSInteger index, NSString *title) {
        NSLog(@"%ld - %@",index,title);
    }];
    
    [self.view addSubview:self.hotspotView];
}

#pragma mark -
- (GMYHotSpotView *)hotspotView{
    if(!_hotspotView){
        CGFloat yOffset = [[UIDevice currentDevice] systemVersionGeraterThanOrEqualTo:@"7.0"] ? 20.f :0.f;
        _hotspotView = [[GMYHotSpotView alloc] initWithFrame:CGRectMake(5, yOffset, self.view.frame.size.width - 10, self.view.frame.size.height/2) hotspotViewLayout:[GMYHotSpotViewNormalLayout new]];
        
//        _hotspotView.backgroundColor = [UIColor blueColor];
    }
    return _hotspotView;
}

- (NSArray *)formatHotspot:(NSArray *)arr{
    NSMutableArray *models = [[NSMutableArray alloc] initWithCapacity:arr.count];
    [arr enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL *stop) {
        GMYHotSpotModel *model = [[GMYHotSpotModel alloc] initWithTitle:obj Line:0];
        [models addObject:model];
    }];
    return [models copy];
}
@end
