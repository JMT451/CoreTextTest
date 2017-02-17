//
//  UINavigationBar+Awesome.m
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>



@implementation UINavigationBar (Awesome)
static char overlayKey;
static char mtOverViewKey;
static char mtMaskViewKey;
- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIImageView *)mtOverView{
    return objc_getAssociatedObject(self, &mtOverViewKey);
}
-(void)setMtOverView:(UIImageView *)mtOverView{
    objc_setAssociatedObject(self, &mtOverViewKey, mtOverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)mtMaskView{
    return objc_getAssociatedObject(self, &mtMaskViewKey);
}
-(void)setMtMaskView:(UIView *)maskView{
    objc_setAssociatedObject(self, &mtMaskViewKey, maskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)lt_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)lt_setElementsAlpha:(CGFloat)alpha
{
#pragma mark -----hook的技巧
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];

    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
//    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}
-(void)mt_setTitleViewAlpha:(CGFloat)alpha{
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}
- (void)lt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
    [self.mtOverView removeFromSuperview];
    self.mtOverView=nil;
}
#pragma mark -----额外添加
-(void)mt_setBackgroundImage:(UIImage *)image withAlpha:(CGFloat)alpha{
    if (!self.mtOverView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.mtOverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.mtOverView.userInteractionEnabled = NO;
        self.mtOverView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.mtOverView atIndex:0];
        //
        if (!self.mtMaskView) {
            self.mtMaskView=[[UIView alloc]initWithFrame:self.mtOverView.bounds];
            self.mtMaskView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//            self.mtMaskView.userInteractionEnabled=YES;
        }
        self.mtOverView.maskView=self.mtMaskView;
    }
        self.mtOverView.image=image;
        self.mtMaskView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:alpha];
    [self insertSubview:self.mtOverView atIndex:0];
}

@end
