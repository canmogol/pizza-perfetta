//
//  CMCaptureViewController.m
//  Pizza Perfetta
//
//  Created by Ali Can MOGOL on 22/12/13.
//  Copyright (c) 2013 Can A. MOGOL. All rights reserved.
//

#import "CMCaptureViewController.h"

@interface CMCaptureViewController ()

@end

@implementation CMCaptureViewController

@synthesize captureManager;
@synthesize scanningLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
	[self setCaptureManager:[[CaptureSessionManager alloc] init]];
    
	[[self captureManager] addVideoInputFrontCamera:NO]; // set to YES for Front Camera, No for Back camera
    
    [[self captureManager] addStillImageOutput];
    
	[[self captureManager] addVideoPreviewLayer];
	CGRect layerRect = [[[self view] layer] bounds];
    [[[self captureManager] previewLayer] setBounds:layerRect];
    [[[self captureManager] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
	[[[self view] layer] addSublayer:[[self captureManager] previewLayer]];
    
    UIImageView *overlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlaygraphic.png"]];
    [overlayImageView setFrame:CGRectMake(30, 200, 260, 200)];
    [[self view] addSubview:overlayImageView];
    
    
    UIButton *overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [overlayButton setImage:[UIImage imageNamed:@"scanbutton.png"] forState:UIControlStateNormal];
    [overlayButton setFrame:CGRectMake(130, 420, 60, 30)];
    [overlayButton addTarget:self action:@selector(scanButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:overlayButton];
    /**/
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 450, 120, 30)];
    [self setScanningLabel:tempLabel];
	[scanningLabel setBackgroundColor:[UIColor clearColor]];
	[scanningLabel setFont:[UIFont fontWithName:@"Courier" size: 18.0]];
	[scanningLabel setTextColor:[UIColor redColor]];
	[scanningLabel setText:@"Saving..."];
    [scanningLabel setHidden:YES];
	[[self view] addSubview:scanningLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveImageToPhotoAlbum) name:kImageCapturedSuccessfully object:nil];
    
	[[captureManager captureSession] startRunning];
}

- (void)scanButtonPressed {
	[[self scanningLabel] setHidden:NO];
    [[self captureManager] captureStillImage];
}

- (void)saveImageToPhotoAlbum
{
    UIImageWriteToSavedPhotosAlbum([[self captureManager] stillImage], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        [[self scanningLabel] setHidden:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
