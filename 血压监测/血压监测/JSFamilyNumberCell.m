//
//  JSFamilyNumberCell.m
//  血压监测
//
//  Created by demo on 13-11-19.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSFamilyNumberCell.h"
#import "PNColor.h"
#import "JSUser.h"
#define cellHight 100
@interface JSFamilyNumberCell ()
{
    UIImageView *headImageView;
    UILabel *nameLab;
    UILabel *infoLab;
    UIButton *deleteButton;
}
@end
@implementation JSFamilyNumberCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *headBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        headBgView.center = CGPointMake(60, 50);
        headBgView.layer.cornerRadius = 40;
        headBgView.layer.masksToBounds = YES;
        headBgView.layer.borderWidth = 2;
        headBgView.layer.borderColor = PNGreen.CGColor;
        headBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:headBgView];
        
        headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        headImageView.center = headBgView.center;
        [self addSubview:headImageView];
        //添加姓名
        nameLab = [[UILabel alloc] initWithFrame:CGRectMake(110, 18, 200, 30)];
        nameLab.textColor = [UIColor whiteColor];
        nameLab.font = [UIFont boldSystemFontOfSize:25];
        nameLab.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLab];
        
        //添加信息
        infoLab = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 200, 45)];
        infoLab.numberOfLines = 0;
        infoLab.textColor = [UIColor whiteColor];
        infoLab.font = [UIFont boldSystemFontOfSize:15];
        infoLab.backgroundColor = [UIColor clearColor];
        [self addSubview:infoLab];
        
        deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width, 10, 30, cellHight-20)];
        deleteButton.backgroundColor = PNRed;
        [self addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:deleteButton.bounds];
        lab.text = @"删\n除";
        lab.font = [UIFont boldSystemFontOfSize:20];
        lab.textColor = [UIColor whiteColor];
        lab.numberOfLines = 0;
        lab.backgroundColor = [UIColor clearColor];
        [deleteButton addSubview:lab];
        
        
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeTheCell:)];
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipe];
        
        swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeTheCell:)];
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipe];
    }
    return self;
}
-(void)swipeTheCell:(UISwipeGestureRecognizer *)swipe
{
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionRight:
        {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                deleteButton.frame = CGRectMake(self.frame.size.width, 10, 30, cellHight-20);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case UISwipeGestureRecognizerDirectionLeft:
        {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                deleteButton.frame = CGRectMake(self.frame.size.width-30, 10, 30, cellHight-20);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        default:
            break;
    }
}
-(void)deleteButtonClick
{
    [JSUser deleteFamilyNumberWithName:nameLab.text];
    [self.delegate reloadFamilyData];
}
-(void)upCellDataWith:(JSPersonBloodData *)data
{
    headImageView.image = [UIImage imageNamed:data.headUrl];
    nameLab.text = data.name;
    infoLab.text = [NSString stringWithFormat:@"性别：%@ \n身高：%@ 体重%@",data.sex,data.hight,data.weight];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
