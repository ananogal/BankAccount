#import "ViewController.h"
#import "AccountCell.h"
#import "FooterCell.h"

@interface ViewController ()

@property (nonatomic, copy, readwrite) NSArray* transactions;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation ViewController

@synthesize txtAmount;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transactions = [NSArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)withdraw
{
    NSInteger amount = [self.txtAmount.text integerValue];
    [self.account withdraw:amount];
    [self.tblTransactions reloadData];
}

- (IBAction)deposit
{
    NSInteger amount = [self.txtAmount.text integerValue];
    [self.account deposit:amount];
    [self.tblTransactions reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self updateTransactions];
    return [self.transactions count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =nil;
    
    if(indexPath.row == [self.transactions count])
    {
        FooterCell* footer = (FooterCell* )[self tableView:tableView dequeueCellForIdentifier:@"FooterCell"];
        
        [footer drawCell:[self.account currentBalance]];
        cell = footer;
    }
    else
    {
        cell = [self tableView:tableView dequeueCellForIdentifier:@"AccountCell"];
        if([cell isKindOfClass:[AccountCell class]])
        {
            AccountCell* accountCell = (AccountCell*)cell;
            if([self.transactions count] > 0)
            {
                [accountCell drawCell:[self.transactions objectAtIndex:[indexPath row]]];
            }
            cell = accountCell;
        }
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueCellForIdentifier:(NSString*)identifier
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

- (void)updateTransactions
{
    self.transactions = [self.account transactions];
}

@end
