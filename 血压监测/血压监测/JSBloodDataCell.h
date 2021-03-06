//
//  JSBloodDataCell.h
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSPersonBloodData.h"
@protocol JSBloodDataCellDelegate <NSObject>

- (void)selectCellWithIndex:(NSInteger)section;

@end
@interface JSBloodDataCell : UITableViewCell<UIScrollViewDelegate>
@property (nonatomic,weak) id<JSBloodDataCellDelegate>delegate;
-(void)upCellDataWithPersonData:(JSPersonBloodData *)data;
@end
