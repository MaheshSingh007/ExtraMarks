//
//  ReaderViewController.m
//  pdfReaderAnnotations
//
//  Created by user01 on 10/07/14.
//  Copyright (c) 2014 user01. All rights reserved.
//

#import "ReaderViewController.h"
#import <PSPDFKit/PSPDFKit.h>


@interface ReaderViewController ()
{
    PSPDFViewController *pdfController;
    PSPDFDocument *document;
}
@end

@implementation ReaderViewController
@synthesize pdfName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSURL *documentURL = [NSBundle.mainBundle.resourceURL URLByAppendingPathComponent:@"Class 1st.pdf"];
    document = [PSPDFDocument documentWithURL:documentURL];
    // Open view controller. Embed into an UINavigationController to enable the toolbar.
    pdfController = [[PSPDFViewController alloc] initWithDocument:document];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:pdfController];
    [self presentViewController:navController animated:YES completion:NULL];
    
   
    
    // File paths
   
    
}
- (IBAction)checkAction:(id)sender
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *pdfPath1 = [documentsDirectory stringByAppendingPathComponent:@"Class 1st.pdf"];
//    NSString *pdfPath2 = [documentsDirectory stringByAppendingPathComponent:@"Class 2nd.pdf"];;
//    NSArray *arr = [NSArray arrayWithObjects:pdfPath1,pdfPath2, nil];
//     NSString *path =  [self joinPDF:arr];
//    NSLog(@"path %@",path);
  
}

- (NSString *)joinPDF:(NSArray *)listOfPaths {
    // File paths
    NSString *fileName = @"ALL.pdf";
    NSString *pdfPathOutput = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    CFURLRef pdfURLOutput = (  CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:pdfPathOutput]);
    
    NSInteger numberOfPages = 0;
    // Create the output context
    CGContextRef writeContext = CGPDFContextCreateWithURL(pdfURLOutput, NULL, NULL);
    
    for (NSString *source in listOfPaths) {
        CFURLRef pdfURL = (  CFURLRef)CFBridgingRetain([[NSURL alloc] initFileURLWithPath:source]);
        
        //file ref
        CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithURL((CFURLRef) pdfURL);
        numberOfPages = CGPDFDocumentGetNumberOfPages(pdfRef);
        
        // Loop variables
        CGPDFPageRef page;
        CGRect mediaBox;
        
        // Read the first PDF and generate the output pages
       // DLog(@"GENERATING PAGES FROM PDF 1 (%@)...", source);
        for (int i=1; i<=numberOfPages; i++) {
            if (i==1)
                continue;
            page = CGPDFDocumentGetPage(pdfRef, i);
            mediaBox = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);
            CGContextBeginPage(writeContext, &mediaBox);
            CGContextDrawPDFPage(writeContext, page);
            CGContextEndPage(writeContext);
        }
        
        CGPDFDocumentRelease(pdfRef);
        CFRelease(pdfURL);
    }
    CFRelease(pdfURLOutput);
    
    // Finalize the output file
    CGPDFContextClose(writeContext);
    CGContextRelease(writeContext);
    
    return pdfPathOutput;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
