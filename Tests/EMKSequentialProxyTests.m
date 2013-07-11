//
//  EMKSequentialProxyTests.m
//  SequentialProxy
//
//  Created by Benedict Cohen on 11/07/2013.
//  Copyright (c) 2013 Benedict Cohen. All rights reserved.
//

#import "EMKSequentialProxyTests.h"
#import "EMKSequentialProxy.h"
#import "EMKReentrantSerialQueue.h"



@interface EMKSequentialProxyTests ()
@property(nonatomic) EMKReentrantSerialQueue *queue;
@property(nonatomic) id object;
@property(nonatomic) id proxiedObject;
@end



@implementation EMKSequentialProxyTests

- (void)setUp
{
    [super setUp];    
    self.queue = [EMKReentrantSerialQueue new];
    self.object = [NSString class];
    self.proxiedObject = [EMKSequentialProxy sequentialProxyWithObject:self.object serialQueue:nil];
}



- (void)tearDown
{
    
    [super tearDown];
}



-(void)testProxy
{
    STAssertFalse(self.object == self.proxiedObject, @"");
    STAssertEqualObjects([self.object stringWithFormat:@""], [self.proxiedObject stringWithFormat:@""], @"");
}
@end
