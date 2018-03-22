//
//  WaterFallLayoutModel.h
//  BaseBannerView
//
//  Created by MenThu on 2018/3/22.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WaterFallLayoutModel : NSObject

/** 内容大小 */
@property (nonatomic, assign) CGSize contentSize;

/** 每一个元素对应的位置 */
@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *> *attributesArray;

@end
