//
//  AXTableViewController.m
//  AXPracticalHUD
//
//  Created by ai on 15/11/20.
//  Copyright © 2015年 AiXing. All rights reserved.
//

#import "AXTableViewController.h"
#import "AXPracticalHUD/AXPracticalHUD.h"

@interface AXTableViewController ()<AXPracticalHUDDelegate>{
    AXPracticalHUD *HUD;
    long long expectedLength;
    long long currentLength;
}
@property(strong, nonatomic) NSArray *dataSource;

@property(weak, nonatomic) IBOutlet UISwitch *style;
@end

@implementation AXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _dataSource = @[@"Simple indeterminate progress",@"With label",@"With detail label",@"Determinate mode",@"Custom view",@"Mode swithing",@"Using blocks",@"On window",@"NSURLConnection",@"Dim background",@"Text only",@"Colored"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kAXPracticalHUDCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self showSimple:tableView];
            break;
        case 1:
            [self showWithLabel:tableView];
            break;
        case 2:
            [self showWithDetailsLabel:tableView];
            break;
        case 3:
            [self showWithLabelDeterminate:tableView];
            break;
        case 4:
            [self showWIthLabelAnnularDeterminate:tableView];
            break;
        case 5:
            [self showWithLabelDeterminateHorizontalBar:tableView];
            break;
        case 6:
            [self showWithCustomView:tableView];
            break;
        case 7:
            [self showWithLabelMixed:tableView];
            break;
        case 8:
            [self showUsingBlocks:tableView];
            break;
        case 9:
            [self showOnWindow:tableView];
            break;
        case 10:
            [self showURL:tableView];
            break;
        case 11:
            [self showWithGradient:tableView];
            break;
        case 12:
            [self showTextOnly:tableView];
            break;
        default:
            [self showWithColor:tableView];
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Actions

- (IBAction)showSimple:(id)sender {
    // The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
    HUD = [[AXPracticalHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    HUD.lockBackground = YES;
    
//    HUD.mode = AXPracticalHUDModeBreachedIndeterminate;
    HUD.dimBackground = YES;
    
    // Show the HUD while the provided method executes in a new thread
//    [HUD show:YES executingMethod:@selector(myTask) toTarget:self withObject:nil];
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.0 completion:NULL];
    [[AXPracticalHUD sharedHUD] showSuccessInView:self.navigationController.view text:@"heheda" detail:nil configuration:^(AXPracticalHUD *_HUD) {
        _HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
        _HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
        _HUD.label.textColor = HUD.tintColor;
        _HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    }];
    
    [[AXPracticalHUD sharedHUD] hide:YES afterDelay:2.0 completion:NULL];
}

- (IBAction)showWithLabel:(id)sender {
    
    HUD = [[AXPracticalHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    HUD.delegate = self;
    HUD.label.text = @"Loading";
    
    HUD.lockBackground = YES;
    HUD.square = YES;
    HUD.mode = AXPracticalHUDModeBreachedAnnularIndeterminate;
    
    [HUD show:YES executingMethod:@selector(myTask) toTarget:self withObject:nil];
}

- (IBAction)showWithDetailsLabel:(id)sender {
    
    HUD = [[AXPracticalHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    HUD.delegate = self;
    HUD.label.text = @"Loading";
    HUD.detailLabel.text = @"updating data";
    HUD.lockBackground = YES;
    HUD.square = YES;
    HUD.mode = AXPracticalHUDModeBreachedAnnularIndeterminate;
    
    [HUD show:YES executingMethod:@selector(myTask) toTarget:self withObject:nil];
}

- (IBAction)showWithLabelDeterminate:(id)sender {
    
    HUD = [[AXPracticalHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    // Set determinate mode
    HUD.mode = AXPracticalHUDModeDeterminate;
    
    HUD.delegate = self;
    HUD.label.text = @"Loading";
    
    HUD.lockBackground = YES;
    HUD.square = YES;
    
    // myProgressTask uses the HUD instance to update progress
    [HUD show:YES executingMethod:@selector(myProgressTask) toTarget:self withObject:nil];
}

- (IBAction)showWIthLabelAnnularDeterminate:(id)sender {
    HUD = [[AXPracticalHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    // Set determinate mode
    HUD.mode = AXPracticalHUDModeDeterminateAnnularEnabled;
    
    HUD.delegate = self;
    HUD.label.text = @"Loading";
    
    // myProgressTask uses the HUD instance to update progress
    [HUD show:YES executingMethod:@selector(myProgressTask) toTarget:self withObject:nil];
}

- (IBAction)showWithLabelDeterminateHorizontalBar:(id)sender {
    
    HUD = [[AXPracticalHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    // Set determinate bar mode
    HUD.mode = AXPracticalHUDModeDeterminateHorizontalBar;
    HUD.tintColor = [UIColor orangeColor];
    
    HUD.delegate = self;
    
    // myProgressTask uses the HUD instance to update progress
    [HUD show:YES executingMethod:@selector(myProgressTask) toTarget:self withObject:nil];
}

- (IBAction)showWithCustomView:(id)sender {
    
    HUD = [[AXPracticalHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    // Set custom view mode
    HUD.mode = AXPracticalHUDModeCustomView;
    
    HUD.delegate = self;
    HUD.label.text = @"Completed";
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:3 completion:nil];
}

- (IBAction)showWithLabelMixed:(id)sender {
    
    HUD = [[AXPracticalHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    HUD.delegate = self;
    HUD.label.text = @"Connecting";
    HUD.minimumSize = CGSizeMake(135.f, 135.f);
    
    [HUD show:YES executingMethod:@selector(myMixedTask) toTarget:self withObject:nil];
}

- (IBAction)showUsingBlocks:(id)sender {
#if NS_BLOCKS_AVAILABLE
    AXPracticalHUD *hud = [[AXPracticalHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.label.text = @"With a block";
    [hud show:YES executingBlockOnGQ:^{
        [self myTask];
    } completion:^{
        [hud removeFromSuperview];
    }];
#endif
}

- (IBAction)showOnWindow:(id)sender {
    // The hud will dispable all input on the window
    HUD = [[AXPracticalHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:HUD];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    HUD.delegate = self;
    HUD.label.text = @"Loading";
    
    [HUD show:YES executingMethod:@selector(myTask) toTarget:self withObject:nil];
}

- (IBAction)showURL:(id)sender {
    NSURL *URL = [NSURL URLWithString:@"http://a1408.g.akamai.net/5/1408/1388/2005110403/1a1a1ad948be278cff2d96046ad90768d848b41947aa1986/sample_iPod.m4v.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
    HUD = [AXPracticalHUD showHUDInView:self.navigationController.view animated:YES];
    HUD.delegate = self;
}


- (IBAction)showWithGradient:(id)sender {
    
    HUD = [[AXPracticalHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.mode = AXPracticalHUDModeDeterminateColorfulHorizontalBar;
    HUD.progress = 1.0;
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD show:YES executingMethod:@selector(myTask) toTarget:self withObject:nil];
}

- (IBAction)showTextOnly:(id)sender {
    
    AXPracticalHUD *hud = [AXPracticalHUD showHUDInView:self.navigationController.view animated:YES];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    // Configure for text only and offset down
    hud.mode = AXPracticalHUDModeText;
    hud.label.text = @"Some message...";
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:3 completion:nil];
}

- (IBAction)showWithColor:(id)sender{
    HUD = [[AXPracticalHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.contentView.color = _style.isOn?[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]:[UIColor blackColor];
    HUD.tintColor = _style.isOn?[UIColor blackColor]:[UIColor whiteColor];
    HUD.label.textColor = HUD.tintColor;
    HUD.detailLabel.textColor = [HUD.tintColor colorWithAlphaComponent:0.8];
    
    // Set the hud to display with a color
    HUD.contentView.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
    
    HUD.delegate = self;
    [HUD show:YES executingMethod:@selector(myTask) toTarget:self withObject:nil];
}

#pragma mark - Execution code

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        HUD.progress = progress;
        usleep(50000);
    }
}

- (void)myMixedTask {
    // Indeterminate mode
    sleep(2);
    // Switch to determinate mode
    HUD.mode = AXPracticalHUDModeDeterminate;
    HUD.label.text = @"Progress";
    float progress = 0.0f;
    while (progress < 1.0f)
    {
        progress += 0.01f;
        HUD.progress = progress;
        usleep(50000);
    }
    // Back to indeterminate mode
    HUD.mode = AXPracticalHUDModeIndeterminate;
    HUD.label.text = @"Cleaning up";
    sleep(2);
    // UIImageView is a UIKit class, we have to initialize it on the main thread
    __block UIImageView *imageView;
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIImage *image = [UIImage imageNamed:@"37x-Checkmark.png"];
        imageView = [[UIImageView alloc] initWithImage:image];
    });
    HUD.customView = imageView;
    HUD.mode = AXPracticalHUDModeCustomView;
    HUD.label.text = @"Completed";
    sleep(2);
}

#pragma mark - NSURLConnectionDelegete

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    expectedLength = MAX([response expectedContentLength], 1);
    currentLength = 0;
    HUD.mode = AXPracticalHUDModeDeterminate;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    currentLength += [data length];
    HUD.progress = currentLength / (float)expectedLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = AXPracticalHUDModeCustomView;
    [HUD hide:YES afterDelay:2 completion:nil];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [HUD hide:YES];
}
@end
