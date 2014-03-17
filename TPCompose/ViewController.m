//
//  ViewController.m
//  TPCompose
//
//  Created by Tanawat Polsuwan on 3/13/2557 BE.
//  Copyright (c) 2557 Tanawat Polswuan. All rights reserved.
//

#import "ViewController.h"
#import "TPComposeViewController.h"
@interface ViewController () <TPComposeViewControllerDelegate>
- (IBAction)showComposeViewButtonAction:(id)sender;

@property (nonatomic,strong)TPComposeViewController *tpComposeViewController;

@end

@implementation ViewController{
    UIWindow *_window;
}


@synthesize tpComposeViewController = _tpComposeViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupTPComposeViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupTPComposeViewController{
    _tpComposeViewController = [[TPComposeViewController alloc] initWithNibName:@"TPComposeViewController" bundle:nil];
    _tpComposeViewController.delegate = self;
    [[_tpComposeViewController view] setFrame:CGRectMake(0,0,320,568)];
    [_tpComposeViewController setPlaceholder:@"TEST"];
    
}

- (IBAction)showComposeViewButtonAction:(id)sender {
    [_tpComposeViewController show];
}

-(void)didDoneOnTPComposeViewController:(TPComposeViewController *)composeViewController Description:(NSString *)description Image:(UIImage *)image{
//    NSLog(@"%s%@",__PRETTY_FUNCTION__,composeViewController);

}
-(void)didCloseOnTPComposeViewController:(TPComposeViewController *)composeViewController{
//    NSLog(@"%s%@",__PRETTY_FUNCTION__,composeViewController);
}


@end
