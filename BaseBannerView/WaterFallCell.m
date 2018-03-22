//
//  WaterFallCell.m
//  BaseBannerView
//
//  Created by MenThu on 2018/3/22.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#import "WaterFallCell.h"

@interface WaterFallCell ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation WaterFallCell

+ (instancetype)loadView{
    return [[NSBundle mainBundle] loadNibNamed:@"WaterFallCell" owner:self options:nil].lastObject;
}

- (void)setTagText:(NSString *)tagText{
    _tagText = tagText;
    self.textLabel.text = tagText;
}

- (CGFloat)widthFor:(id)displayInfo cellHeight:(CGFloat)height{
    NSString *text = (NSString *)displayInfo;
    CGSize labelMaxSize = CGSizeMake(MAXFLOAT, height);
    self.textLabel.text = text;
    CGFloat cellWidth = [self.textLabel sizeThatFits:labelMaxSize].width + 10;
    return cellWidth;
}

@end
