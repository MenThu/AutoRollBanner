//
//  AutoRollBanner.h
//  BaseBannerView
//
//  Created by MenThu on 2018/3/12.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoRollBanner : UIView

/** 轮播图时间间隔,默认3秒 */
@property (nonatomic, assign) IBInspectable NSInteger bannerInterval;

/** cell名称 */
@property (nonatomic, copy) IBInspectable NSString *bannerCellClassName;

/** cell是否来自xib，默认为NO */
@property (nonatomic, assign) IBInspectable BOOL isCellFromXib;

/** 滚动视图的数据源 */
@property (nonatomic, strong) NSArray *bannerSource;

/** 初始化方法 */
- (instancetype)initBannerWith:(NSInteger)bannerInterval
                 cellClassName:(NSString *)bannerCellClassName
                 isCellFromXib:(BOOL)isCellFromXib;

/** 是否开始滚动 */
- (void)isRollBegin:(BOOL)yesOrNo;

@end
