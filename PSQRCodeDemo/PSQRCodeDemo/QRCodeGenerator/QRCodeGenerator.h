//
//  QRCodeGenerator.h
//  HYBmerchant
//
//  Created by 冯广勇 on 2017/8/9.
//  Copyright © 2017年 HYBiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 @enum QRCodeCorrectionLevel
 @abstract
 Constants indicating the percentage of the symbol that is dedicated to error correction.
 
 @constant QRCodeCorrectionLevelL
 Indicates that approximately 20% of the symbol data is dedicated to error correction.
 @constant QRCodeCorrectionLevelM
 Indicates that approximately 37% of the symbol data is dedicated to error correction.
 @constant QRCodeCorrectionLevelQ
 Indicates that approximately 55% of the symbol data is dedicated to error correction.
 @constant QRCodeCorrectionLevelH
 Indicates that approximately 65% of the symbol data is dedicated to error correction.
 */
typedef NS_ENUM(NSUInteger) {
    QRCodeCorrectionLevelL = 0,
    QRCodeCorrectionLevelM,
    QRCodeCorrectionLevelQ,
    QRCodeCorrectionLevelH
}QRCodeCorrectionLevel;

@interface QRCodeGenerator : NSObject

/** 二维码图片默认尺寸为260点, 默认容错级别为QRCodeCorrectionLevelM */
+(UIImage *)generateQRCodeImageWithString:(NSString *)string;
/** 二维码图片默认尺寸为260点, 默认容错级别为QRCodeCorrectionLevelM */
+(UIImage *)generateQRCodeImageWithString:(NSString *)string width:(CGFloat)width;
/** 二维码图片默认尺寸为260点, 默认容错级别为QRCodeCorrectionLevelM */
+(UIImage *)generateQRCodeImageWithString:(NSString *)string width:(CGFloat)width correctionLevel:(QRCodeCorrectionLevel)level;

@end
