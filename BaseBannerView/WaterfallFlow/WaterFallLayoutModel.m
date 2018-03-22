//
//  WaterFallLayoutModel.m
//  BaseBannerView
//
//  Created by MenThu on 2018/3/22.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#import "WaterFallLayoutModel.h"

@implementation WaterFallLayoutModel

- (instancetype)init{
    if (self = [super init]) {
        self.contentSize = CGSizeZero;
        self.attributesArray = @[].mutableCopy;
    }
    return self;
}

@end
