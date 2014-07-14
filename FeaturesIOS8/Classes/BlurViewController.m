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

@end

@implementation BlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Blur effect
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [_blurView setFrame:CGRectMake(0,  _imageView.frame.origin.y, self.view.frame.size.width, _imageView.frame.size.height) ];
    [self.view addSubview:_blurView];
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
