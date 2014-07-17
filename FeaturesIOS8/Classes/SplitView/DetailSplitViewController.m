//
//  DetailSplitViewController.m
//  FeaturesIOS8
//
//  Created by vitaliy.pavlyuk on 7/17/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "DetailSplitViewController.h"

@interface DetailSplitViewController ()

@end

@implementation DetailSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showSplitView:(id)sender
{
    UISplitViewController *svc = self.splitViewController;
    
    [self.navigationController  setOverrideTraitCollection:[UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular] forChildViewController:svc];
    svc.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    NSLog(@"%d", svc.isCollapsed);
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
