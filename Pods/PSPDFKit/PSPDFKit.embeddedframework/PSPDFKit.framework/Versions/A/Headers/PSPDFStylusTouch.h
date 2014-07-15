//
//  PSPDFStylusTouch.h
//  PSPDFKit
//
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PSPDFStylusTouchClassification) {
    PSPDFStylusTouchClassificationUnknownDisconnected,
    PSPDFStylusTouchClassificationUnknown,
    PSPDFStylusTouchClassificationFinger,
    PSPDFStylusTouchClassificationPalm,
    PSPDFStylusTouchClassificationPen,
    PSPDFStylusTouchClassificationEraser,
};

@protocol PSPDFStylusTouch <NSObject>

@optional
- (CGPoint)locationInView:(UIView *)view;
- (PSPDFStylusTouchClassification)classification;
- (CGFloat)pressure;

@end

@interface PSPDFDefaultStylusTouch : NSObject <PSPDFStylusTouch>

- (id)initWithClassification:(PSPDFStylusTouchClassification)classification pressure:(CGFloat)pressure;

@property (nonatomic, assign, readonly) PSPDFStylusTouchClassification classification;
@property (nonatomic, assign, readonly) CGFloat pressure; // can be 0..1;

@end

@interface PSPDFStylusTouchClassificationInfo : NSObject

- (id)initWithTouch:(UITouch *)touch touchID:(NSInteger)touchID oldValue:(PSPDFStylusTouchClassification)oldValue newValue:(PSPDFStylusTouchClassification)newValue;

@property (nonatomic, strong, readonly) UITouch *touch;
@property (nonatomic, assign, readonly) NSInteger touchID;
@property (nonatomic, assign, readonly) PSPDFStylusTouchClassification oldValue;
@property (nonatomic, assign, readonly) PSPDFStylusTouchClassification newValue;

@end
