//
//  ExtensionsViewController.m
//  FeaturesIOS8
//
//  Created by vitaliy.pavlyuk on 7/15/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "ExtensionsViewController.h"

@interface ExtensionsViewController ()
@property (nonatomic, weak) IBOutlet UITableView *ExtensionsTableView;
@property (nonatomic, strong) NSArray *extensions;
@property (nonatomic, strong) NSArray *identifier;
@end

@implementation ExtensionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _extensions = @[@"Action", @"Keyboard", @"Today"];
    _identifier = @[@"ActionVC", @"KeyboarVC", @"TodayVC"];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_extensions count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExtensionCell"];
    [cell.textLabel setText:_extensions[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_extensions[indexPath.row] isEqual:@"Keyboard"]) {
        UIStoryboard *stroryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *keyboardVC = [stroryBoard instantiateViewControllerWithIdentifier:@"KeyboardVC"];
        [self.navigationController pushViewController:keyboardVC animated:YES];
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
