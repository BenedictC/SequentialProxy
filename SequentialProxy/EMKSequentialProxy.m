//
//  EMKSequentialProxy.m
//  SequentialProxy
//
//  Created by Benedict Cohen on 09/07/2013.
//  Copyright (c) 2013 Benedict Cohen. All rights reserved.
//

#import "EMKSequentialProxy.h"
#import "EMKReentrantSerialQueue.h"



@implementation EMKSequentialProxy
{
    id _object;
    EMKReentrantSerialQueue *_serialQueue;
}



+(id)sequentialProxyWithObject:(id)object serialQueue:(EMKReentrantSerialQueue *)serialQueue
{
    EMKSequentialProxy *proxy = [self alloc];
    
    NSAssert(object != nil, @"Attempted to create %@ with nil object.", NSStringFromClass([self class]));

    proxy->_object = object;
    proxy->_serialQueue = (serialQueue == nil) ? [EMKReentrantSerialQueue new] : serialQueue;
    
    return proxy;
}



-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_object methodSignatureForSelector:sel];
}



-(void)forwardInvocation:(NSInvocation *)invocation
{
    [_serialQueue performBlock:^{
        [invocation invokeWithTarget:_object];
    }];
}

@end
