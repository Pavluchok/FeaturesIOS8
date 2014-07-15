//
//  BlurViewController.m
//  FeaturesIOS8
//
//  Created by vitaliy.pavlyuk on 7/14/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "BlurViewController.h"

@interface BlurViewController ()

@property (nonatomic, strong) UIVisualEffectView *blurView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISwitch *blurSwitch;

@end

@implementation BlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Blur effect
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [_blurView setFrame:CGRectMake(0,  _imageView.frame.origin.y, self.view.frame.size.width, _imageView.frame.size.height) ];
    [_blurView setAlpha:0.0f];
    [self.view addSubview:_blurView];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.5 animations:^{
        [_blurView setAlpha:1.0f];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeSwithState:(id)sender
{
    UISwitch *switchControl = (UISwitch *)sender;
    [_blurView setHidden:![switchControl isOn]];
}
- (IBAction)changeBlurStyle:(id)sender
{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    
    [_blurView removeFromSuperview];
    
    CGRect blurFrame = [_blurView frame];
    _blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:[segment selectedSegmentIndex]]];
    [_blurView setFrame:blurFrame];
    [_blurView setHidden:![_blurSwitch isOn]];
    
    [self.view addSubview:_blurView];
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
