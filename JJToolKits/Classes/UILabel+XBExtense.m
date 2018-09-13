//
//  UILabel+XBExtense.m
//  PetBuddy
//
//  Created by 李佳 on 2018/6/30.
//  Copyright © 2018年 李佳. All rights reserved.
//

#import "UILabel+XBExtense.h"

@implementation UILabel (XBExtense)
// 快速创建Label
+ (UILabel *)labelWithFrame: (CGRect)frame
                       font: (UIFont *)font
                      color: (UIColor *)color
                    content: (NSString *)content{
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.font = font;
    label.textColor = color;
    label.text = content;
    return label;
}
@end
