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
#import "GMYHotSpotViewDefines.h"

static const CGFloat kGMYHotspotViewCenterLimit = 20.f;

@interface GMYHotSpotView()
@property (nonatomic, strong) id<GMYHotSpotViewLayout> hotspotViewLayout;
@property (nonatomic, assign) HotspotState state;
@property (nonatomic, strong) UIView *catchedView;
@property (nonatomic, assign) CGPoint savePoint;
@end
@implementation GMYHotSpotView
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame hotspotViewLayout:(id<GMYHotSpotViewLayout>)layout{
    if(self =[super initWithFrame:frame]){
        _hotspotViewLayout = layout;
        _hotspotViewLayout.hotspotView = self;
        // defalut value
        self.fontSize = 14.f;
        self.buttonHeight = 20.f;
        self.buttonWidth = 70.f;
        self.minimumInteritemSpacing = 5.f;
        self.minimumLineSpacing = 5.f;
        self.titleSpace = 15.f;
        self.buttonBackgroundColor = [UIColor whiteColor];
        self.buttonTitleColor = [UIColor blackColor];
        
        self.maxLines = INT32_MAX;
        
        UIGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(longPressAtHotspotView:)];
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}

#pragma mark - Public Method
- (void)updateHotSpotWithArray:(NSArray<id<GMYHotSpot> > *)hotspots ClickHandle:(HotspotClickHandle)clickHandle{
    [self clean];
    self.hotspots = [hotspots mutableCopy];
    _clickHandle = clickHandle;
    __block NSInteger finalLines = self.maxLines > 0 ? self.maxLines : hotspots.count;
    
    [self.hotspotViewLayout layoutHotSpotView:hotspots eachLineCompletion:^(NSInteger line, NSArray *fixedHotspots) {
        if (line < self.maxLines) {
            finalLines = line + 1;
            [self layoutHotspots:fixedHotspots];
        }
    }];
    
    self.height = MAX(0, finalLines - 1)*_minimumLineSpacing + (finalLines) * _buttonHeight;
}

- (CGFloat)calcluateViewHeightWithHotspots:(NSArray<GMYHotSpot> *)hotspots{
    return [self.hotspotViewLayout calculateViewHeightWithHotSpot:hotspots];
}


// TODO
- (void)layoutHotspots:(NSArray<id<GMYHotSpot> > *)hotspots{
    __block  CGFloat xOffset = 0.f;
    [hotspots enumerateObjectsUsingBlock:^(id<GMYHotSpot> obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] init];
        CGSize textSize = [obj.title boundingRectWithSize:CGSizeMake(self.frame.size.width, _buttonHeight)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_fontSize]} context:nil].size;
        button.frame = CGRectMake(xOffset, _minimumLineSpacing*MAX(0, obj.line) + obj.line*_buttonHeight, textSize.width + 2*_titleSpace, _buttonHeight);
        button.layer.borderWidth = 0.5f;
        button.layer.borderColor =[UIColor grayColor].CGColor;
        button.layer.cornerRadius = 2.f;
        button.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        button.backgroundColor = self.buttonBackgroundColor;
        [button setTitle:obj.title forState:UIControlStateNormal];
        [button setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickHotspot:) forControlEvents:UIControlEventTouchUpInside];
        if(self.state == HotspotStateEditing){
            button.backgroundColor = [UIColor grayColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.titleSpace, 0, self.titleSpace)];
        }
        
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(button.width - 10, (button.height - 8)/2, 8, 8)];
        imgView.image = [GMYImage imageNamed:@"tagdelete_white"];
        imgView.tag = 8;
        [button addSubview:imgView];
        if(self.state == HotspotStateNormal) imgView.hidden = YES;
        button.tag = kGMYHotSpotViewTagBaseIndex + [self.hotspots indexOfObject:obj];
        
        [self addSubview:button];
        xOffset += (button.frame.size.width + _minimumInteritemSpacing);
        
        [button addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
    }];
}
#pragma mark - Private Mathod
- (void)clickHotspot:(UIButton *)sender{
    if(self.state == HotspotStateEditing){
        id <GMYHotSpot> hotspot = self.hotspots[sender.tag - kGMYHotSpotViewTagBaseIndex];
        [self.hotspots removeObject:hotspot];
        [sender removeObserver:self forKeyPath:@"center"];
        [sender removeFromSuperview];
        NSInteger indexTag = sender.tag;
        while (indexTag + 1 <= kGMYHotSpotViewTagBaseIndex + self.hotspots.count) {
            UIView *view = [self viewWithTag:indexTag + 1];
            view.tag = indexTag++;
        }
        
        [self.hotspotViewLayout updateHotSpotViewLayoutByRemoveHotspot:hotspot withRemovedSpot:sender];
    }
    else if(self.state == HotspotStateNormal && _clickHandle){
        id<GMYHotSpot> spot = self.hotspots[sender.tag - kGMYHotSpotViewTagBaseIndex];
        _clickHandle(sender.tag - kGMYHotSpotViewTagBaseIndex, spot.title);
    }
}

- (void)updateHotSpotViewState{
    self.state = !self.state;
    if(self.state == HotspotStateEditing){
        [self.subviews enumerateObjectsUsingBlock:^(UIButton* obj, NSUInteger idx, BOOL *stop) {
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
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
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
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

- (void)clean{
    [self.hotspots removeAllObjects];
    [self.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj removeObserver:self forKeyPath:@"center"];
        [obj removeFromSuperview];
    }];
}
#pragma mark - UILongPressGestureRecognizer Action
- (void)setIgonreLongPress:(BOOL)igonreLongPress{
    if(igonreLongPress){
        [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:[UILongPressGestureRecognizer class]]){
                [self removeGestureRecognizer:obj];
                *stop = YES;
            }
        }];
    }
    else{
        __block BOOL hasLongPress = NO;
        [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:[UILongPressGestureRecognizer class]]){
                hasLongPress = YES;
                *stop = YES;
            }
        }];
        
        if(!hasLongPress){
            [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAtHotspotView:)]];
        }
    }
}

- (void)longPressAtHotspotView:(UILongPressGestureRecognizer *)gestureRecognizer{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
//            printf("Began\n");
            [self updateHotSpotViewState];
            if(self.state == HotspotStateNormal) break;
            CGPoint point =  [gestureRecognizer locationInView:self];
            [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if(CGRectContainsPoint(obj.frame,point)){
                    self.savePoint = obj.point;
                    self.catchedView = obj;
                    [UIView animateWithDuration:0.3f animations:^{
                        obj.transform = CGAffineTransformMakeScale(1.05,1.05);
                        obj.layer.zPosition = INT_MAX;
                    }];
                    *stop = true;
                }
            }];
            
            break;
        }
        case UIGestureRecognizerStateChanged:{
//            printf("Changed\n");
            self.catchedView.center = [gestureRecognizer locationInView:self];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            [UIView animateWithDuration:0.3f animations:^{
                self.catchedView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                self.catchedView.layer.zPosition = 0.f;
                self.catchedView.point = self.savePoint;
            }];
            self.catchedView = nil;
//            printf("Ended\n");
            break;
        }
        case UIGestureRecognizerStateCancelled:{
//            printf("Cancelled\n");
            break;
        }
        case UIGestureRecognizerStateFailed:{
//            printf("Failed\n");
            break;
        }
        case UIGestureRecognizerStatePossible:{
//            printf("Possible\n");
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - KVO Center
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"center"]){
        __block NSInteger rangerIdx = -1;
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj != self.catchedView){
                CGFloat distance = sqrt((self.catchedView.center.x - obj.center.x)*(self.catchedView.center.x - obj.center.x) + (self.catchedView.center.y - obj.center.y)*(self.catchedView.center.y - obj.center.y));
                
                BOOL isVaild = self.width - obj.right > self.catchedView.width;
                
                if(distance - kGMYHotspotViewCenterLimit < 1e-6 && isVaild){
                    printf("%lu",idx);
                    rangerIdx = idx;
                    *stop = YES;
                }
            }
        }];
        
        if(rangerIdx != -1){
            // TODO move
        }
    }
}

@end
