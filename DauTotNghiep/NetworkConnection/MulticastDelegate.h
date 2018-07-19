//
//  MulticastDelegate.h
//  MulticastDelegate


#import <Foundation/Foundation.h>

@interface MulticastDelegate : NSObject

@property (nonatomic,strong) NSHashTable *newDelegate;

// Adds the given delegate implementation to the list of observers
- (void)addDelegate:(id)delegate;

// Removes the given delegate implementation from the list of observers
- (void)removeDelegate:(id)delegate;

// Removes all delegates
- (void)removeAllDelegates;

// Hashtable of all delegates
- (NSHashTable *)delegates;
- (BOOL)respondsToSelector:(SEL)aSelector andDelegate:(id)delegateItem;

@end
