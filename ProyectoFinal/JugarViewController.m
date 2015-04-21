//
//  JugarViewController.m
//  ProyectoFinal
//
//  Created by alumno on 10/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "JugarViewController.h"
#import "FinalViewController.h"

@interface JugarViewController ()
@property const NSInteger BUTTONWIDTH;
@property const NSInteger BUTTONHEIGHT;
@property const NSInteger SPACEBETWEENBUTTONS;
@property const NSInteger STARTINGY;
@property const NSInteger STARTINGX;

@end

@implementation JugarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BUTTONHEIGHT = 45;
    self.BUTTONWIDTH = 45;
    self.SPACEBETWEENBUTTONS = 10;
    self.STARTINGX = 50;
    self.STARTINGY = 500;
    self.tfPalabraAdivinada.hidden = true;
    self.stPalabraAAdivinar = @"1234";
    if ([self.stDificultad integerValue] == 3) {
        self.buEliminarLetra.hidden = YES;
        self.buMostrarLetra.hidden = YES;
    }
    [self initTiles];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTiles
{
    NSInteger numberOfButtons = [self getNumberOfButtons:self.stPalabraAAdivinar];
    self.arregloBotones = [[NSMutableArray alloc] initWithCapacity:numberOfButtons];
    self.arregloBotonesRespuesta = [[NSMutableArray alloc] initWithCapacity:numberOfButtons];
    NSInteger buttonsInUpperRow = numberOfButtons / 2, buttonsInLowerRow = numberOfButtons - buttonsInUpperRow;
    
    for (int count = 0; count < buttonsInUpperRow; count++)
    {
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(self.STARTINGX + (self.SPACEBETWEENBUTTONS + self.BUTTONWIDTH) * count, self.STARTINGY, self.BUTTONWIDTH, self.BUTTONHEIGHT)];
        [b setTitle:[NSString stringWithFormat:@"%i",count+1] forState:UIControlStateNormal];
        [b setTag:count];
        [b setHidden:NO];
        [b addTarget:self action:@selector(letraDeBancoPresionada:) forControlEvents:UIControlEventTouchUpInside];
        [b setBackgroundColor:[UIColor purpleColor]];
        [self.arregloBotones addObject:b];
        [self.view addSubview:b];
    }
    
    for (int count = 0; count < buttonsInLowerRow; count++)
    {
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(self.STARTINGX + (self.SPACEBETWEENBUTTONS + self.BUTTONWIDTH) * count, self.STARTINGY + self.BUTTONHEIGHT + self.SPACEBETWEENBUTTONS, self.BUTTONWIDTH, self.BUTTONWIDTH)];
        [b setTitle:[NSString stringWithFormat:@"%li",count+1 + buttonsInUpperRow] forState:UIControlStateNormal];
        [b setTag:count];
        [b setHidden:NO];
        [b addTarget:self action:@selector(letraDeBancoPresionada:) forControlEvents:UIControlEventTouchUpInside];
        [b setBackgroundColor:[UIColor purpleColor]];
        [self.arregloBotones addObject:b];
        [self.view addSubview:b];
    }
    
    // Dibujo de botones superiores
    NSLog(@"%ld", numberOfButtons);
    if(numberOfButtons != 0){
        for (int count = 0; count < self.stPalabraAAdivinar.length; count++)
        {
            UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(self.STARTINGX + (self.SPACEBETWEENBUTTONS + self.BUTTONWIDTH) * count, 350, self.BUTTONWIDTH, self.BUTTONHEIGHT)];
            [b setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
            [b setTag:count];
            [b setHidden:NO];
            [b addTarget:self action:@selector(letraDeRespuestaPresionada:) forControlEvents:UIControlEventTouchUpInside];
            [b setBackgroundColor:[UIColor blueColor]];
            [self.arregloBotonesRespuesta addObject:b];
            [self.view addSubview:b];
        }
    } else {
        self.tfPalabraAdivinada.hidden = false;
    }
    
}

//Rohertito esto genera Random Chars

-(char) generateRandomChar{
    int r = rand() % 26 + 'a';
    char character;
    character = (char) r;
    
    NSLog(@"%c",character);
    
    return character;
}

- (IBAction)letraDeBancoPresionada:(id)sender {    
    UIButton *button = (UIButton *) sender;
    
    if (button.isEnabled) {
        button.hidden = YES;
        NSString *buttonTitle = button.titleLabel.text;
        for(int i = 0 ; i < self.arregloBotonesRespuesta.count ; i++){
            UIButton* selectedButton = [self.arregloBotonesRespuesta objectAtIndex: i];
            if ([[selectedButton currentTitle] isEqualToString:@""]){
                [selectedButton setTitle:buttonTitle forState:UIControlStateNormal];
                [self.arregloBotonesRespuesta setObject:selectedButton atIndexedSubscript:i];
                break;
            }
        }
    }
  
    
}

- (IBAction)letraDeRespuestaPresionada:(id)sender{
    UIButton *button = (UIButton * ) sender;
    NSString *titulo = button.currentTitle;
    
    for (UIButton *bu in self.arregloBotones){
        if (bu.isHidden){
            [bu setTitle:titulo forState:UIControlStateNormal];
            bu.hidden = false;
            break;
        }
    }
    
    [button setTitle:@"" forState:UIControlStateNormal];
}



- (NSInteger) getNumberOfButtons: (NSString*) word{
    NSInteger val = [self.stDificultad integerValue];
    if(val == 1) {
        return word.length + 2;
    } else if (val ==2) {
        return word.length + 5;
    }
    return 0;
}



 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
      if([[segue identifier] isEqualToString:@"segueFinal"]){
          FinalViewController*fvc = [segue destinationViewController];
          fvc.delegado = self.vc;
          
          
      }
 }



- (IBAction)bupEliminarLetra:(id)sender {
    NSString *helper = [NSString stringWithFormat:@"%@", self.stPalabraAAdivinar];
    NSRange r;
    for (int i = 0 ; i < self.arregloBotones.count ; i++){
        UIButton *bu = [self.arregloBotones objectAtIndex:i];
        if (helper.length == 0) {
            r.location = NSNotFound;
        } else {
            r = [helper rangeOfString:bu.currentTitle];
        }
        if (r.location == NSNotFound && !(bu.isHidden)) {
            bu.hidden = true;
            i--;
            break;
        } else if(r.location != NSNotFound){
            helper = [NSString stringWithFormat:@"%@%@", [helper substringWithRange:NSMakeRange(0, r.location)], [helper substringFromIndex:(r.length + r.location)]];
        }
    }
}

- (IBAction)bupMostrarLetra:(id)sender {
    int ctr = 0;

    for (UIButton *bu in self.arregloBotonesRespuesta){
        if (bu.isEnabled && ![[self.stPalabraAAdivinar substringWithRange:NSMakeRange(ctr, 1)] isEqualToString:bu.currentTitle]){
            [bu setTitle:
             [self.stPalabraAAdivinar substringWithRange:NSMakeRange(ctr, 1)] forState:UIControlStateNormal];
            bu.enabled = false;
            break;
        }
        ctr++;
    }
    
}

@end
