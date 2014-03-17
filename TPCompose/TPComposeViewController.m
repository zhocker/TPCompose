//
//  TPComposeViewController.m
//  TPCompose
//
//  Created by Tanawat Polsuwan on 3/13/2557 BE.
//  Copyright (c) 2557 Tanawat Polswuan. All rights reserved.
//

#import "TPComposeViewController.h"
#import <QuartzCore/QuartzCore.h>
#define _VIEW_POSITION_Y_ 0
#define _ANIMATION_TIME_ 0.4

@interface TPComposeViewController () <UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *composeView;
@property (weak, nonatomic) IBOutlet UITextField *placeholderTextField;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *blockView;

- (IBAction)doneButtonAction:(id)sender;
- (IBAction)closeButtonAction:(id)sender;

@end

@implementation TPComposeViewController {
    UIWindow *_window;
}

@synthesize composeView = _composeView,delegate = _delegate, description = _description, placeholder = _placeholder, imageView = _imageView , blockView = _blockView;
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
    [self setupComposeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showWithDescription:(NSString *)description Image:(UIImage *)image{
    
    if ([description length] > 0) {
        [_inputTextView setText:description];
    }
    
    if (image != nil) {
        [_imageView setImage:image];
    }
    
    [self slideDown];
}

-(void)show{
    [self slideDown];
}

-(void)hide{
    [self slideUp];
}

- (IBAction)doneButtonAction:(id)sender {
    [self hide];
    [self dismissKeyboard];
    [_delegate didCloseOnTPComposeViewController:self];
}

- (IBAction)closeButtonAction:(id)sender {
    [self hide];
    [self dismissKeyboard];
    [_delegate didDoneOnTPComposeViewController:self Description:_inputTextView.text Image:_imageView.image];
}


-(void)setupComposeView{
    
    _window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    [self.view setHidden:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        _composeView.layer.masksToBounds = YES;
        _composeView.layer.cornerRadius = 10.0;
        _composeView.layer.borderWidth = 0.50f;
        [_composeView.layer setBorderColor:[[UIColor grayColor] CGColor]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view setHidden:NO];
        });
    });
    
    _placeholderTextField.delegate = self;
    _inputTextView.delegate = self;


}

#pragma mark - Animation
-(void)slideDown{
    
    [UIView animateWithDuration:_ANIMATION_TIME_ delay:0 options:UIViewAnimationOptionCurveLinear
                     animations:^(void) {
                         [_window addSubview:self.view];
                         CGRect tempRect = self.view.frame;
                         tempRect.origin.y = - self.view.frame.size.height;
                         self.view.frame = tempRect;
                         [UIView beginAnimations:nil context:NULL];
                         [UIView setAnimationDuration:_ANIMATION_TIME_];
                         tempRect.origin.y = _VIEW_POSITION_Y_;
                         self.view.frame = tempRect;

                     }
                     completion:^(BOOL finished) {
                         [UIView commitAnimations];
                     }
     ];

}

-(void)slideUp{
    
    [UIView animateWithDuration:_ANIMATION_TIME_ delay:0 options:UIViewAnimationOptionCurveLinear
                     animations:^(void) {
                         CGRect tempRect = self.view.frame;
                         tempRect.origin.y = _VIEW_POSITION_Y_;
                         self.view.frame = tempRect;
                         [UIView beginAnimations:nil context:NULL];
                         [UIView setAnimationDuration:_ANIMATION_TIME_];
                         tempRect.origin.y = - self.view.frame.size.height;
                         self.view.frame = tempRect;
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView commitAnimations];
                         [self.view removeFromSuperview];
                     }
     ];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Input Text View
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    [_placeholderTextField setPlaceholder:_placeholder];
}

-(void)setupPlaceholder{
    if ([[_inputTextView text] length] > 0) {
        [_placeholderTextField setPlaceholder:@" "];
    } else {
        [_placeholderTextField setPlaceholder:_placeholder];
    }
}

-(void)dismissKeyboard {
    [self setupPlaceholder];
    [_inputTextView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self setupPlaceholder];
    return TRUE;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self setupPlaceholder];
}

-(void)textViewDidChange:(UITextView *)textView{
    [self setupPlaceholder];

}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [self setupPlaceholder];
}


@end
