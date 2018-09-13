//
//  JJUtilTools.h
//  Cocoon
//
//  Created by 佳李 on 2018/5/13.
//  Copyright © 2018年 李佳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJUtilTools.h"
//#import "JZAlignmentLabel.h"
@interface JJUtilTools : NSObject

+ (NSString *)currentDateStr;

/// 获取缓存大小
+ (NSString *)cacheFolderSize;

//判断字符串是否为浮点数
+ (BOOL)isPureFloat:(NSString*)string;

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;


/**
 通过时间戳获取带格式的字符串

 @param fomatterString 格式样式
 @param interval 时间戳
 @return 格式好的字符串
 */
+ (NSString *)getDateStrignWithFormat: (NSString *)fomatterString
                             interval: (NSTimeInterval)interval;


/**
 通过日期获取带格式的字符串

 @param fomatterString 格式样式
 @param date 日期
 @return 格式好的字符串
 */
+ (NSString *)getDateStrignWithFormat: (NSString *)fomatterString
                                 date: (NSDate *)date;

@end

@interface UILabel (Extension)

// 快速创建Label
+ (UILabel *)labelWithFrame: (CGRect)frame
                       font: (UIFont *)font
                      color: (UIColor *)color
                    content: (NSString *)content;


/**
 获取活动文本的尺寸

 @param size 预设的尺寸
 @param font 文字大小
 @return 返回尺寸
 */
- (CGSize)getActualSize: (CGSize)size
                   font: (UIFont *)font;

@end

@interface UIView (addShadow)

/**
 添加投影

 @param color 投影颜色
 @param opacity 透明度
 @param size 偏移尺寸
 @param radius 圆角
 */
- (void)addShadowWithColor: (UIColor *)color
                   opacity: (CGFloat)opacity
                    offset: (CGSize)size
              cornerRadius: (CGFloat)radius;
 

/**
 移除投影
 */
- (void)removeShadow;


/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

@end


/**
 给NSDate 添加获取星座的扩展
 */
@interface NSDate (Zodiac)

typedef NS_ENUM(NSInteger, NSDateAstrologyZodiacSign) {
    NSDateAstrologyZodiacSignAquarius = 0,              // [1-20, 2-18] 水瓶座
    NSDateAstrologyZodiacSignPisces,                    // [2-19, 3-20] 双鱼座
    NSDateAstrologyZodiacSignAries,                     // [3-21, 4-19] 白羊座
    NSDateAstrologyZodiacSignTaurus,                    // [4-20, 5-20] 金牛座
    NSDateAstrologyZodiacSignGemini,                    // [5-21, 6-20] 双子座
    NSDateAstrologyZodiacSignCancer,                    // [6-21, 7-22] 巨蟹座
    NSDateAstrologyZodiacSignLeo,                       // [7-23, 8-22] 狮子座
    NSDateAstrologyZodiacSignVirgo,                     // [8-23, 9-22] 处女座
    NSDateAstrologyZodiacSignLibra,                     // [9-23, 10-22] 天秤座
    NSDateAstrologyZodiacSignScorpio,                   // [10-22, 11-21] 天蝎座
    NSDateAstrologyZodiacSignSagittarius,               // [11-22, 12-21] 射手座
    NSDateAstrologyZodiacSignCapricorn                  // [12-22, 1-19] 摩羯座
};

typedef NS_ENUM(NSInteger, NSDateAstrologyChineseZodiacSign) {
    NSDateAstrologyChineseZodiacSignRat = 0,                   // 鼠(子)
    NSDateAstrologyChineseZodiacSignOx,                        // 牛(丑)
    NSDateAstrologyChineseZodiacSignTiger,                     // 虎(寅)
    NSDateAstrologyChineseZodiacSignRabbit,                    // 兔(卯)
    NSDateAstrologyChineseZodiacSignDragon,                    // 龙(辰)
    NSDateAstrologyChineseZodiacSignSnake,                     // 蛇(巳)
    NSDateAstrologyChineseZodiacSignHorse,                     // 马(午)
    NSDateAstrologyChineseZodiacSignGoat,                      // 羊(未)
    NSDateAstrologyChineseZodiacSignMonkey,                    // 猴(申)
    NSDateAstrologyChineseZodiacSignRooster,                   // 鸡(酉)
    NSDateAstrologyChineseZodiacSignDog,                       // 狗(戌)
    NSDateAstrologyChineseZodiacSignPig                        // 猪(亥)
};

// 黄道十二宫
@property (nonatomic, readonly) NSDateAstrologyZodiacSign zodiacSign;

// 生肖序号
@property (nonatomic, readonly) NSDateAstrologyChineseZodiacSign chineseZodiacSign;


@property (strong, nonatomic) NSArray *zodiacNames;

@end

@interface NSDictionary (MyDelete)

- (NSDictionary *)deleteAllNullValue;

@end
 
#import <UIKit/UIKit.h>

@interface UIControl (XBControl)
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
