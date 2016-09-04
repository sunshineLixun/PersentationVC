//
//  LX_Presentation.m
//  LX_PersentationVC
//
//  Created by liXun on 16/7/15.
//  Copyright © 2016年 lixun. All rights reserved.
//

#import "LX_Presentation.h"

@interface LX_Presentation ()
@property (nonatomic, strong)id<UIViewControllerTransitionCoordinator>transitionCoordinator;

//用来设置透明度的View
@property (nonatomic, strong) UIView *bgView;

//毛玻璃特效
@property (nonatomic, strong) UIVisualEffectView *visualView;

//最底层的View
@property (nonatomic, strong) UIView *contentView;

@end

@implementation LX_Presentation


//在呈现过渡将要开始时被调用的
- (void)presentationTransitionWillBegin
{
    //获得设置透明度视图的View
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //创建毛玻璃
    self.visualView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    //容器视图 最底层
    self.visualView.frame = self.containerView.bounds;
    //将透明度View插入到毛玻璃的最下层
    [self.bgView insertSubview:self.visualView atIndex:0];
    
    //获得最底层容器View
    self.contentView = self.containerView;
    
    //将所有的View都添加到最底层View上
    [self.contentView addSubview:self.bgView];
    
    //将呈现的视图的view添加到底层view上
    [self.contentView addSubview:self.presentingViewController.view];
    //将将要被呈现的视图添加到底层view上
    [self.contentView addSubview:self.presentedView];
    
    
    self.bgView.alpha = 0;

    //获得呈现视图的过渡协调器
    self.transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.bgView.alpha = 0.7;
        //设置呈现视图缩放
        self.presentingViewController.view.transform = CGAffineTransformScale(self.presentingViewController.view.transform, 0.92, 0.92);
    } completion:nil];
    
    
}

- (BOOL)shouldRemovePresentersView
{
    return NO;
}

//在呈现过渡结束时被调用的
- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (!completed) {
        [self.bgView removeFromSuperview];
    }
}

//在退出过渡即将开始的时候被调用的
- (void)dismissalTransitionWillBegin
{
    self.transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.bgView.alpha = 0;
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}
//在退出的过渡结束时被调用的
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed) {
        [self.bgView removeFromSuperview];
    }
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.presentingViewController.view];
}


- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect farme = self.containerView.bounds;
    
    CGRect frame2 = CGRectMake(farme.origin.x, farme.origin.y + 100, farme.size.width, farme.size.height - 100);
    
    return frame2;
}

#pragma mark - getter
//设置被呈现视图的圆角
- (UIView *)presentedView
{
    UIView *presented = self.presentedViewController.view;
    presented.layer.cornerRadius = 8.f;
    return presented;
}

@end
