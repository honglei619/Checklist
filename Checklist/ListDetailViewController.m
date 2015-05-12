//
//  ListDetailViewController.m
//  
//
//  Created by Lei on 15/5/6.
//
//

#import "ListDetailViewController.h"
#import "Checklist.h"
@implementation ListDetailViewController{
    NSString *_IconName;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self =[super initWithCoder:aDecoder])) {
        _IconName = @"Folder";
    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.checklistToEdit !=nil)
    {
        self.title = @"Edit Checklist"; self.textField.text = self.checklistToEdit.name; self.doneBarButton.enabled = YES;
        _IconName = self.checklistToEdit.iconName;
    }
    self.iconImageView.image = [UIImage imageNamed:_IconName];
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
        checklist.iconName = _IconName;
    }
    else
    {
        self.checklistToEdit.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishEditingChecklist:self.checklistToEdit];
        self.checklistToEdit.iconName = _IconName;
    }
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1) {
        return indexPath;
    }else{
        return nil;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled =([newText length]>0);
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"PickIcon"]){
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName{
    _IconName = iconName;
    self.iconImageView.image = [UIImage imageNamed:_IconName];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
