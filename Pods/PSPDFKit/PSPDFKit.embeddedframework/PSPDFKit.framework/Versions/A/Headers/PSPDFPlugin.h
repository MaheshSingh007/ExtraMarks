//
//  PSPDFPlugin.h
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

@class PSPDFPluginRegistry;

extern const NSUInteger PSPDFPluginProtocolVersion_1;

extern NSString * const PSPDFPluginNameKey;
extern NSString * const PSPDFPluginEnabledKey;
extern NSString * const PSPDFPluginProtocolVersionKey;

@protocol PSPDFPlugin <NSObject>

// Designated initializer. Will be called upon creation.
- (id)initWithPluginRegistry:(PSPDFPluginRegistry *)pluginRegistry options:(NSDictionary *)options;

// Plugin details for auto-discovery.
+ (NSDictionary *)pluginInfo;

@end
