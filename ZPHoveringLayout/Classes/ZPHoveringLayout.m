//
//  ZPHoveringLayout.m
//  ZPHoveringLayout
//
//  Created by wenguang  pan on 27/9/16.
//  Copyright © 2016年 wenguang. All rights reserved.
//

#import "ZPHoveringLayout.h"

@interface ZPHoveringLayout()

@property (nonatomic, strong) UICollectionViewLayoutAttributes *hoveringAttributes; //悬停header attributes
@property (nonatomic, assign) CGFloat hoveriginOriginY; // 悬停header 最初的origin y

@end

@implementation ZPHoveringLayout

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _topBarHeight = 64.0;
        _sectionForContinuedHoveringHeader = -1;
    }
    return self;
}


- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect
{
    //
    NSMutableArray *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    // 在当前显示的item中找到指定的header
    if (!_hoveringAttributes) {
        for (UICollectionViewLayoutAttributes *attributes in superArray) {
            if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]
                && attributes.indexPath.section == _sectionForContinuedHoveringHeader) {
                _hoveringAttributes = attributes;
                _hoveriginOriginY = _hoveringAttributes.frame.origin.y;
            }
        }
    }
    
    // 把该header加到显示的数据中
    BOOL isContain = false;
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        if (attributes.indexPath.section == _hoveringAttributes.indexPath.section
            && [attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            isContain = YES;
        }
    }
    if (!isContain && _hoveringAttributes) {
        [superArray addObject:_hoveringAttributes];
    }
    
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        if (attributes.indexPath.section == _hoveringAttributes.indexPath.section
            && [attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            CGRect frame = attributes.frame;
            CGFloat offset = self.collectionView.contentOffset.y + _topBarHeight;
            //悬停顶部
            frame.origin.y = MAX(offset, _hoveriginOriginY);
            attributes.frame = frame;
            //保持悬停在视图顶层
            attributes.zIndex = 12;
        }
    }
    
    return [superArray copy];
    
}

//return YES;表示一旦滑动就实时调用上面这个layoutAttributesForElementsInRect:方法
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
    return YES;
}

@end
