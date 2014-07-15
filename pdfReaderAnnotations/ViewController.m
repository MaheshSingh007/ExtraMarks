//
//  ViewController.m
//  pdfReaderAnnotations
//
//  Created by user01 on 10/07/14.
//  Copyright (c) 2014 user01. All rights reserved.
//

#import "ViewController.h"
#import "ReaderViewController.h"
#import <PSPDFKit/PSPDFKit.h>
#import "Tesseract.h"
#import "UIBezierPath+image.h"

@interface ViewController ()<PSPDFViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
        tableData = [NSArray arrayWithObjects:@"Class 1st.pdf", @"Class 2nd.pdf", @"Class 3rd.pdf", @"Class 4th.pdf",  nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *documentURL = [NSBundle.mainBundle.resourceURL URLByAppendingPathComponent:[tableData objectAtIndex:indexPath.row]];
    PSPDFDocument *document = [PSPDFDocument documentWithURL:documentURL];
    // Open view controller. Embed into an UINavigationController to enable the toolbar.
    PSPDFViewController *pdfController = [[PSPDFViewController alloc] initWithDocument:document];
    pdfController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:pdfController];
    [self presentViewController:navController animated:YES completion:NULL];
}



/// Control scrolling to pages. Not implementing this will return YES.
- (BOOL)pdfViewController:(PSPDFViewController *)pdfController shouldScrollToPage:(NSUInteger)page
{
    return YES;
}
/// Controller did show/scrolled to a new page. (at least 51% of it is visible)
- (void)pdfViewController:(PSPDFViewController *)pdfController didShowPageView:(PSPDFPageView *)pageView
{
    
}

/// Page was fully rendered at zoom level = 1.
- (void)pdfViewController:(PSPDFViewController *)pdfController didRenderPageView:(PSPDFPageView *)pageView
{
    
}

/// Called after pdf page has been loaded and added to the `pagingScrollView`.
- (void)pdfViewController:(PSPDFViewController *)pdfController didLoadPageView:(PSPDFPageView *)pageView
{
    
}

/// Called before a pdf page will be unloaded and removed from the `pagingScrollView`.
- (void)pdfViewController:(PSPDFViewController *)pdfController willUnloadPageView:(PSPDFPageView *)pageView
{
    
}

/// Will be called before the page rect has been dragged.
- (void)pdfViewController:(PSPDFViewController *)pdfController didBeginPageDragging:(UIScrollView *)scrollView
{
    
}



- (BOOL)pdfViewController:(PSPDFViewController *)pdfController shouldSelectText:(NSString *)text withGlyphs:(NSArray *)glyphs atRect:(CGRect)rect onPageView:(PSPDFPageView *)pageView
{
    
    return YES;
}

/// Called after text has been selected.
/// Will also be called when text has been deselected. Deselection sometimes cannot be stopped, so the `shouldSelectText:` will be skipped.
- (void)pdfViewController:(PSPDFViewController *)pdfController didSelectText:(NSString *)text withGlyphs:(NSArray *)glyphs atRect:(CGRect)rect onPageView:(PSPDFPageView *)pageView
{
    
}


///////  annotations  delegate  ///////////

- (BOOL)pdfViewController:(PSPDFViewController *)pdfController shouldDisplayAnnotation:(PSPDFAnnotation *)annotation onPageView
                         :(PSPDFPageView *)pageView
{
    
    return YES;
}

/**
 Delegate for tapping annotations. Will be called before the more general `didTapOnPageView:` if an annotationView is hit.
 
 Return YES to override the default action and custom-handle this.
 Default actions might be scroll to target page, open Safari, show a menu, ...
 
 Some annotations might not have an `annotationView` attached. (because they are rendered with the page content, for example highlight annotations)
 
 `annotationPoint` is the point relative to the `PSPDFAnnotation`, in PDF coordinate space.
 viewPoint is the point relative to the `PSPDFPageView`.
 */
- (BOOL)pdfViewController:(PSPDFViewController *)pdfController didTapOnAnnotation:(PSPDFAnnotation *)annotation annotationPoint:(CGPoint)annotationPoint annotationView:(UIView <PSPDFAnnotationViewProtocol> *)annotationView pageView:(PSPDFPageView *)pageView viewPoint:(CGPoint)viewPoint
{
    
//    NSLog(@"annotation.accessibilityHint %@",annotation.accessibilityHint);
//    NSLog(@"annotation.contents %@",annotation.contents);
//    NSLog(@"nnotation.description %@",annotation.description);
//    NSLog(@"annotation.localizedDescription %@",annotation.localizedDescription);
//    NSLog(@"annotation.name %@",annotation.name);
//    NSLog(@"annotation.subject %@",annotation.subject);
//    NSLog(@"annotation.typeString %@",annotation.typeString);
//    NSLog(@"annotation.user %@",annotation.user);
//    NSLog(@"annotation.userInfo %@",annotation.userInfo);
   
    if(annotation.type == PSPDFAnnotationTypeNone)
       NSLog(@"type 0 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeUndefined)
        NSLog(@"type 1 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeLink)
        NSLog(@"type 2 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeHighlight)
        NSLog(@"type 3 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeStrikeOut)
        NSLog(@"type 4 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeUnderline)
        NSLog(@"type 5 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeSquiggly)
        NSLog(@"type 6 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeFreeText)
        NSLog(@"type 7 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeInk)
    {
        
        PSPDFInkAnnotation *ink = (PSPDFInkAnnotation *)annotation;
        UIBezierPath *inkBp =  ink.bezierPath;
        UIImage *bezierDrawImage = [inkBp strokeImageWithColor:[UIColor blueColor]];
        [self getTextFromAnnotation:bezierDrawImage];
        
        NSLog(@"type 8 ---- %d",annotation.type);
    }
    else if(annotation.type == PSPDFAnnotationTypeSquare)
        NSLog(@"type 9 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeCircle)
        NSLog(@"type 10 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeLine)
        NSLog(@"type 11 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeNote)
        NSLog(@"type 12 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeStamp)
        NSLog(@"type 13 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeCaret)
        NSLog(@"type 14 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeRichMedia)
        NSLog(@"type 15 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeScreen)
        NSLog(@"type 16 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeWidget)
        NSLog(@"type 17 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeFile)
        NSLog(@"type 18 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeSound)
        NSLog(@"type 19 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypePolygon)
        NSLog(@"type 20 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypePopup)
        NSLog(@"type 21 ---- %d",annotation.type);
    else if(annotation.type == PSPDFANnotationTypeWatermark)
        NSLog(@"type 22 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeTrapNet)
        NSLog(@"type 23 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationType3D)
        NSLog(@"type 24 ---- %d",annotation.type);
    else if(annotation.type == PSPDFAnnotationTypeRedact)
        NSLog(@"type 25 ---- %d",annotation.type);
   
    return YES;
}


/// Called before an annotation will be selected. (but after `didTapOnAnnotation:`)
- (NSArray *)pdfViewController:(PSPDFViewController *)pdfController shouldSelectAnnotations:(NSArray *)annotations onPageView:(PSPDFPageView *)pageView
{
    
    return annotations;
}

/// Called after an annotation has been selected.
- (void)pdfViewController:(PSPDFViewController *)pdfController didSelectAnnotations:(NSArray *)annotations onPageView:(PSPDFPageView *)pageView
{
    
}
/// Returns a pre-generated `annotationView` that can be modified before being added to the view.
/// If no generator for a custom annotation is found, `annotationView` will be nil (as a replacement to viewForAnnotation)
/// To get the targeted rect use `[annotation rectForPageRect:pageView.bounds]`;
- (UIView <PSPDFAnnotationViewProtocol> *)pdfViewController:(PSPDFViewController *)pdfController annotationView:(UIView <PSPDFAnnotationViewProtocol> *)annotationView forAnnotation:(PSPDFAnnotation *)annotation onPageView:(PSPDFPageView *)pageView
{
    
    return annotationView;
}

/// Invoked prior to the presentation of the annotation view: use this to configure actions etc
/// @warning This will only be called for annotations that render as an overlay (that return YES for `isOverlay`)
/// `PSPDFLinkAnnotations` are handled differently (they don't have a selected state) - delegate will not be called for those.
- (void)pdfViewController:(PSPDFViewController *)pdfController willShowAnnotationView:(UIView <PSPDFAnnotationViewProtocol> *)annotationView onPageView:(PSPDFPageView *)pageView
{
    
}

/// Invoked after animation used to present the annotation view
/// @warning This will only be called for annotations that render as an overlay (that return YES for `isOverlay`)
/// `PSPDFLinkAnnotations` are handled differently (they don't have a selected state) - delegate will not be called for those.
- (void)pdfViewController:(PSPDFViewController *)pdfController didShowAnnotationView:(UIView <PSPDFAnnotationViewProtocol> *)annotationView onPageView:(PSPDFPageView *)pageView
{
}


-(void)getTextFromAnnotation:(UIImage *)image
{
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    [imageData writeToFile:savedImagePath atomically:NO];
//    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = ([documentPaths count] > 0) ? [documentPaths objectAtIndex:0] : nil;
    
    NSString *dataPath = [documentPath stringByAppendingPathComponent:@"tessdata"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // If the expected store doesn't exist, copy the default store.
    if (![fileManager fileExistsAtPath:dataPath]) {
        // get the path to the app bundle (with the tessdata dir)
        NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
        NSString *tessdataPath = [bundlePath stringByAppendingPathComponent:@"tessdata"];
        if (tessdataPath) {
            [fileManager copyItemAtPath:tessdataPath toPath:dataPath error:NULL];
        }
    }
    
    Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:dataPath language:@"eng"];
    [tesseract setVariableValue:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" forKey:@"tessedit_char_whitelist"];
    [tesseract setImage:image];
    [tesseract recognize];
    NSString *msg = [tesseract recognizedText];
    NSLog(@"get annotation text: %@", [tesseract recognizedText]);
    [tesseract clear];
    
    
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Emarks Text" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPdf"]) {
//        NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
//        ReaderViewController *destViewController = segue.destinationViewController;
//        destViewController.pdfName = [tableData objectAtIndex:indexPath.row];
  }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
