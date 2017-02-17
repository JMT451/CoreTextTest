//
//  UIFont+Generator.m
//  CoreTextTest
//
//  Created by I_MT on 2017/2/6.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

#import "UIFont+Generator.h"
#import <CoreText/CoreText.h>
@implementation UIFont (Generator)
+ (UIFont *)yq_cloudFontWithFilePath:(NSString *)filePath size:(CGFloat)size
{
    UIFont *systemFont = [UIFont systemFontOfSize:size];
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        return systemFont;
    }
    CFURLRef fontURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (__bridge CFStringRef)filePath, kCFURLPOSIXPathStyle, false);
    CGDataProviderRef dataProvider = CGDataProviderCreateWithURL(fontURL);
    if(!dataProvider) return systemFont;
    CFRelease(fontURL);
    [UIFont familyNames];
    CGFontRef graphicsFont = CGFontCreateWithDataProvider(dataProvider);
    CGDataProviderRelease(dataProvider);
    if (!graphicsFont) return systemFont;
    CTFontRef smallFont = CTFontCreateWithGraphicsFont(graphicsFont, size, NULL, NULL);
    CGFontRelease(graphicsFont);
    UIFont *returnFont = (__bridge UIFont *)smallFont;
    CFRelease(smallFont);
    return returnFont;
}
@end
