//
//  ViewController.m
//  LLKeyboardTest
//
//  Created by galileio on 2017/1/20.
//  Copyright © 2017年 ctw. All rights reserved.
//

#import "ViewController.h"
#import "LNNumberpad.h"

#define LBLWIDTH 10
#define TFHEIGHT 44
#define TFWIDTH [UIScreen mainScreen].bounds.size.width-20
@interface ViewController ()
{
    UILabel * mLbl;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextField * tf =  [[UITextField alloc] initWithFrame:CGRectMake(10, 100,TFWIDTH, TFHEIGHT)];
    tf.backgroundColor = [UIColor lightGrayColor];
    tf.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:tf];
    tf.inputView = [LNNumberpad defaultLNNumberpad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:tf];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 150,TFWIDTH, TFHEIGHT);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    mLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(tf.frame)- LBLWIDTH, 0, LBLWIDTH, TFHEIGHT)];
    mLbl.text = @"¥";
    mLbl.textColor = [UIColor redColor];
    [self.view addSubview:mLbl];
    
    

}


- (void)push {
    UIViewController * vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)textChanged:(NSNotification*)noti
{
    UITextField * tf = noti.object;
    CGSize maxSize = CGSizeMake(TFWIDTH - TFWIDTH, TFHEIGHT);
    
    NSDictionary *attribute = @{NSFontAttributeName: tf.font};
    CGFloat width = [tf.text boundingRectWithSize:maxSize
                                             options:  NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size.width;
    
   
    tf.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-10-width, 100, width, TFHEIGHT);
     mLbl.frame = CGRectMake(CGRectGetWidth(tf.frame) - LBLWIDTH - width, 0, LBLWIDTH, TFHEIGHT);
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
@end
