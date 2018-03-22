//
//  WaterFallController.m
//  BaseBannerView
//
//  Created by MenThu on 2018/3/22.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#import "WaterFallController.h"
#import "WaterFallCell.h"
#import "WaterFallLayout.h"

@interface WaterFallController () <UICollectionViewDelegate, UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <NSString *> *collectionSource;
@property (nonatomic, strong) WaterFallCell *cacheCell;
@property (nonatomic, weak) WaterFallLayout *flowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;


@end

@implementation WaterFallController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.collectionView registerNib:[UINib nibWithNibName:@"WaterFallCell" bundle:nil] forCellWithReuseIdentifier:@"WaterFallCell"];
    self.collectionView.collectionViewLayout = [WaterFallLayout new];
    self.flowLayout = (WaterFallLayout *)self.collectionView.collectionViewLayout;
    self.cacheCell = [WaterFallCell loadView];

    
    for (NSInteger index = 0; index < 100; index ++) {
        NSInteger randomCount = arc4random_uniform(10)+1;
        NSMutableString *text = @"".mutableCopy;
        for (NSInteger subCount = 0; subCount < randomCount; subCount ++) {
            [text appendFormat:@"第%d个", (int)index];
        }
        [self.collectionSource addObject:text];
    }
    
    WaterFallLayoutModel *layoutModel = [self.flowLayout getLayoutModel:self.collectionSource viewWidth:[UIScreen mainScreen].bounds.size.width layoutDelegate:self.cacheCell cellHeight:30 cellMaxWidth:[UIScreen mainScreen].bounds.size.width];
    
    self.flowLayout.layoutModel = layoutModel;
    [self.collectionView reloadData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
}

- (void)initData{
    self.collectionSource = @[].mutableCopy;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFallCell *waterCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterFallCell" forIndexPath:indexPath];
    waterCell.tagText = self.collectionSource[indexPath.row];
    return waterCell;
}



@end
