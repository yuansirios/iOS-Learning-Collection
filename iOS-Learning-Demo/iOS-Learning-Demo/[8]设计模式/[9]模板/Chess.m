//
//  Chess.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "Chess.h"

@interface Chess ()

@property (nonatomic, assign) int gamePlayerCount;

@end

@implementation Chess

- (void)setPlayerCount:(int)count {
    
    self.gamePlayerCount = count;
}

- (int)playerCount {
    
    return self.gamePlayerCount;
}

- (void)initializeGame {
    
    NSLog(@"Chess initialize");
}

- (void)makePlay {
    
    NSLog(@"Chess makePlay");
}

- (void)endOfGame {
    
    NSLog(@"Chess endOfGame");
}

@end
