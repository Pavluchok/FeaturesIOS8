//
//  CustomPopoverViewController.m
//  FeaturesIOS8
//
//  Created by vitaliy.pavlyuk on 7/15/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "CustomPopoverViewController.h"
#import "PresentationViewController.h"
#import "CustomPresentationAnimation.h"

@interface CustomPopoverViewController ()

@end

@implementation CustomPopoverViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setTransitioningDelegate:self];
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    if (presented == self)
    {
        return [[PresentationViewController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    }
    
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if(presented == self)
    {
        return [CustomPresentationAnimation new];
    }
    else
    {
        return nil;
    }
}

- (IBAction)dismissPopover:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
