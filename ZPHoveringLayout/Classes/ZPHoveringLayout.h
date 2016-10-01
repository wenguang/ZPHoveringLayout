//
//  ZPHoveringLayout.h
//  ZPHoveringLayout
//
//  Created by wenguang  pan on 27/9/16.
//  Copyright © 2016年 wenguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPHoveringLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat topBarHeight; //statusbar、navigationbar的高度， 默认为64.0
@property (nonatomic, assign) NSUInteger sectionForContinuedHoveringHeader;  //指定永久悬顶header所在的section

@end
