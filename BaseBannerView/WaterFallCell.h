//
//  WaterFallCell.h
//  BaseBannerView
//
//  Created by MenThu on 2018/3/22.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowDelegateProtocol.h"

@interface WaterFallCell : UICollectionViewCell <WaterFallLayoutDelegate>

@property (nonatomic, copy) NSString *tagText;

+ (instancetype)loadView;

@end
