//
//  ViewController.m
//  FeaturesIOS8
//
//  Created by vitaliy.pavlyuk on 7/14/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "ViewController.h"

static NSString *const kFeaturestTableCellIdentifier = @"FeaturesCell";

@interface ViewController ()

@property (nonatomic, strong) NSArray *features;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _features = @[@"Extensions", @"Blur"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_features count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFeaturestTableCellIdentifier];
    [cell.textLabel setText:_features[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_features[indexPath.row] isEqual:@"Blur"])
    {
        [self performSegueWithIdentifier:@"TestSegue" sender:self];
    }
}



@end
