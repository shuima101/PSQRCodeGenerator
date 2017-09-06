//
//  ViewController.m
//  PSQRCodeDemo
//
//  Created by 冯广勇 on 2017/8/9.
//  Copyright © 2017年 Passing. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeGenerator.h"

@interface ViewController ()
{
    NSString *_currentQRText;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)generateButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField.text = @"https://github.com/shuima101/PSQRCodeGenerator";
    [self generateButtonAction:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)generateButtonAction:(UIButton *)sender {
    if ([_currentQRText isEqualToString:_textField.text]) {
        return;
    }
    _currentQRText = _textField.text;
    _qrImageView.image = [QRCodeGenerator generateQRCodeImageWithString:_currentQRText];
}

@end
