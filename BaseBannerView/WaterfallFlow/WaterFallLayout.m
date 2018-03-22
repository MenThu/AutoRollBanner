//
//  WaterFallLayout.m
//  BaseBannerView
//
//  Created by MenThu on 2018/3/22.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#import "WaterFallLayout.h"

@interface WaterFallLayout ()

@end

@implementation WaterFallLayout

- (instancetype)init{
    if (self = [super init]) {
        self.lineSpace = 5.f;
        self.columnSpace = 5.f;
        self.maxLineNum = 500;
    }
    return self;
}

- (CGSize)collectionViewContentSize {
    return self.layoutModel.contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutModel.attributesArray;
}

#pragma mark - Public
- (WaterFallLayoutModel *)getLayoutModel:(NSArray *)dataArray
                               viewWidth:(CGFloat)width
                          layoutDelegate:(id<WaterFallLayoutDelegate>)delegate
                              cellHeight:(CGFloat)height
                            cellMaxWidth:(CGFloat)cellMaxWidth{
    if (![delegate respondsToSelector:@selector(widthFor:cellHeight:)]) {
        NSAssert(NO, @"");
    }
    NSMutableArray <UICollectionViewLayoutAttributes *> *attributesArray = @[].mutableCopy;
    CGSize contentSize = CGSizeZero;
    NSMutableArray <NSNumber *> *lineWidthArray = @[].mutableCopy;
    for (NSInteger index = 0; index < dataArray.count; index ++) {
        id cellInfo = dataArray[index];
        CGFloat cellWidth = [delegate widthFor:cellInfo cellHeight:height];
        cellWidth = MIN(cellWidth, cellMaxWidth);
        NSInteger line = -1;
        for (NSInteger line_index = 0; line_index < lineWidthArray.count; line_index ++) {
            if (lineWidthArray[line_index].floatValue + cellWidth <= width) {
                line = line_index;
                break;
            }
        }
        CGFloat x = 0;
        CGFloat y = 0;
        if (line == -1) {//需要增加一行
            CGFloat newLineWidth = cellWidth+self.columnSpace;
            [lineWidthArray addObject:@(newLineWidth)];
            x = 0;
            y = (lineWidthArray.count-1)*(height+self.lineSpace);
        }else{//更新当前行的宽度
            x = lineWidthArray[line].floatValue;
            y = line*(height+self.lineSpace);
            lineWidthArray[line] = @(lineWidthArray[line].floatValue+cellWidth+self.columnSpace);
        }
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        attributes.frame = CGRectMake(x, y, cellWidth, height);
        [attributesArray addObject:attributes];
    }
    NSInteger lineCount = MIN(lineWidthArray.count, self.maxLineNum);
    contentSize = CGSizeMake(width, (lineCount-1)*self.lineSpace + lineCount*height);
    WaterFallLayoutModel *layoutModel = [WaterFallLayoutModel new];
    layoutModel.attributesArray = attributesArray;
    layoutModel.contentSize = contentSize;
    return layoutModel;
}

#pragma mark - Setter
- (void)setLayoutModel:(WaterFallLayoutModel *)layoutModel{
    _layoutModel = layoutModel;
    [self invalidateLayout];
}

@end
