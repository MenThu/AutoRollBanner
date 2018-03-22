//
//  WaterFallLayout.h
//  BaseBannerView
//
//  Created by MenThu on 2018/3/22.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFallLayoutModel.h"
#import "WaterFlowDelegateProtocol.h"

@interface WaterFallLayout : UICollectionViewLayout


/**
 *  利用数据源计算瀑布流所需要的信息
 */
- (WaterFallLayoutModel *)getLayoutModel:(NSArray *)dataArray
                               viewWidth:(CGFloat)width
                          layoutDelegate:(id<WaterFallLayoutDelegate>)delegate
                              cellHeight:(CGFloat)height
                          cellMaxWidth:(CGFloat)cellMaxWidth;

/**
 *  行间距,默认5
 */
@property (nonatomic, assign) CGFloat lineSpace;

/**
 *  行间距,默认5
 */
@property (nonatomic, assign) CGFloat columnSpace;

/**
 *  最大行数，默认3行
 */
@property (nonatomic, assign) NSInteger maxLineNum;

/**
 *  布局信息
 */
@property (nonatomic, strong) WaterFallLayoutModel *layoutModel;

@end
