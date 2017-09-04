//
//  QRCodeGenerator.m
//  HYBmerchant
//
//  Created by 冯广勇 on 2017/8/9.
//  Copyright © 2017年 HYBiOS. All rights reserved.
//

#import "QRCodeGenerator.h"

@implementation QRCodeGenerator

static const QRCodeCorrectionLevel defaultLevel = QRCodeCorrectionLevelM;
static const double defaultImageWidth = 260.;

+(UIImage *)generateQRCodeImageWithString:(NSString *)string
{
    return [self generateQRCodeImageWithString:string width:defaultImageWidth];
}

+(UIImage *)generateQRCodeImageWithString:(NSString *)string width:(CGFloat)width
{
    return [self generateQRCodeImageWithString:string width:width correctionLevel:defaultLevel];
}

+(UIImage *)generateQRCodeImageWithString:(NSString *)string width:(CGFloat)width correctionLevel:(QRCodeCorrectionLevel)level
{
    width = width ?: defaultImageWidth;
    level = level > 3 ? 3 : level;
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *correctionLevel = @[@"L", @"M", @"Q", @"H"][level];
    [filter setValue:correctionLevel forKey:@"inputCorrectionLevel"];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *ciImage = [filter outputImage];
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformMakeScale(width/20, width/20)];
    
//    UIImage *qrImage = [UIImage imageWithCIImage:ciImage];
//    CGSize imgSize = CGSizeMake(width, width);
//    UIGraphicsBeginImageContext(imgSize);
//    [qrImage drawInRect:CGRectMake(0, 0, width, width)];
//    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return finalyImage;
    
    return [self generatorClearImageWithCIImage:ciImage width:width];
}

+ (UIImage *)generatorClearImageWithCIImage:(CIImage *)image width:(CGFloat)width {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(width/CGRectGetWidth(extent), width/CGRectGetHeight(extent));
    
    // 创建bitmap（位图
    size_t imgWidth = CGRectGetWidth(extent) * scale;
    size_t imgHeight = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceGray();
    CGContextRef ctx = CGBitmapContextCreate(nil, imgWidth, imgHeight, 8, 0, space, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(ctx, kCGInterpolationNone);
    CGContextScaleCTM(ctx, scale, scale);
    CGContextDrawImage(ctx, extent, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(ctx);
    CGContextRelease(ctx);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
