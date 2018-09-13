//
//  UILabel+XBExtense.h
//  PetBuddy
//
//  Created by 李佳 on 2018/6/30.
//  Copyright © 2018年 李佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XBExtense)
// 快速创建Label
+ (UILabel *)labelWithFrame: (CGRect)frame
                       font: (UIFont *)font
                      color: (UIColor *)color
                    content: (NSString *)content;
@end
