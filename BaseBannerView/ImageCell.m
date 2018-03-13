//
//  ImageCell.m
//  BaseBannerView
//
//  Created by MenThu on 2018/3/12.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *tempImgView;


@end

@implementation ImageCell

- (void)setModel:(id)model{
    [super setModel:model];
    NSString *imgName = (NSString *)model;
    self.tempImgView.image = [UIImage imageNamed:imgName];
}


@end
