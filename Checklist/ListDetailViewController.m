//
//  ListDetailViewController.m
//  
//
//  Created by Lei on 15/5/6.
//
//

#import "ListDetailViewController.h"
#import "Checklist.h"
@implementation ListDetailViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.checklistToEdit !=nil)
    {
        self.title = @"Edit Checklist"; self.textField.text = self.checklistToEdit.name; self.doneBarButton.enabled = YES;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}


-(IBAction)cancel:(id)sender
{
    [self.delegate listDetailViewControllerDidCancel:self];
}

-(IBAction)done:(id)sender
{
    if(self.checklistToEdit ==nil)
    {
        Checklist *checklist = [[Checklist alloc]init]; checklist.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishAddingChecklist:checklist];
    }
    else
    {
        self.checklistToEdit.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishEditingChecklist:self.checklistToEdit];
    }
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled =([newText length]>0);
    return YES;
}











@end
