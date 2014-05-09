//
//  ViewController.m
//  BlogBot
//
//  Created by Tyler Kuster on 5/8/14.
//  Copyright (c) 2014 TylerKuster. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *queueCount;
@property (weak, nonatomic) IBOutlet UILabel *parseCount;
@property (nonatomic, assign) int skip;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _skip = 0;
//    [self logInToTumblrAndCheckQueue];
//    [self checkParseCount];
    [self pullFromParseAndPostToQueueWithSkip:_skip];
}

- (void)logInToTumblrAndCheckQueue
{
    
}

- (void)checkParseCount
{
    
}

- (void)pullFromParseAndPostToQueueWithSkip:(int)skipInt
{
    PFQuery *query = [PFQuery queryWithClassName:@"FGifs"];
    [query setLimit:1000];
    [query setSkip:skipInt];
    [query findObjectsInBackgroundWithTarget:self selector:@selector(findCallback:error:)];
}

- (void)findCallback:(NSArray *)objects error:(NSError *)error {
    if (!error) {
        // The find succeeded.
        NSLog(@"Successfully retrieved %d scores.", objects.count);
        if (_skip != 22000)
        {
            _skip = _skip+1000;
            [self pullFromParseAndPostToQueueWithSkip:_skip];
        }
        // Do something with the found objects
//        for (PFObject *object in objects) {
////            NSLog(@"%@", object.objectId);
//        }
    } else {
        // Log details of the failure
        NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
