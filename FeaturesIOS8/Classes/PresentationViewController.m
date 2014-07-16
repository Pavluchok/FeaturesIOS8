//
//  PresentationViewController.m
//  FeaturesIOS8
//
//  Created by vitaliy.pavlyuk on 7/15/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "PresentationViewController.h"

@interface PresentationViewController ()

@property (nonatomic, strong) UIView *backView;

@end

@implementation PresentationViewController

- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect frame = self.containerView.bounds;
    frame = CGRectInset(frame, 50.0, 50.0);
    return frame;
}


//called when presentation started
- (void)presentationTransitionWillBegin
{
    _backView = [[UIView alloc]initWithFrame:self.containerView.bounds];
    [_backView setBackgroundColor:[UIColor lightGrayColor]];
    [self.containerView addSubview:_backView];
    [_backView setAlpha:0.0f];
    
    id<UIViewControllerTransitionCoordinator> transition = [self.presentingViewController transitionCoordinator];
    [transition animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        [_backView setAlpha:0.8f];
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (!completed)
    {
        [_backView removeFromSuperview];
        _backView = nil;
    }
}

- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transition = [self.presentingViewController transitionCoordinator];
    [transition animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        [_backView setAlpha:0.0f];
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed)
    {
        [_backView removeFromSuperview];
        _backView = nil;
    }
}

@end
