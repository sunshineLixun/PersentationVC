//
//  LX_Transtation.m
//  LX_PersentationVC
//
//  Created by liXun on 16/7/15.
//  Copyright © 2016年 lixun. All rights reserved.
//

#import "LX_Transtation.h"
#import "SencondViewController.h"

@interface LX_Transtation ()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, assign) BOOL isPresenting;

@end

@implementation LX_Transtation


- (id)initWithBool:(BOOL )isPresenting
{
    if (self == [super init]) {
        self.isPresenting = isPresenting;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    if (self.isPresenting) {
        //获得toView
        SencondViewController *toVC = (SencondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        //被呈现视图的View
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        //获取底层容器的View
        self.containerView = [transitionContext containerView];
        
        //获得被呈现视图的位置 将被呈现视图放到屏幕最下方
        CGRect initialFrame = [transitionContext finalFrameForViewController:toVC];
        
        CGRect startfarme = CGRectOffset(initialFrame, 0, initialFrame.size.height);
        
        toView.frame = startfarme;
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            //secondviewcontroller 滑上来
            toView.frame = initialFrame;
            
        } completion:^(BOOL finished) {
            if (finished) {
                
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }
        }];
    
    }else{
        
        
        
        UIView *formView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        
        self.containerView = [transitionContext containerView];
        
        [self.containerView addSubview:toView];

        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.0f options: UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGRect finalFrame = formView.frame;
            
            finalFrame.origin.y = self.containerView.frame.size.height;
            
            toView.frame = finalFrame;
            
        } completion:^(BOOL finished) {
            if (finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }
        }];
    }
}





@end
