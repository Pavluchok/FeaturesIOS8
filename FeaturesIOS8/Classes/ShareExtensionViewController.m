//
//  ShareExtensionViewController.m
//  FeaturesIOS8
//
//  Created by vitaliy.pavlyuk on 7/17/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "ShareExtensionViewController.h"

@interface ShareExtensionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *sharedImageView;
@end

@implementation ShareExtensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressShareButton:(id)sender
{
    UIActivityViewController *shareVC = [[UIActivityViewController alloc]initWithActivityItems:@[@"This is test of the Share Extension", [_sharedImageView image]] applicationActivities:nil];
    
     [shareVC setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError * error){
         
         NSString *sharedString;
         
         if (completed && error == nil)
         {
             sharedString = @"Post is sharing";
         }
         else
         {
             sharedString = [NSString stringWithFormat:@"Error - %@", error.description];
         }
         
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Shared" message:sharedString preferredStyle:UIAlertControllerStyleAlert];
         
         UIAlertAction *OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
                 [alert dismissViewControllerAnimated:YES completion:nil];
         }];
         
         [alert addAction:OK];
         [self presentViewController:alert animated:YES completion:nil];

     }];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController:shareVC];
        [popover presentPopoverFromBarButtonItem:[[UIBarButtonItem alloc]
                                                  initWithCustomView:(UIButton *)sender] permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
    else
    {
        [self presentViewController:shareVC animated:YES completion:nil];
    }
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
