//
//  FinalViewController.m
//  ProyectoFinal
//
//  Created by alumno on 15/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "FinalViewController.h"

#import "ViewController.h"

@interface FinalViewController ()

@end

@implementation FinalViewController

- (IBAction)Next{
    
    ViewController *otherView = [[ViewController alloc] initWithNibName:nil bundle:nil ];
    [self presentViewController:otherView animated:YES completion:NULL];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
        self.lbGanoPerdio.text = [NSString stringWithFormat:@"Score: %li",self.score2];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)volverJugar:(id)sender {
    [self.delegado quitarVistas];
}
- (IBAction)compartirFB:(id)sender {
}

- (IBAction)compartirTwitter:(id)sender {
}
@end