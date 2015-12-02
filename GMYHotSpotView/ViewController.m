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
#import "GMYHotSpotViewBetterLayout.h"
#import "GMYHotSpotModel.h"
#import "UIDevice+iOSVersion.h"
#import "UIView+EX.h"
@interface ViewController ()
@property (nonatomic, strong) GMYHotSpotView *hotspotView;
@property (nonatomic, strong) GMYHotSpotView *hotspotView1;
@end

@implementation ViewController
#pragma mark -
#pragma mark - Life cycle
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
    
    
    NSArray *formatArr1 = [self formatHotspot:arr];
    [self.hotspotView1 updateHotSpotWithArray:formatArr1 ClickHandle:^(NSInteger index, NSString *title) {
        NSLog(@"%ld - %@",index,title);
    }];
    [self.view addSubview:self.hotspotView1];
    
    
    // Debug Tool
    UIButton *resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    resetBtn.point = CGPointMake(self.view.width/2 - 30, self.view.height - 80);
    resetBtn.layer.masksToBounds = YES;
    resetBtn.layer.borderWidth = 1.f;
    resetBtn.layer.cornerRadius = 2.f;
    resetBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [resetBtn setTitle:@"reset" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetHotSpotView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetBtn];
}

#pragma mark - Lzay Load subView
- (GMYHotSpotView *)hotspotView{
    if(!_hotspotView){
        CGFloat yOffset = [[UIDevice currentDevice] systemVersionGeraterThanOrEqualTo:@"7.0"] ? 20.f :0.f;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, yOffset, self.view.width, 20.f)];
        label.text = @"NormalLayout : ";
        [self.view addSubview:label];
        _hotspotView = [[GMYHotSpotView alloc] initWithFrame:CGRectMake(5, label.bottom, self.view.width - 10, self.view.height/2)
                                           hotspotViewLayout:[GMYHotSpotViewNormalLayout new]];
    }
    return _hotspotView;
}

- (GMYHotSpotView *)hotspotView1{
    if(!_hotspotView1){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.hotspotView.bottom + 20, self.view.width, 20.f)];
        label.text = @"BetterLayout : ";
        [self.view addSubview:label];
        _hotspotView1 = [[GMYHotSpotView alloc] initWithFrame:CGRectMake(5, label.bottom, self.view.width - 10, self.view.height/2)
                                            hotspotViewLayout:[GMYHotSpotViewBetterLayout new]];
    }
    return _hotspotView1;
}

#pragma mark - Model Format
- (NSArray *)formatHotspot:(NSArray *)arr{
    NSMutableArray *models = [[NSMutableArray alloc] initWithCapacity:arr.count];
    [arr enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL *stop) {
        GMYHotSpotModel *model = [[GMYHotSpotModel alloc] initWithTitle:obj Line:0];
        [models addObject:model];
    }];
    return [models copy];
}
#pragma mark - Debug & ResetButton Action
- (void)resetHotSpotView:(id)sender{
    NSArray *arr = @[@"立体涂鸦笔",@"紫外线牙刷消毒器",@"茶桌椅组合",@"雨伞",@"大圣归来公仔",@"套装女夏装2015",@"苹果6手机壳",@"秘密花园",@"沙滩裙",@"跑步机",@"皮鞋",@"水杯",@"凉鞋女",@"夹烟机 钓烟机",@"婚纱",@"iphone6plus手机壳",@"花盆",@"茶具",@"背带裙",@"对讲机"];
    
    NSArray *formatedArr = [self formatHotspot:arr];
    [self.hotspotView updateHotSpotWithArray:formatedArr ClickHandle:^(NSInteger index, NSString *title) {
        NSLog(@"%ld - %@",index,title);
    }];
    
    
    NSArray *formatArr1 = [self formatHotspot:arr];
    [self.hotspotView1 updateHotSpotWithArray:formatArr1 ClickHandle:^(NSInteger index, NSString *title) {
        NSLog(@"%ld - %@",index,title);
    }];
}
@end
