//
//  addViewController.m
//  KVC
//
//  Created by Naveen Katari on 14/10/15.
//  Copyright (c) 2015 Sourcebits. All rights reserved.
//

#import "addViewController.h"

@interface addViewController ()
{
    NSMutableArray *arrayStudent;
    
}

@end

@implementation addViewController

@synthesize delegate;
@synthesize studentData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrayStudent =[[NSMutableArray alloc]init];
    
    _textFieldName.text = _arrayHoldRowId[0];
    _textFieldClass.text = _arrayHoldRowId[1];
    _textFieldAge.text = _arrayHoldRowId[2];
    
    [self addObserver:self forKeyPath:@"student.stringStdName" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"student.stringStdClass" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"student.integerAge" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSMutableArray *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"student.stringStdName"]) {
        NSLog(@"Student name is changed.\n");
        NSLog(@"%@", change);
        
    }
    if ([keyPath isEqualToString:@"student.stringStdClass"]) {
        NSLog(@"Student class has been updated.\n");
        NSLog(@"%@", change);
    }
    
    if ([keyPath isEqualToString:@"student.integerAge"]) {
        NSLog(@"Age of the student is changed.\n");
        NSLog(@"%@", change);
    }
}


- (IBAction)buttonCancel:(id)sender
{
   [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)buttonSave:(id)sender
{
    self.student = [[Student alloc]init];
    
    _stringStdName = _textFieldName.text;
    _stringStdClass = _textFieldClass.text;
    NSString *strAge = _textFieldAge.text;
    _integerAge = [strAge integerValue];
    
    [self.student setValue:[ _textFieldName valueForKey:@"text" ] forKeyPath:@"student.stringStdName"];
    [self.student setValue:[_textFieldClass valueForKey:@"text"] forKeyPath:@"student.stringStdClass"];
    [self.student setValue:[NSNumber numberWithInteger:_integerAge] forKeyPath:@"student.integerAge"];

    [arrayStudent addObject: _textFieldName.text];
    [arrayStudent addObject:_textFieldClass.text];
    [arrayStudent addObject:_textFieldAge.text];
    if(_arrayHoldRowId == nil) {
        [[self delegate] addItemViewController:arrayStudent];
    }
    else {
        [[self delegate] editItemViewController: arrayStudent];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
