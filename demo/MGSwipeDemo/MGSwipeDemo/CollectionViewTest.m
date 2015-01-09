//
//  CollectionViewTest.m
//  MGSwipeDemo
//
//  Created by Chee Han Lim on 9/1/15.
//  Copyright (c) 2015 Imanol Fernandez Gorostizaga. All rights reserved.
//

#import "CollectionViewTest.h"
#import "MGSwipeButton.h"
#import "MGSwipeTableCell.h"

@interface CollectionViewTest () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CollectionViewTest
-(void)viewDidLoad
{
    self.navigationItem.title = @"Test collection view";
    
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    self.tableView.allowsSelection = YES;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"BuzzFeedCell";
    
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        MGSwipeButton *button = [MGSwipeButton buttonWithTitle:@"Button 1" backgroundColor:[UIColor greenColor] callback:^BOOL(MGSwipeTableCell *sender) {
            NSLog(@"button 1 pressed");
            return YES;
        }];
        
        MGSwipeButton *button2 = [MGSwipeButton buttonWithTitle:@"Button 2" backgroundColor:[UIColor blueColor] callback:^BOOL(MGSwipeTableCell *sender) {
            NSLog(@"button 2 pressed");
            return YES;
        }];
        
        cell.rightButtons = @[button, button2];
    }

    UICollectionView *collectionView = (UICollectionView*)[cell viewWithTag:8888];
    if (!collectionView)
    {
        CGSize size = CGSizeMake(40, 40);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = size;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];

        collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, 320, 40) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.tag = 8888;
        collectionView.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:collectionView];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"imageCell"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arc4random()%20 + 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
    UIImageView *imgView = (UIImageView*)[cell viewWithTag:76678];
    if (!imgView)
    {
        imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = 76678;
        imgView.frame = cell.frame;
        [cell.contentView addSubview:imgView];
    }

    imgView.image = nil;
    
    UIImage *img;
    
    switch (arc4random()%3)
    {
        case 0:
            img = [[UIImage imageNamed:@"check.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
            
        case 1:
            img = [[UIImage imageNamed:@"fav.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
            
        case 2:
            img = [[UIImage imageNamed:@"menu.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
            
        default:
            break;
    }
    
    imgView.image = img;
    imgView.tintColor = [UIColor redColor];
    
    return cell;
}
@end
