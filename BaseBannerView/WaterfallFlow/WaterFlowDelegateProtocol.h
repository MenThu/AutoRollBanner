//
//  WaterFlowDelegateProtocol.h
//  BaseBannerView
//
//  Created by MenThu on 2018/3/22.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#ifndef WaterFlowDelegateProtocol_h
#define WaterFlowDelegateProtocol_h
#import <Foundation/Foundation.h>

@protocol WaterFallLayoutDelegate <NSObject>

@required
//计算item高度的代理方法，将item的高度与indexPath传递给外界
- (CGFloat)widthFor:(id)cellInfo cellHeight:(CGFloat)height;

@end

#endif /* WaterFlowDelegateProtocol_h */
