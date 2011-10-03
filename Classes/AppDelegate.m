//
//  AppDelegate.m
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import "AppDelegate.h"

#import "MyListViewCell.h"

#pragma mark Constants

#define LISTVIEW_CELL_IDENTIFIER		@"MyListViewCell"
#define NUM_EXAMPLE_ITEMS				2

@interface AppDelegate()

- (void)reloadData;
- (void)measureData;

@end

@implementation AppDelegate

@synthesize heightList = _heightList;

#pragma mark -
#pragma mark Init/Dealloc

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowResized:) name:LISTVIEW_RESIZED_NOTIFICATION object:nil];
	[listView setCellSpacing:0.0f];
	[listView setAllowsEmptySelection:YES];
	[listView setAllowsMultipleSelection:YES];
	[listView registerForDraggedTypes:[NSArray arrayWithObjects: NSStringPboardType, nil]];
	
	_listItems = [[NSMutableArray alloc] init];
    self.heightList = [[[NSMutableArray alloc] init] autorelease];

    [self reloadData];
}

- (void)windowResized:(NSNotification *)notification
{
    [self reloadData];
}

- (void)reloadData
{
    [_listItems removeAllObjects];
    for (int i=0; i<1; i++) {
        NSString *title = @"2009年5月，上海图书馆上海科学技术情报研究所（以下简称上图情报所）推出“创之源”中小企业信息服务。为能更持续、更主动地为中小企业提供深层次服务，从2009年10月开始，“创之源”开始尝试中小企业信息推送工作。2009年5月，上海图书馆上海科学技术情报研究所（以下简称上图情报所）推出“创之源”中小企业信息服务。为能更持续、更主动地为中小企业提供深层次服务，从2009年10月开始，“创之源”开始尝试中小企业信息推送工作。2009年5月，上海图书馆上海科学技术情报研究所（以下简称上图情报所）推出“创之源”中小企业信息服务。为能更持续、更主动地为中小企业提供深层次服务，从2009年10月开始，“创之源”开始尝试中小企业信息推送工作。";
        [_listItems addObject:title];
        [title release];
        title = @"2009年5月，上海图书馆上海科学技信息推送工作。";
        [_listItems addObject:title];
        [title release];
        title = @"2009年5月，上海图书馆上海科学技术情报研究所（以下简称上图情报所）推出“创之源”中小企业信息服务。为能更持续、更主动地为中小企业提供深层次服务，从2009年10月开始，“创之源”开始尝试中小企业信息推送工作。2009年5月，上海图信息推送工作。";
        [_listItems addObject:title];
        [title release];
        title = @"This method takes into account of the size of the image or text within a certain offset determined by the border type of the cell. If the receiver is of text type, the text is resized to fit within aRect (as much as aRect is within the bounds of the cell).";
        [_listItems addObject:title];
        [title release];
    }
    
    [self measureData];
	
	[listView reloadData];
}

- (void)measureData
{
    [self.heightList removeAllObjects];
    for (NSString *s in _listItems) {
//        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
//                               [NSFont systemFontOfSize:13], NSFontAttributeName,
//                               nil] ;
//        NSAttributedString* as = [[NSAttributedString alloc] initWithString:s
//                                                                 attributes:attrs];
//        float width = listView.contentView.frame.size.width;
//        float answer = [as heightForWidth:width];
        float width = listView.contentView.frame.size.width;
        NSTextField *textField = [[NSTextField alloc] initWithFrame:CGRectMake(0, 0, width, 1000)];
        textField.font = [NSFont boldSystemFontOfSize:13];
        textField.stringValue = s;
        NSSize size = [textField.cell cellSizeForBounds:textField.frame];
        [textField release];
        
        [self.heightList addObject:[NSNumber numberWithFloat:size.height]];
    }
}

- (void)dealloc
{
	[_listItems release], _listItems=nil;
    
	[super dealloc];
}

#pragma mark -
#pragma mark List View Delegate Methods

- (NSUInteger)numberOfRowsInListView: (PXListView*)aListView
{
#pragma unused(aListView)
	return [_listItems count];
}

- (PXListViewCell*)listView:(PXListView*)aListView cellForRow:(NSUInteger)row
{
	MyListViewCell *cell = (MyListViewCell*)[aListView dequeueCellWithReusableIdentifier:LISTVIEW_CELL_IDENTIFIER];
	
	if(!cell) {
		cell = [MyListViewCell cellLoadedFromNibNamed:@"MyListViewCell" reusableIdentifier:LISTVIEW_CELL_IDENTIFIER];
	}
	
	// Set up the new cell:
	[[cell titleLabel] setStringValue:[_listItems objectAtIndex:row]];
	
	return cell;
}

- (CGFloat)listView:(PXListView*)aListView heightOfRow:(NSUInteger)row
{
    return [[self.heightList objectAtIndex:row] floatValue];
}

- (void)listViewSelectionDidChange:(NSNotification*)aNotification
{
    NSLog(@"Selection changed");
}

- (void)listViewResize:(PXListView *)aListView
{
    [self reloadData];
}


// The following are only needed for drag'n drop:
- (BOOL)listView:(PXListView*)aListView writeRowsWithIndexes:(NSIndexSet*)rowIndexes toPasteboard:(NSPasteboard*)dragPasteboard
{
	// +++ Actually drag the items, not just dummy data.
	[dragPasteboard declareTypes: [NSArray arrayWithObjects: NSStringPboardType, nil] owner: self];
	[dragPasteboard setString: @"Just Testing" forType: NSStringPboardType];
	
	return YES;
}

- (NSDragOperation)listView:(PXListView*)aListView validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSUInteger)row
							proposedDropHighlight:(PXListViewDropHighlight)dropHighlight;
{
	return NSDragOperationCopy;
}

//- window

- (IBAction) reloadTable:(id)sender
{
	[self reloadData];
}

@end
