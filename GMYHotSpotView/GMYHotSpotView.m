//
//  GMYHotSpotView.m
//  GMYHotSpotView
//
//  Created by 郭妙友 on 15/7/19.
//  Copyright (c) 2015年 miaoyou.gmy. All rights reserved.
//

#import "GMYHotSpotView.h"
#import "GMYHotSpot.h"
#import "GMYHotSpotViewLayout.h"
#import "GMYHotSpotViewNormalLayout.h"
#import "UIView+EX.h"
#import "GMYImage.h"


static const NSInteger tagBaseIndex = 101;
@interface GMYHotSpotView(){
    NSMutableArray *_hotspots;
    id<GMYHotSpotViewLayout> _hotspotViewLayout;
}
/**
 *  热点视图 当前状态(正常状态,编辑状态)
 */
@property (nonatomic, assign) HotspotState state;
@end

@implementation GMYHotSpotView
#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame hotspotViewLayout:(id<GMYHotSpotViewLayout>)layout{
    if(self =[super initWithFrame:frame]){
        _hotspotViewLayout = layout;
        _hotspotViewLayout.hotspotView = self;
        
        self.fontSize = 14.f;
        self.buttonHeight = 20.f;
        self.buttonWidth = 70.f;
        self.minimumInteritemSpacing = 5.f;
        self.minimumLineSpacing = 5.f;
        self.titleSpace = 15.f;
        self.buttonBackgroundColor = [UIColor whiteColor];
        self.buttonTitleColor = [UIColor blackColor];
        
        self.maxLines = INT32_MAX;
        
        UIGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAtHotspotView:)];
        [self addGestureRecognizer:longPressGesture];
        
        // FIXME
        self.backgroundColor = [UIColor blackColor]; // text code
    }
    return self;
}

#pragma mark - Public Method
- (void)updateHotSpotWithArray:(NSArray *)hotspots ClickHandle:(HotspotClickHandle)clickHandle{
    [self p_clean];
    _hotspots = [hotspots copy];
    _clickHandle = clickHandle;
    __block NSInteger finalLines = self.maxLines > 0 ? self.maxLines : hotspots.count;
    
    [_hotspotViewLayout layoutHotSpotView:hotspots eachLineCompletion:^(NSInteger line, NSArray *fixedHotspots) {
        if (line < self.maxLines) {
            finalLines = line + 1;
            [self layoutHotspots:fixedHotspots];
        }
    }];
    
    self.height = MAX(0, finalLines - 1)*_minimumLineSpacing + (finalLines) * _buttonHeight;
}

- (CGFloat)calcluateViewHeightWithHotspots:(NSArray *)hotspots{
    return [_hotspotViewLayout calculateViewHeightWithHotSpot:hotspots];
}


// TODO
- (void)layoutHotspots:(NSArray *)hotspots{
    __block  CGFloat xOffset = 0.f;
    [hotspots enumerateObjectsUsingBlock:^(id<GMYHotSpot> obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] init];
        
        CGSize textSize = [obj.title boundingRectWithSize:CGSizeMake(self.frame.size.width, _buttonHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_fontSize]} context:nil].size;
        
        
        button.frame = CGRectMake(xOffset, _minimumLineSpacing*MAX(0, obj.line) + obj.line*_buttonHeight, textSize.width + 2*_titleSpace, _buttonHeight);
        button.layer.borderWidth = 0.5f;
        button.layer.borderColor =[UIColor grayColor].CGColor;
        button.layer.cornerRadius = 2.f;
        button.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        button.backgroundColor = self.buttonBackgroundColor;
        [button setTitle:obj.title forState:UIControlStateNormal];
        [button setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickHotspot:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(button.width - 10, (button.height - 8)/2, 8, 8)];
        imgView.image = [GMYImage imageNamed:@"tagdelete_white"];
        imgView.tag = 8;
        [button addSubview:imgView];
        imgView.hidden = YES;
        
        button.tag = tagBaseIndex + [_hotspots indexOfObject:obj];
        [self addSubview:button];
        xOffset += (button.frame.size.width + _minimumInteritemSpacing);
    }];
}
#pragma mark - Private Mathod
- (void)clickHotspot:(UIButton *)sender{
    if(_clickHandle){
        id<GMYHotSpot> spot = _hotspots[sender.tag - tagBaseIndex];
        _clickHandle(sender.tag - tagBaseIndex, spot.title);
    }
}
- (void)p_clean{
    [_hotspots removeAllObjects];
}
#pragma mark - UILongPressGestureRecognizer Action
- (void)longPressAtHotspotView:(UILongPressGestureRecognizer *)GestureRecognizer{
    if(GestureRecognizer.state != UIGestureRecognizerStateBegan) return;
    self.state = !self.state;
    if(self.state == HotspotStateEditing){
        [self.subviews enumerateObjectsUsingBlock:^(UIButton* obj, NSUInteger idx, BOOL *stop) {
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                obj.backgroundColor = [UIColor grayColor];
                [obj setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [obj setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.titleSpace, 0, self.titleSpace)];
            } completion:^(BOOL finished) {
                if(finished){
                    UIView *subView = [obj viewWithTag:8];
                    [UIView animateWithDuration:0.3f animations:^{
                        subView.hidden = NO;
                    }];
                }
            }];
        }];
    }
    else{
        [self.subviews enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                obj.backgroundColor = self.buttonBackgroundColor;
                [obj setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
                [obj setTitleEdgeInsets:UIEdgeInsetsZero];
            } completion:^(BOOL finished) {
                if(finished){
                    UIView *subView = [obj viewWithTag:8];
                    [UIView animateWithDuration:0.3f animations:^{
                        subView.hidden = YES;
                    }];
                }
            }];
        }];
    }
}

@end
