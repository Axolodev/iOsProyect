//
//  JugarViewController.h
//  ProyectoFinal
//
//  Created by alumno on 10/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"


@interface JugarViewController : UIViewController
@property (nonatomic, strong) NSString *stDificultad;
@property (nonatomic, strong) NSString *stCategoria;
@property (nonatomic, retain) IBOutletCollection(UIButton) NSMutableArray *arregloBotones;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSString *stPalabraAAdivinar;
@property (strong, nonatomic) IBOutlet UITextField *tfPalabraAdivinada;
@property (strong, nonatomic) IBOutlet UIButton *buEliminarLetra;
@property(strong,nonatomic) ViewController *vc;

@property (nonatomic, retain) IBOutletCollection(UIButton) NSMutableArray *arregloBotonesRespuesta;


- (IBAction)bupEliminarLetra:(id)sender;
- (IBAction)bupMostrarLetra:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *buMostrarLetra;
@property NSInteger idCategoria;
@property (strong, nonatomic) NSMutableArray *diccionarioPalabras;


@end
