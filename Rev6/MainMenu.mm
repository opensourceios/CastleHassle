//
//  MainMenu.m
//  Rev5
//
//  Created by Bryce Redd on 3/13/10.
//  Copyright 2010 Reel Connect LLC. All rights reserved.
//

#import "MainMenu.h"
#import "MainScene.h"
#import "SinglePlayer.h"
#import "Settings.h"
#import "HowToPlay.h"
#import "MapScreen.h"
#import "Credits.h"
#import "BackButtonLayer.h"

@implementation MainMenu

@synthesize bg;

static MainMenu * instance = nil;

+(MainMenu *) instance {
	if(instance == nil) {
		instance = [[MainMenu alloc] init];
	}
	
	return instance;
}

+(void) resetInstance {
    [instance release];
	instance = nil;
}

-(id) init {
	
    if ((self = [super init])) {
        [self addChild:[MainMenuLayer node] z:1 tag:MAIN_MENU_LAYER];

		
		//Add intro sound here...
		SimpleAudioEngine *introSound = [SimpleAudioEngine sharedEngine];
		if (introSound != nil) {
			[introSound preloadBackgroundMusic:@"background-music.caf"];
			if (introSound.willPlayBackgroundMusic) {
				introSound.backgroundMusicVolume = 1.0f;
			}
		}
		
		[introSound playBackgroundMusic:@"background-music.caf"];
		//sound section ends here
		
    }
		
    return self;
}

@end

@implementation MainMenuLayer

-(id) init {
	
	if( (self=[super init])) {
		
		bg = sprite(@"background.jpg");
        [bg setPosition:ccp(240, 160)];
        [self addChild:bg z:0];
		
		CCSprite* logo = sprite(@"logo.png");

        [logo setPosition:ccp(240, 245)];
		[self addChild:logo z:0];
		
		CCSprite* navBack = sprite(@"splashNavBack.png");
        [navBack setPosition:ccp(160, 62)];
		[self addChild:navBack z:0];
		
		CCSprite* navBack2 = sprite(@"smallBack.png");
        [navBack2 setPosition:ccp(385, 62)];
		[self addChild:navBack2 z:0];
		
		[CCMenuItemFont setFontSize:16];
		[CCMenuItemFont setFontName:@"arial"];
		
		// add the four buttons
		[self makeButtonWithString:@"Single Player" 
						atPosition:ccp(-150,-75) 
					  withSelector:@selector(singlePlayer:)];
		
		
		[self makeButtonWithString:@"Settings"
						atPosition:ccp(-10,-121) 
					  withSelector:@selector(settings:)];
		
		[self makeButtonWithString:@"Campaign"
						atPosition:ccp(-150,-121)
					  withSelector:@selector(campaign:)];
		
		[self makeButtonWithString:@"How-to-play"
						atPosition:ccp(145,-75) 
					withSelector:@selector(howToPlay:)];
		
		[self makeButtonWithString:@"Credits"
						atPosition:ccp(145,-121) 
					  withSelector:@selector(credits:)];
	}
	return self;
}


-(void)campaign: (id)sender {
	MainMenu* main = [MainMenu instance];
	[main removeChild:self cleanup:YES];
	CCSprite* blackBg = [CCSprite spriteWithFile:@"blackWall.png"];
	[blackBg setPosition:ccp(240, 160)];
	[main addChild:blackBg z:1];
	[main addChild:[MapScreen node] z:2];
	[main addChild:[BackButtonLayer node] z:3];
}

-(void)singlePlayer: (id)sender {
	MainMenu* main = [MainMenu instance];
	[main removeChild:self cleanup:YES];
	[main addChild:[SinglePlayer node]];
}

-(void)settings: (id)sender {
	NSLog(@"settings");
	MainMenu* main = [MainMenu instance];
	[main removeChild:self cleanup:YES];
	[main addChild:[Settings node]];	
}

-(void)howToPlay: (id)sender {
	NSLog(@"how to play");
	MainMenu* main = [MainMenu instance];
	[main removeChild:self cleanup:YES];
	[main addChild:[HowToPlay node]];
}

-(void)credits: (id)sender {
	MainMenu* main = [MainMenu instance];
	[main removeChild:self cleanup:YES];
	[main addChild:[Credits node]];
}


@end