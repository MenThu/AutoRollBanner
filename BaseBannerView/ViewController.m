//
//  ViewController.m
//  BaseBannerView
//
//  Created by MenThu on 2018/3/12.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#import "ViewController.h"
#import "AutoRollBanner.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet AutoRollBanner *bannerView;
@property (nonatomic, assign) BOOL currentState;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentState = YES;
    NSArray <NSString *> *imgNameArray = @[@"1", @"2", @"3"];
    self.bannerView.bannerSource = imgNameArray;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
    [self.bannerView isRollBegin:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.currentState = !self.currentState;
    [self.bannerView isRollBegin:self.currentState];
}


@end
