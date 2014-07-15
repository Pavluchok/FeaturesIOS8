//
//  KeyboardViewController.m
//  KeyboardExtension
//
//  Created by vitaliy.pavlyuk on 7/15/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //**************************************************
    
    UIButton *hideKeyboard = [UIButton buttonWithType:UIButtonTypeSystem];
    [hideKeyboard setTitle:@"Hide keyboard" forState:UIControlStateNormal];
    [hideKeyboard sizeToFit];
    [hideKeyboard setTranslatesAutoresizingMaskIntoConstraints:NO];
    [hideKeyboard addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *rightLayout= [NSLayoutConstraint constraintWithItem:hideKeyboard attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
//
    NSLayoutConstraint *bottomRightLayout = [NSLayoutConstraint constraintWithItem:hideKeyboard attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    [self.view addSubview:hideKeyboard];
    
    [self.view addConstraints:@[rightLayout, bottomRightLayout]];
    
    UIButton *pointKey = [UIButton buttonWithType:UIButtonTypeCustom];
    [pointKey setTitle:@"⚫️" forState:UIControlStateNormal];
    [pointKey.titleLabel setFont:[UIFont systemFontOfSize:35.0]];
    [pointKey sizeToFit];
    [self addBorderToView:pointKey];
    [pointKey setTranslatesAutoresizingMaskIntoConstraints:NO];
    [pointKey addTarget:self action:@selector(pressKey:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:pointKey];
    
    UIButton *dashKey = [UIButton buttonWithType:UIButtonTypeCustom];
    [dashKey setTitle:@"➖" forState:UIControlStateNormal];
    [dashKey.titleLabel setFont:[UIFont systemFontOfSize:35.0]];
    [dashKey sizeToFit];
    [self addBorderToView:dashKey];
    [dashKey setTranslatesAutoresizingMaskIntoConstraints:NO];
    [dashKey addTarget:self action:@selector(pressKey:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:dashKey];
    
    UIButton *spaceKey = [UIButton buttonWithType:UIButtonTypeCustom];
    [spaceKey setTitle:@"😉" forState:UIControlStateNormal];
    [spaceKey.titleLabel setFont:[UIFont systemFontOfSize:35.0]];
    [spaceKey sizeToFit];
    [self addBorderToView:spaceKey];
    [spaceKey setTranslatesAutoresizingMaskIntoConstraints:NO];
    [spaceKey addTarget:self action:@selector(pressKey:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:spaceKey];
    
    NSLayoutConstraint *spasingLeftKey = [NSLayoutConstraint constraintWithItem:pointKey attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:spaceKey attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-5.0];
    NSLayoutConstraint *spasingRightKey = [NSLayoutConstraint constraintWithItem:spaceKey attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:dashKey attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-5.0];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:spaceKey attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:spaceKey attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *pointCenterY = [NSLayoutConstraint constraintWithItem:pointKey attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:spaceKey attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    NSLayoutConstraint *dashCenterY = [NSLayoutConstraint constraintWithItem:dashKey attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:spaceKey attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    [self.view addConstraints:@[spasingLeftKey, spasingRightKey, centerX, centerY,dashCenterY, pointCenterY]];

    
    UIButton *backspaceButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backspaceButton setTitle:@"Backspace" forState:UIControlStateNormal];
    [backspaceButton.titleLabel setFont:[UIFont systemFontOfSize:25.0]];
    [backspaceButton sizeToFit];
    [self addBorderToView:backspaceButton];
    [backspaceButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [backspaceButton addTarget:self action:@selector(didTapDelete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backspaceButton];

    NSLayoutConstraint *backSpaceLayout= [NSLayoutConstraint constraintWithItem:backspaceButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    
    [self.view addConstraints:@[backSpaceLayout]];
    
    //**************************************************
    
    
    // Perform custom UI setup here
    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
    [self.nextKeyboardButton sizeToFit];
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nextKeyboardButton];
    
    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)hideKeyboard:(UIButton *)sender
{
    [self dismissKeyboard];
}

- (void)pressKey:(UIButton *)key
{
    [self.textDocumentProxy insertText:[key.titleLabel text]];
}

- (void)didTapDelete
{
    [self.textDocumentProxy deleteBackward];
}

- (void)addBorderToView:(UIView *)view
{
    [view.layer setBorderColor:[UIColor blackColor].CGColor];
    [view.layer setBorderWidth:1.0f];
    [view.layer setCornerRadius:3.0f];
    
}

@end