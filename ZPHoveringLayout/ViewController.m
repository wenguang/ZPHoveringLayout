//
//  ViewController.m
//  ZPHoveringLayout
//
//  Created by wenguang  pan on 27/9/16.
//  Copyright © 2016年 wenguang. All rights reserved.
//

#import "ViewController.h"
#import "ZPHoveringLayout.h"
#import "ReusableView.h"

static NSString *cellID = @"cellID";
static NSString *headerID = @"headerID";
static NSString *footerID = @"footerID";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"XLPlainFlowLayoutDemo";
    
    ZPHoveringLayout *layout = [ZPHoveringLayout new];
    layout.sectionForContinuedHoveringHeader = 3;
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.topBarHeight = 64.0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:headerID];
    [self.collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:footerID];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==2) {
        return 0;
    }
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = indexPath.section%2?[UIColor redColor]:[UIColor cyanColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind==UICollectionElementKindSectionFooter) {
        ReusableView *footer = [collectionView  dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerID forIndexPath:indexPath];
        footer.backgroundColor = [UIColor yellowColor];
        footer.text = [NSString stringWithFormat:@"第%ld个分区的footer",indexPath.section];
        return footer;
    }
    
    if (indexPath.section >0) {
        ReusableView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        header.backgroundColor = indexPath.section%2?[[UIColor blackColor] colorWithAlphaComponent:0.5] : [[UIColor blueColor] colorWithAlphaComponent:0.5];
        header.text = [NSString stringWithFormat:@"第%ld个分区的header",indexPath.section];
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section>0) {
        return CGSizeMake(0, 44);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==3) {
        return CGSizeZero;
    }
    return CGSizeMake(0, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
