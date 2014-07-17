//
//  ContainerViewController.m
//  FeaturesIOS8
//
//  Created by vitaliy.pavlyuk on 7/17/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "ContainerViewController.h"
#import "SplitViewController.h"

@interface ContainerViewController ()

@property (weak, nonatomic) IBOutlet UIView *ContainerView;
@property (nonatomic, strong) SplitViewController *splitVC;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    _splitVC = [sb instantiateViewControllerWithIdentifier:@"splitVC"];
    [self addChildViewController:_splitVC];
    [_splitVC didMoveToParentViewController:self];
     _splitVC.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    
    [self.view addSubview:_splitVC.view];
    [self.view sendSubviewToBack:_splitVC.view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapButton:(id)sender
{
    UITraitCollection *traitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:
                                          (_splitVC.isCollapsed ? UIUserInterfaceSizeClassRegular : UIUserInterfaceSizeClassCompact )];
    [self setOverrideTraitCollection:traitCollection forChildViewController:_splitVC];
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
