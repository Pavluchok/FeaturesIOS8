//
//  PhotoEditingViewController.m
//  PhotoEditinExtension
//
//  Created by vitaliy.pavlyuk on 7/16/14.
//  Copyright (c) 2014 vitaliy.pavlyuk. All rights reserved.
//

#import "PhotoEditingViewController.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

@interface PhotoEditingViewController () <PHContentEditingController>
@property (weak, nonatomic) IBOutlet UIImageView *editingImageView;
@property (strong) PHContentEditingInput *input;
@end

@implementation PhotoEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PHContentEditingController

- (BOOL)canHandleAdjustmentData:(PHAdjustmentData *)adjustmentData {
    // Inspect the adjustmentData to determine whether your extension can work with past edits.
    // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
    return NO;
}

- (void)startContentEditingWithInput:(PHContentEditingInput *)contentEditingInput placeholderImage:(UIImage *)placeholderImage {
    // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
    // If you returned YES from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
    // If you returned NO, the contentEditingInput has past edits "baked in".
    
    _editingImageView.image = placeholderImage;
    
    self.input = contentEditingInput;
}

- (void)finishContentEditingWithCompletionHandler:(void (^)(PHContentEditingOutput *))completionHandler {
    // Update UI to reflect that editing has finished and output is being rendered.
    
    // Render and provide output on a background queue.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Create editing output from the editing input.
        PHContentEditingOutput *output = [[PHContentEditingOutput alloc] initWithContentEditingInput:self.input];
        PHAdjustmentData *ad = [[PHAdjustmentData alloc]initWithFormatIdentifier:_input.adjustmentData.formatIdentifier formatVersion:_input.adjustmentData.formatVersion data:UIImagePNGRepresentation(_editingImageView.image)];
        // Provide new adjustments and render output to given location.
         output.adjustmentData = ad;
         NSData *renderedJPEGData = UIImageJPEGRepresentation(_editingImageView.image, 1.0);
         [renderedJPEGData writeToURL:output.renderedContentURL atomically:YES];
        
        // Call completion handler to commit edit to Photos.
        completionHandler(output);
        
        // Clean up temporary files, etc.
    });
}

- (void)cancelContentEditing {
    // Clean up temporary files, etc.
    // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
}

- (IBAction)enableBlackWhite:(id)sender
{
    UISwitch *switchControl = (UISwitch *)sender;
    
    UIImage *newImage = [switchControl isOn]?[self processUsingCoreGraphics:_input.displaySizeImage] : _input.displaySizeImage;
    
    [_editingImageView setImage:newImage];
    
}

- (UIImage *)processUsingCoreGraphics:(UIImage*)input
{
    CGRect imageRect = {CGPointZero,input.size};
    NSInteger inputWidth = CGRectGetWidth(imageRect);
    NSInteger inputHeight = CGRectGetHeight(imageRect);
    
//     1) Calculate the location of Ghosty
    UIImage *ghostImage = [UIImage imageNamed:@"Ukraine.png"];
    
    NSInteger targetGhostWidth = inputWidth * 0.25;
    CGSize ghostSize = CGSizeMake(targetGhostWidth, targetGhostWidth/2);
    CGPoint ghostOrigin = CGPointMake(inputWidth - targetGhostWidth, 0);
    
    CGRect ghostRect = {ghostOrigin, ghostSize};
    
    // 2) Draw your image into the context.
    UIGraphicsBeginImageContext(input.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGAffineTransform flip = CGAffineTransformMakeScale(1.0, -1.0);
    CGAffineTransform flipThenShift = CGAffineTransformTranslate(flip,0,-inputHeight);
    CGContextConcatCTM(context, flipThenShift);
    
    CGContextDrawImage(context, imageRect, [input CGImage]);
    
    CGContextSetBlendMode(context, kCGBlendModeSourceAtop);
    CGContextSetAlpha(context,0.8);
    CGRect transformedGhostRect = CGRectApplyAffineTransform(ghostRect, flipThenShift);
    CGContextDrawImage(context, transformedGhostRect, [ghostImage CGImage]);
    
    // 3) Retrieve your processed image
    UIImage * imageWithGhost = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 4) Draw your image into a grayscale context
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    context = CGBitmapContextCreate(nil, inputWidth, inputHeight,
//                                    8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
//    
//    CGContextDrawImage(context, imageRect, [imageWithGhost CGImage]);
//    
//    CGImageRef imageRef = CGBitmapContextCreateImage(context);
//    UIImage * finalImage = [UIImage imageWithCGImage:imageRef];
    
    // 5) Cleanup
    //CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    //CFRelease(imageRef);
    
    return imageWithGhost;//finalImage;
}


@end
