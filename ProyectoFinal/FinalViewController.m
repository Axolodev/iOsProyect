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

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.resultadoJugada){
        self.lbGanoPerdio.text = @"Ganaste!!";
    }
    else{
        self.lbGanoPerdio.text = @"Perdiste!!";
    }
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



@end