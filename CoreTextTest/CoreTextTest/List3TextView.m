//
//  List3TextView.m
//  CoreTextTest
//
//  Created by I_MT on 2017/1/25.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

#import "List3TextView.h"
#import <CoreText/CoreText.h>
@implementation List3TextView
{
    CGRect _imgFrame;
    CTFrameRef _ctFrame;
    NSString *string;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    string=@"\n这里在测试图文混排，\n我是一个富文本";
    NSMutableAttributedString *atrtributeStr = [[NSMutableAttributedString  alloc]initWithString:string];
    CTRunDelegateCallbacks callBacks;
    memset(&callBacks, 0, sizeof(CTRunDelegateCallbacks));
    callBacks.version=kCTRunDelegateVersion1;
    callBacks.getAscent = ascentCallBaks;
    callBacks.getDescent = descentCallBacks;
    callBacks.getWidth = widthCallBacks;
    NSDictionary *dicPic = @{@"height":@129,@"width":@400};
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callBacks, (__bridge void * _Nullable)(dicPic));
    unichar placeHolder = 0xFFFC;
    NSString *placeHodlerStr = [NSString stringWithCharacters:&placeHolder length:1];
    NSMutableAttributedString *placeHolderAttrStr = [[NSMutableAttributedString alloc]initWithString:placeHodlerStr];
    CFAttributedStringSetAttribute((__bridge_retained CFMutableAttributedStringRef )placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    [atrtributeStr insertAttributedString:placeHolderAttrStr atIndex:12];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge_retained CFMutableAttributedStringRef)atrtributeStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, atrtributeStr.length), path, NULL);
    CTFrameDraw(frame, context);
    _ctFrame = frame;
    CFRetain(_ctFrame);
    UIImage *image = [UIImage imageNamed:@"hs.jpg"];
    CGRect imfRect = [self caculateImageRectWithFrame:frame];
    _imgFrame=imfRect;
    CGContextDrawImage(context, imfRect, image.CGImage);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}
static CGFloat ascentCallBaks(void *ref){
   return [[(__bridge NSDictionary*) ref valueForKey:@"height"]floatValue];
}
static CGFloat descentCallBacks(void *ref){
    return 0;
}
static CGFloat widthCallBacks(void *ref){
#pragma mark -----??? 这里如果是__bridge__transfer会崩溃的！
    return [[(__bridge NSDictionary *)ref valueForKey:@"width"]floatValue];
}
-(CGRect)caculateImageRectWithFrame:(CTFrameRef)frame{
    NSArray *arrLines  = (NSArray *)CTFrameGetLines(frame);
    NSInteger count = [arrLines count];
    CGPoint points[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
    for (int i =0; i<count; i++) {
        CTLineRef line = (__bridge  CTLineRef)arrLines[i];
        NSArray *arrGlyphRuns = (NSArray *)CTLineGetGlyphRuns(line);
        for (int j=0; j<arrGlyphRuns.count; j++) {
            CTRunRef run = (__bridge  CTRunRef)arrGlyphRuns[j];
            NSDictionary *attributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge   CTRunDelegateRef)([attributes valueForKey:(NSString *)kCTRunDelegateAttributeName]);
            if (delegate == nil) {
                continue;
            }
            NSDictionary *dic = CTRunDelegateGetRefCon(delegate);
            if (![dic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            CGPoint point = points[i];
            CGFloat ascent;
            CGFloat descent;
            CGRect boundsRun;
            boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            boundsRun.size.height=ascent+descent;
            CGFloat offset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            boundsRun.origin.x=point.x+offset;
            boundsRun.origin.y=point.y-descent;
            CGPathRef path = CTFrameGetPath(frame);
            #pragma mark -----???不清楚为什么要设置这个偏移
            CGRect colRect = CGPathGetBoundingBox(path);
            CGRect imageRect = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);
            return imageRect;
        }

    }
    return CGRectZero;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint location = [self systemPointFromScreenPoint:[touch locationInView:self]];
    if ([self checkIsClickOnImgWithPoint:location]) {
        return;
    }
    [self ClickOnStrWithPoint:location];

}
-(BOOL)checkIsClickOnImgWithPoint:(CGPoint)location
{
    if ([self isFrame:_imgFrame containsPoint:location]) {
        NSLog(@"您点击到了图片");
        return YES;
    }
    return NO;
}
-(void)ClickOnStrWithPoint:(CGPoint)location{
    NSArray * arrLines = (NSArray *)CTFrameGetLines(_ctFrame);
    NSInteger count = [arrLines count];
    CGPoint points[count];
    CTFrameGetLineOrigins(_ctFrame, CFRangeMake(0, 0), points);
    CGPoint p = points[count-1];
    for (int i = 0; i < count; i ++) {
        CTLineRef line = (__bridge CTLineRef)arrLines[i];
        NSArray * ctRuns = (NSArray *)CTLineGetGlyphRuns(line);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        CGPoint point = points[i];
        if (location.y>point.y-lineLeading-lineDescent&&location.y<point.y+lineAscent) {
        #pragma mark -----???CTLineGetStringIndexForPosition 不是那么准确的
            CFIndex index = CTLineGetStringIndexForPosition(line,location);//点击的位置
            //这个并不是那么精确的
            if (index>string.length-1) {
                return;
            }
            unichar c=  [string characterAtIndex:index];
            NSString *string1 = [NSString stringWithCharacters:&c length:1];
            NSLog(@"index %ld---""%@""", index,string1);
            
        }
        for (int j = 0; j < ctRuns.count; j ++) {
            CTRunRef run = (__bridge CTRunRef)ctRuns[j];
            NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run);
            CGFloat runAscent;
            CGFloat runDescent;
            CGFloat runLeading;
            CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &runAscent, &runDescent, &runLeading);
           /* if (index !=kCFNotFound) {
                unichar c=  [string characterAtIndex:index];
                NSString *string = [NSString stringWithCharacters:&c length:1];
                NSLog(@"点击了第%d行的 ""%@""字 ",i,string);
            }*/
          }
    }
}
-(BOOL)isFrame:(CGRect)frame containsPoint:(CGPoint)point
{
    return CGRectContainsPoint(frame, point);
}


-(CGPoint)systemPointFromScreenPoint:(CGPoint)origin
{
    return CGPointMake(origin.x, self.bounds.size.height - origin.y);
}
@end
