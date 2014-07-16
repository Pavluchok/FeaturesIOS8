//
//  DocumentProvideViewController.m
//  FeaturesIOS8
//
//  Created by vitaliy.pavlyuk on 7/16/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "DocumentProvideViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface DocumentProvideViewController ()

@end

@implementation DocumentProvideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapMenuButton:(id)sender
{
    @try {
        UIDocumentMenuViewController *menuVC = [[UIDocumentMenuViewController alloc]initWithDocumentTypes:@[(NSString *)kUTTypeText] inMode:UIDocumentPickerModeOpen];
        [self presentViewController:menuVC animated:YES completion:nil];
    }
    @catch (NSException *extension)
    {
        [self showAllertWithText:[extension description]];
    }
}

- (IBAction)tapPickerButton:(id)sender
{
    @try {
        UIDocumentPickerViewController *vc = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[(NSString *)kUTTypeRTF,(NSString *)kUTTypePNG,(NSString *)kUTTypeText,(NSString *)kUTTypePlainText,(NSString *)kUTTypePDF, (NSString *)kUTTypeImage] inMode:UIDocumentPickerModeOpen];
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:^{}];
    }
    @catch (NSException *exc)
    {
        [self showAllertWithText:[exc description]];
    }

}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    
}

- (void)showAllertWithText:(NSString *)text
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ATTANTION!!!" message:text preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
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
