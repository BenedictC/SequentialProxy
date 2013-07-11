//
//  EMKReentrantSerialQueueTests.m
//  SequentialProxy
//
//  Created by Benedict Cohen on 09/07/2013.
//  Copyright (c) 2013 Benedict Cohen. All rights reserved.
//

#import "EMKReentrantSerialQueueTests.h"
#import "EMKReentrantSerialQueue.h"
#import "EMKSequentialProxy.h"



@interface EMKReentrantSerialQueueTests ()
@property(nonatomic) EMKReentrantSerialQueue *queue;
@property(nonatomic) id object;
@property(nonatomic) id proxiedObject;
@end



@implementation EMKReentrantSerialQueueTests

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



- (void)testSingleBlock
{
    __block BOOL didExecute = NO;
    [self.queue performBlock:^{
        didExecute = YES;
    }];
    
    STAssertTrue(didExecute, @"Failed to execute single block");
}



- (void)testMultipleBlocks
{
    __block BOOL didExecute = NO;    
    [self.queue performBlock:^{
        
        [self.queue performBlock:^{
            didExecute = YES;
        }];
        
    }];
    
    STAssertTrue(didExecute, @"Failed to execute multiple blocks");
}



-(void)testProxy
{
    STAssertFalse(self.object == self.proxiedObject, @"");
    STAssertEqualObjects([self.object stringWithFormat:@""], [self.proxiedObject stringWithFormat:@""], @"");
}

@end
