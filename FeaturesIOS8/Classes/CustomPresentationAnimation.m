//
//  CustomPresentationAnimation.m
//  FeaturesIOS8
//
//  Created by vitaliy.pavlyuk on 7/16/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "CustomPresentationAnimation.h"

static CGFloat const kAnimationDuration = 0.5;

@interface CustomPresentationAnimation ()

@property (nonatomic, assign) BOOL isPresenting;

@end

@implementation CustomPresentationAnimation

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _isPresenting = YES;
    }
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return kAnimationDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (_isPresenting)
    {
        [self animatePresentationWithTransitionContext:transitionContext];
    }
}

- (void)animatePresentationWithTransitionContext:(id<UIViewControllerContextTransitioning>)context
{
    UIViewController *presentedVC = [context viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *presentedControllerView = [context viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [context containerView];
    
    [presentedControllerView setFrame:[context finalFrameForViewController:presentedVC]];
    presentedControllerView.transform = CGAffineTransformMakeRotation(M_PI);
    
    [containerView addSubview:presentedControllerView];
    
    [UIView animateWithDuration:kAnimationDuration delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^
     {
         presentedControllerView.transform = CGAffineTransformMakeRotation(M_PI*2);
     }
    completion:^(BOOL completion){
        [context completeTransition:completion];
    }];
}

@end
