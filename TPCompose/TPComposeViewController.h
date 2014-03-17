//
//  TPComposeViewController.h
//  TPCompose
//
//  Created by Tanawat Polsuwan on 3/13/2557 BE.
//  Copyright (c) 2557 Tanawat Polswuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPComposeViewController;
@protocol TPComposeViewControllerDelegate <NSObject>
-(void)didDoneOnTPComposeViewController:(TPComposeViewController *)composeViewController Description:(NSString *)description Image:(UIImage *)image;
-(void)didCloseOnTPComposeViewController:(TPComposeViewController *)composeViewController;

@end

@interface TPComposeViewController : UIViewController
@property (nonatomic, weak) id <TPComposeViewControllerDelegate> delegate;

@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *placeholder;

-(void)showWithDescription:(NSString *)description Image:(UIImage *)image;
-(void)show;
-(void)hide;

@end
