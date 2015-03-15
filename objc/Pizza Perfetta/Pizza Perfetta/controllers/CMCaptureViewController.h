//
//  CMCaptureViewController.h
//  Pizza Perfetta
//
//  Created by Ali Can MOGOL on 22/12/13.
//  Copyright (c) 2013 Can A. MOGOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureSessionManager.h"

@interface CMCaptureViewController : UIViewController

@property (retain) CaptureSessionManager *captureManager;
@property (nonatomic, retain) UILabel *scanningLabel;

@end
