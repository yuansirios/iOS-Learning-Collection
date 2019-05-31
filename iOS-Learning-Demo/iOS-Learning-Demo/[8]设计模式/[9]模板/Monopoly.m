//
//  Monopoly.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "Monopoly.h"

@interface Monopoly ()

@property (nonatomic, assign) int gamePlayerCount;

@end

@implementation Monopoly

- (void)setPlayerCount:(int)count {
    
    self.gamePlayerCount = count;
}

- (int)playerCount {
    
    return self.gamePlayerCount;
}

- (void)initializeGame {
    
    NSLog(@"Monopoly initialize");
}

- (void)makePlay {
    
    NSLog(@"Monopoly makePlay");
}

- (void)endOfGame {
    
    NSLog(@"Monopoly endOfGame");
}

@end
