//
//  NSString+JhForm.m
//  JhFormDemo
//
//  Created by Jh on 2018/6/26.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "NSString+JhForm.h"

@implementation NSString (JhForm)

- (NSString *)addUnit:(NSString *)unit {
    if ([self isEqualToString:@""] || [unit isEqualToString:@""]) {
        return self;
    }
    return [NSString stringWithFormat:@"%@ %@", self, unit];
}


- (CGSize)sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}




@end
