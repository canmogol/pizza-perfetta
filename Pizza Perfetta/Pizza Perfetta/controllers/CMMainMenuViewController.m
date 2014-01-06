//
//  CMMainMenuViewController.m
//  Pizza Perfetta
//
//  Created by Ali Can MOGOL on 05/01/14.
//  Copyright (c) 2014 Can A. MOGOL. All rights reserved.
//

#import "CMMainMenuViewController.h"
#import "CMCaptureViewController.h"
#import "CMUseExistingViewController.h"

@interface CMMainMenuViewController ()
- (IBAction)capturePhoto:(UIButton *)sender;
- (IBAction)useExistingPhoto:(UIButton *)sender;
- (IBAction)previousCaptures:(UIButton *)sender;
@end

@implementation CMMainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)capturePhoto:(UIButton *)sender {
    CMCaptureViewController* controller = [[CMCaptureViewController alloc] init];
    [[self navigationController] pushViewController:controller animated:YES];
}

- (IBAction)useExistingPhoto:(UIButton *)sender {
    CMUseExistingViewController* controller = [[CMUseExistingViewController alloc] init];
    [[self navigationController] pushViewController:controller animated:YES];
}

- (IBAction)previousCaptures:(UIButton *)sender {
}

@end