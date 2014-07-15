//
//  ActionViewController.m
//  FeaturesIOS8
//
//  Created by vitaliy.pavlyuk on 7/15/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ActionViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *actionImageView;

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressActionButton:(id)sender
{
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[[_actionImageView image]] applicationActivities:nil];
    
    // Set a completion handler to handle what the UIActivityViewController returns
    [activityViewController setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError * error){
        
        if([returnedItems count] > 0){
            
            NSExtensionItem* extensionItem = [returnedItems firstObject];
            NSItemProvider* imageItemProvider = [[extensionItem attachments] firstObject];
            
            if([imageItemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]){
                
                [imageItemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *item, NSError *error) {
                    
                    if(item && !error){
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_actionImageView setImage:item];
                        });
                        
                    }
                }];
                
            }
        }
    }];
    [self presentViewController:activityViewController animated:YES completion:nil];
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
