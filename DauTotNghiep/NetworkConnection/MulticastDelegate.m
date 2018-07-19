//
//  MulticastDelegate.m
//  MulticastDelegate

#import "MulticastDelegate.h"

@implementation MulticastDelegate {
    // the array of observing delegates
    NSHashTable* _delegates;
    // NSMutableArray *_delegates;
    BOOL isFowarding;
    //   id newDelegate;
    
    id deleteDelegate;
}
@synthesize newDelegate = _newDelegate;



- (id)init {
    if (self = [super init]) {
        _delegates = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        // _delegates = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)addDelegate:(id)delegate {
    
    // [_delegates addObject:delegate];
    
    
    if (!isFowarding) {
        [_delegates addObject:delegate];
    }else {
        [self.newDelegate addObject: delegate];
    }
    
}

- (NSHashTable*)newDelegate
{
    if(_newDelegate == nil)
    {
        _newDelegate = [[NSHashTable alloc] init];
    }
    return _newDelegate;
}


- (void)removeDelegate:(id)delegate {
    
    if (!isFowarding) {
        [_delegates removeObject:delegate];
    }else{
        deleteDelegate = delegate;
    }
    
}

- (void)removeAllDelegates {
    if (!isFowarding) {
        [_delegates removeAllObjects];
    }
}


- (NSHashTable *)delegates {
    return _delegates;
}


- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    
    // if any of the delegates respond to this selector, return YES
    for(id delegate in _delegates) {
        if ([delegate respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)respondsToSelector:(SEL)aSelector andDelegate:(id)delegateItem
{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    
    // if any of the delegates respond to this selector, return YES
    for(id delegate in _delegates) {
        if ([delegate respondsToSelector:aSelector] && delegate == delegateItem) {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    // can this class create the signature?
    NSMethodSignature* signature = [super methodSignatureForSelector:aSelector];
    
    // if not, try our delegates
    if (!signature) {
        for(id delegate in _delegates) {
            if ([delegate respondsToSelector:aSelector]) {
                return [delegate methodSignatureForSelector:aSelector];
            }
        }
    }
    return signature;
}
    

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // forward the invocation to every delegate
    
    
    isFowarding = YES;
    
    
    for(id delegate in _delegates) {
        
        if ([delegate respondsToSelector:[anInvocation selector]]) {
            [anInvocation invokeWithTarget:delegate];
        }
    }
    
    
    isFowarding = NO;
    
    if (_newDelegate) {
        
        for(id object in _newDelegate)
        {
            [self addDelegate:object];
        }
        _newDelegate =nil;
    }
    
    
    if (deleteDelegate) {
        [self removeDelegate:deleteDelegate];
        deleteDelegate = nil;
    }
    
    
    
}

@end
