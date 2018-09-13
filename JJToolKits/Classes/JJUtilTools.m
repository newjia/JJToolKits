//
//  JJUtilTools.m
//  Cocoon
//
//  Created by 佳李 on 2018/5/13.
//  Copyright © 2018年 李佳. All rights reserved.
//

#import "JJUtilTools.h"

@implementation JJUtilTools
//获取当前时间
+ (NSString *)currentDateStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS "];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}

// 缓存大小
+ (NSString *)cacheFolderSize{
    CGFloat folderSize = 0;

    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];

    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];

    for(NSString *path in files) {

        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];

        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    NSString *cacheString = @"";
    if (folderSize == 0) {
        cacheString = @"0";
    }else if(folderSize < 1024 * 1024) {
        cacheString =  @"<1M";
    }else if(folderSize < 1024 * 1024 * 1024){
        cacheString = [NSString stringWithFormat:@"%.2fM", folderSize / 1024.0 / 1024.0];
    }else{
        cacheString = [NSString stringWithFormat:@"%.2fG", folderSize / 1024.0 / 1024.0 / 1024.0];
    }
    return cacheString;
}

//判断字符串是否为浮点数
+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (NSString *)getDateStrignWithFormat: (NSString *)fomatterString
                             interval: (NSTimeInterval)interval{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:fomatterString];
    NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString *dateString = [fomatter stringFromDate:targetDate];
    return dateString;
}

+ (NSString *)getDateStrignWithFormat: (NSString *)fomatterString
                                 date: (NSDate *)date{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:fomatterString];
    NSString *dateString = [fomatter stringFromDate:date];
    return dateString;
}

@end


@implementation UILabel (Extension)

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


- (CGSize)getActualSize:(CGSize)size font:(UIFont *)font{
    if (self.text.length == 0) {
        return CGSizeZero;
    }
    NSLog(@"TEXT        %@", self.text);
    // 动态计算文本宽度
    CGRect textR = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :font} context:nil];
    return textR.size;
}

@end

@implementation UIView (addShadow)

- (void)addShadowWithColor: (UIColor *)color opacity: (CGFloat)opacity offset: (CGSize)size cornerRadius: (CGFloat)radius{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = size;
    self.layer.cornerRadius = radius;
}

- (void)removeShadow{
    self.layer.shadowColor = [UIColor clearColor].CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.cornerRadius = 0;
}

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {

    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];

    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {

    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];

    self.layer.mask = shape;
}

@end

@implementation NSDate (Zodiac)

- (NSDateAstrologyZodiacSign)zodiacSign
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];

    NSInteger temp = components.month * 100 + components.day;

    static dispatch_once_t onceToken;
    static NSArray<NSNumber *> *signs;
    dispatch_once(&onceToken, ^{
        signs = @[@120, @219, @321, @420, @521, @621, @723, @823, @923, @1023, @1122, @1222];
    });

    __block NSDateAstrologyZodiacSign sign = NSDateAstrologyZodiacSignCapricorn;

    [signs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if (temp < [obj integerValue])
        {
            if (idx != 0) sign = idx-1;
            *stop = YES;
        }
    }];

    return sign;
}

- (NSDateAstrologyChineseZodiacSign)chineseZodiacSign
{
    NSCalendar *chineseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear fromDate:self];

    NSInteger year = components.year;

    return (year-1)%12;
}

- (void)setZodiacNames:(NSArray *)zodiacNames{

}
- (NSArray *)zodiacNames{
    return @[@"水瓶座",
             @"双鱼座",
             @"白羊座",
             @"金牛座",
             @"双子座",
             @"巨蟹座",
             @"狮子座",
             @"处女座",
             @"天秤座",
             @"天蝎座",
             @"射手座",
             @"摩羯座"];
}


@end

@implementation NSDictionary (MyDelete)



- (NSDictionary *)deleteAllNullValue{

    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];

    for (NSString *keyStr in self.allKeys) {

        if ([[self objectForKey:keyStr]isEqual:[NSNull null]]) {

            [mutableDic setObject:@"" forKey: keyStr];

        }

        else{

            [mutableDic setObject:[self objectForKey: keyStr] forKey:keyStr];
        }

    }

    return mutableDic;

}



@end

 
#import <objc/runtime.h>

static id key;
static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation UIControl (XBControl)


- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*) event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}
@end
