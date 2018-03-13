//
//  AutoRollBanner.m
//  BaseBannerView
//
//  Created by MenThu on 2018/3/12.
//  Copyright © 2018年 MenThu. All rights reserved.
//

#import "AutoRollBanner.h"
#import "MTTimer.h"
#import "AutoRollCell.h"

static NSInteger const ScaleCount = 501;//需要是奇数
static void *COLLECTIONVIEW_CONTENTSIZE = &COLLECTIONVIEW_CONTENTSIZE;

@interface AutoRollBanner () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) MTTimer *bannerTimer;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL isContentSizeRight;
@property (nonatomic, assign) BOOL isRollBeginCall;
@property (nonatomic, assign) NSInteger bannerRealCount;

@end

@implementation AutoRollBanner

#pragma mark - LifeCircle
- (void)awakeFromNib{
    [super awakeFromNib];
    [self configBanner];
}

- (instancetype)initBannerWith:(NSInteger)bannerInterval
                 cellClassName:(NSString *)bannerCellClassName
                 isCellFromXib:(BOOL)isCellFromXib{
    if (self = [super init]) {
        self.bannerInterval = bannerInterval;
        self.bannerCellClassName = bannerCellClassName;
        self.isCellFromXib = isCellFromXib;
        [self configBanner];
    }
    return self;
}

- (void)configBanner{
    __weak typeof(self) weakSelf = self;
    [self initData];
    if (self.isCellFromXib) {
        [self.collectionView registerNib:[UINib nibWithNibName:self.bannerCellClassName bundle:nil] forCellWithReuseIdentifier:self.bannerCellClassName];
    }else{
        [self.collectionView registerClass:NSClassFromString(self.bannerCellClassName) forCellWithReuseIdentifier:self.bannerCellClassName];
    }
    [self addKvo];
    self.bannerTimer = [[MTTimer alloc] initTimerWithInterval:self.bannerInterval isStartAcOnce:NO timerCallBack:^(NSUInteger callCount, CGFloat passTime) {
        [weakSelf scroll2NexPage];
    }];
}

- (void)dealloc{
    NSLog(@"AutoRollBanner die");
    [self removeKvo];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = self.collectionView.frame.size;
}

#pragma mark - Public
- (void)isRollBegin:(BOOL)yesOrNo{
    if (yesOrNo) {
        if ([self isContentSizeRight]) {
            [self.bannerTimer startTimer];
        }else{
            self.isRollBeginCall = YES;
        }
    }else{
        [self.bannerTimer pauseTimer];
    }
}

#pragma mark - Private
- (void)initData{
    self.currentPage = 0;
    self.isContentSizeRight = NO;
    self.isRollBeginCall = NO;
    self.bannerRealCount = 0;
}

- (void)scroll2NexPage{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:++self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)addKvo{
    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&COLLECTIONVIEW_CONTENTSIZE];
}

- (void)removeKvo{
    [self.collectionView removeObserver:self forKeyPath:@"contentSize" context:&COLLECTIONVIEW_CONTENTSIZE];
}

- (BOOL)isCollectionViewContentSizeRight{
    //1.自身size大于CGSizeZero
    if (CGSizeEqualToSize(CGSizeZero, self.bounds.size)) {
        return NO;
    }
    //2.数据源大于0
    if (![self.bannerSource isKindOfClass:[NSArray class]] || self.bannerSource.count <= 0) {
        return NO;
    }
    //3.contentSize = bannerSource.count*self.width
    NSInteger TimesCountMultiplyBannerCount = self.bannerSource.count * ScaleCount;
    CGFloat expectContentWidth = TimesCountMultiplyBannerCount * CGRectGetWidth(self.collectionView.frame);
    CGFloat actualContentWidth = self.collectionView.contentSize.width;
    return (fabs(expectContentWidth-actualContentWidth) < 0.000001);
}

#pragma mark - Getter
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.pagingEnabled = YES;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:(_collectionView = collectionView)];
    }
    return _collectionView;
}

#pragma mark - Setter
- (void)setBannerSource:(NSArray *)bannerSource{
    [self.bannerTimer pauseTimer];
    _bannerSource = bannerSource;
    _currentPage = 0;
    NSInteger bannerCount = bannerSource.count;
    if (bannerCount > 1) {
        self.bannerRealCount = bannerCount * ScaleCount;
    }else{
        self.bannerRealCount = bannerCount;
    }
    self.isContentSizeRight = NO;
    [self.collectionView reloadData];
}

#pragma mark - Kvo
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(__unused id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    if(context == &COLLECTIONVIEW_CONTENTSIZE && object == self.collectionView && !self.isContentSizeRight) {
        if ([self isCollectionViewContentSizeRight]) {
            self.isContentSizeRight = YES;
            NSInteger middleIndexPathRow = (ScaleCount-1)/2*self.bannerSource.count;
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:middleIndexPathRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            self.currentPage = middleIndexPathRow;
            if (self.isRollBeginCall) {
                [self.bannerTimer startTimer];
            }
        }
    }
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = (scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame)) + 0.5;
    if (scrollView.isDragging) {
        self.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //开始拖拽
    [self.bannerTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //松手
    [self.bannerTimer startTimer];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.bannerRealCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AutoRollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.bannerCellClassName forIndexPath:indexPath];
    if (![cell isKindOfClass:[AutoRollCell class]]) {
        NSAssert(NO, @"bannerCellClassName必须为AutoRollCell的子类");
    }
    NSInteger index = indexPath.row % self.bannerSource.count;
    NSLog(@"cellForItemAtIndexPath=[%lld]", (long long)index);
    cell.model = self.bannerSource[index];
    return cell;
}

@end
