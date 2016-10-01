//
//  ViewController.m
//  Audible
//
//  Created by Doan Dat on 9/29/16.
//  Copyright (c) 2016 Doan Dat. All rights reserved.
//

#import "LoginController.h"
#import "Masonry.h"
#import "PageCell.h"
#import "Page.h"
#import "LoginCell.h"

#define kPageCellIdentifier         @"PageCellId"
#define kLoginPageCellIdentifier    @"LoginPageCellId"

@interface LoginController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) MASConstraint *bottomPageControlConstraint;
@property (nonatomic, strong) MASConstraint *topSkipButtonConstraint;

@property (nonatomic, strong) NSArray *pages;

@end

@implementation LoginController

- (UICollectionView*)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[PageCell class] forCellWithReuseIdentifier:kPageCellIdentifier];
        [_collectionView registerClass:[LoginCell class] forCellWithReuseIdentifier:kLoginPageCellIdentifier];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}

- (UIPageControl*)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        _pageControl.numberOfPages = [self.pages count] + 1;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:247/255.0 green:154/255.0 blue:27/255.0 alpha:1.0];
    }
    return _pageControl;
}

- (UIButton*)skipButton {
    if (!_skipButton) {
        _skipButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _skipButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_skipButton setTitle:@"Skip" forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor colorWithRed:247/255.0 green:154/255.0 blue:27/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}

- (UIButton*)nextButton {
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _nextButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor colorWithRed:247/255.0 green:154/255.0 blue:27/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set model
    [self setupModel];
    
    // setup views
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.skipButton];
    [self.view addSubview:self.nextButton];
    
    // add constraints
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(10));
        self.bottomPageControlConstraint = make.bottom.equalTo(self.view).offset(-16);
    }];
    
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        self.topSkipButtonConstraint = make.top.equalTo(self.view).offset(16);
        make.left.equalTo(self.view).offset(16);
        make.centerY.equalTo(self.nextButton);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-16);
    }];
}

- (void)setupModel {
    Page *pageOne = [[Page alloc] initWithTitle:@"Share a great listen" message:@"It's free to send your books to the people in your life. Every recipient's first book is on us." imageName:@"page1"];
    Page *pageTwo = [[Page alloc] initWithTitle:@"Send from your library" message:@"Tap the More menu next to any book. Choose \"Send this Book\"" imageName:@"page2"];
    Page *pageThree = [[Page alloc] initWithTitle:@"Send from the player" message:@"Tap the More menu in the upper corner. Choose \"Send this Book\"" imageName:@"page3"];
    
    self.pages = @[pageOne, pageTwo, pageThree];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.pages count] + 1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == [self.pages count]) {
        LoginCell *loginCell = [collectionView dequeueReusableCellWithReuseIdentifier:kLoginPageCellIdentifier forIndexPath:indexPath];
        return loginCell;
    }
    
    PageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPageCellIdentifier forIndexPath:indexPath];
    cell.page = self.pages[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"Offset = %f", targetContentOffset->x);
    CGFloat offset = targetContentOffset->x;
    CGFloat width = self.view.bounds.size.width;
    NSUInteger currentPage = (offset / width);
    self.pageControl.currentPage = currentPage;
    
    if (currentPage == [self.pages count]) {
        [self moveControlContraintsOffScreen];
    }
    else {
        self.bottomPageControlConstraint.offset(-16);
        self.topSkipButtonConstraint.offset(16);
    }
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)keyboardShow:(NSNotification*)notification {
    CGRect keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    NSLog(@"Frame = %@", NSStringFromCGRect(keyboardSize));
    
    CGFloat keyboardTranslateDistance = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? -100 : -50;

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.frame = CGRectMake(0, keyboardTranslateDistance, self.view.frame.size.width, self.view.frame.size.height);
    } completion:nil];
}

- (void)keyboardHide:(NSNotification*)notification {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion:nil];
}

- (void)next {
    if (self.pageControl.currentPage == [self.pages count]) {
        return;
    }
    
    if (self.pageControl.currentPage == [self.pages count] - 1) {
        [self moveControlContraintsOffScreen];
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.pageControl.currentPage + 1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.pageControl.currentPage += 1;
}

- (void)skip {
    self.pageControl.currentPage = [self.pages count] - 1;
    [self next];
}

- (void)moveControlContraintsOffScreen {
    self.bottomPageControlConstraint.offset(16);
    self.topSkipButtonConstraint.offset(-16 - 20);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.pageControl.currentPage inSection:0];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self.collectionView reloadData];
    });
}

@end
