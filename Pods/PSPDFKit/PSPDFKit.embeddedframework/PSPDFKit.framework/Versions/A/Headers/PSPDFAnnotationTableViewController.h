//
//  PSPDFAnnotationTableViewController.h
//  PSPDFKit
//
//  Copyright (c) 2013-2014 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "PSPDFStatefulTableViewController.h"
#import "PSPDFStyleable.h"

@class PSPDFDocument, PSPDFAnnotation, PSPDFAnnotationTableViewController;

/// Delegate for the `PSPDFAnnotationTableViewController`.
@protocol PSPDFAnnotationTableViewControllerDelegate <PSPDFOverridable>

/// Will be called when the user touches an annotation cell.
- (void)annotationTableViewController:(PSPDFAnnotationTableViewController *)annotationController didSelectAnnotation:(PSPDFAnnotation *)annotation;

@end

/// Shows an overview of all annotations in the current document.
/// @note The toolbar/navigation items are populated in `viewWillAppear:` and can be changed in your subclass.
@interface PSPDFAnnotationTableViewController : PSPDFStatefulTableViewController <PSPDFStyleable>

/// Designated initializer.
- (id)initWithDocument:(PSPDFDocument *)document delegate:(id<PSPDFAnnotationTableViewControllerDelegate>)delegate;

/// Attached PDF controller.
@property (nonatomic, weak) PSPDFDocument *document;

/// Set to filter custom annotations. By default this is nil, which means it uses the `editableAnnotationTypes' of the `PSPDFDocument`.
/// This set takes strings like `PSPDFAnnotationStringHighlight`, `PSPDFAnnotationStringInk`, ...
@property (nonatomic, copy) NSOrderedSet *visibleAnnotationTypes;

/// Allow to long-press to copy the annotation. Defaults to YES.
@property (nonatomic, assign) BOOL allowCopy;

/// The annotation table view delegate.
@property (nonatomic, weak) id<PSPDFAnnotationTableViewControllerDelegate> delegate;

/// Reloads the displayed annotations and updates the internal cache.
- (void)reloadData;

@end

@interface PSPDFAnnotationTableViewController (SubclassingHooks)

// Customize to make more fine-grained changes to the displayed annotation than what would be possible via setting `visibleAnnotationTypes`.
// The result will be cached internally and only refreshed after `reloadData` is called. (the one on this controller, NOT on the table view)
- (NSArray *)annotationsForPage:(NSUInteger)page;

// Queries the cache to get the annotation for `indexPath`.
- (PSPDFAnnotation *)annotationForIndexPath:(NSIndexPath *)indexPath;

// Subclass to change the table view style. Defaults to `UITableViewStylePlain`.
- (UITableViewStyle)targetTableViewStyle;

@end
