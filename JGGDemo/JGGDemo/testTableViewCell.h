//
//  testTableViewCell.h
//  JGGDemo
//
//  Created by apple on 17/12/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XC_JGGView.h"
@interface testTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet XC_JGGView *jggview;

//距离右边的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWidth;

@end
