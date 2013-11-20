//
//  JSFamilyNumberCell.h
//  血压监测
//
//  Created by demo on 13-11-19.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSPersonBloodData.h"
@protocol JSFanmilyCellDelegate <NSObject>

- (void)reloadFamilyData;

@end
@interface JSFamilyNumberCell : UITableViewCell
@property (nonatomic,weak) id<JSFanmilyCellDelegate>delegate;
@property (nonatomic,assign) BOOL isCanRemove;
-(void)upCellDataWith:(JSPersonBloodData *)data;
@end
