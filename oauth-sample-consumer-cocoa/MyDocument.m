//
//  MyDocument.m
//  oauth-sample-consumer
//
//  Created by Owen Evans on 20/02/2009.
//  Copyright Xero.com 2009 . All rights reserved.
//

#import "MyDocument.h"
#import "RequestTokenViewController.h"
#import "AccessTokenViewController.h"
#import "OAuthRequestController.h"
@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
    
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
		viewControllers = [[NSMutableArray alloc]init];
		sharedValueDictionary = [[NSMutableDictionary alloc]init];
		ManagingViewController *vc1 = [[RequestTokenViewController alloc]init];
		[vc1 setManagedObjectContext:[self managedObjectContext]];
		[vc1 setParent:self];
		[viewControllers addObject:vc1];
		[vc1 release];
		
		
		ManagingViewController *vc2 = [[AccessTokenViewController alloc]init];
		[vc2 setManagedObjectContext:[self managedObjectContext]];
		[vc2 setParent:self];
		[viewControllers addObject:vc2];
		[vc2 release];
		
		ManagingViewController *vc3 = [[OAuthRequestController alloc]init];
		[vc3 setManagedObjectContext:[self managedObjectContext]];
		[vc3 setParent:self];
		[viewControllers addObject:vc3];
		[vc3 release];
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

-(void) windowControllerDidLoadNib:(NSWindowController *)wc
{
	[super windowControllerDidLoadNib:wc];
	[self setViewName:@"GetRequestToken"];
}
- (void) dealloc
{
	[viewControllers release];
	[sharedValueDictionary release];
	[super dealloc];
	
}
-(void)displayViewController:(ManagingViewController *)vc
{
	//try to end editing
	NSWindow *w = [view window];
	BOOL ended = [w makeFirstResponder:w];
	if(!ended)
	{
		NSBeep();
		return;
	}
	//put the view in the box
	NSView *v = [vc view];
	view = v;
	[w setContentView:nil];
	[w setContentView:v];
	
	
	
}
-(IBAction) changeViewController:(id)sender
{
	int i = [sender tag];
	ManagingViewController *vc = [viewControllers objectAtIndex:i];
	[self displayViewController:vc];
	
}
-(void) setViewName:(NSString *) viewName
{

	if([viewName isEqualToString: @"GetRequestToken"])
	{
		ManagingViewController *vc = [viewControllers objectAtIndex:0];
		[self displayViewController:vc];

	}
	if([viewName isEqualToString: @"GetAccessToken"])
	{
		ManagingViewController *vc = [viewControllers objectAtIndex:1];
		[self displayViewController:vc];

	}	
	if([viewName isEqualToString:@"OAuthRequest"])
	{
		ManagingViewController *vc = [viewControllers objectAtIndex:2];
		[self displayViewController:vc];
	}
	
}
-(id) getSharedValue:(NSString *)key
{
	return [sharedValueDictionary objectForKey:key];	
}
-(void) setSharedValue:(id)value 
forKey:(NSString *) key
{
	[sharedValueDictionary setObject:value forKey:key];
	 }

@end
