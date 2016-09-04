//
//  SencondViewController.m
//  LX_PersentationVC
//
//  Created by liXun on 16/7/15.
//  Copyright © 2016年 lixun. All rights reserved.
//

#import "SencondViewController.h"
#import "LX_Transtation.h"
#import "LX_Presentation.h"

@interface SencondViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation SencondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[LX_Presentation alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[LX_Transtation alloc] initWithBool:YES];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    if (dismissed) {
        LX_Transtation * present = [[LX_Transtation alloc]initWithBool:NO];
        return present;
    }else{
        return nil;
    }
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
