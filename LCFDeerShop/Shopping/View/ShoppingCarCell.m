//
//  ShoppingCarCell.m
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/10.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ShoppingCarCell.h"

@implementation ShoppingCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    self.checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, (110-20)/2.0, 20, 20)];
    
    self.checkImg.image =IMAGENAMED(@"check_p");
    self.checkImg.userInteractionEnabled = YES;
    [self addSubview:self.checkImg];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
    [self.checkImg addGestureRecognizer:tapRecognizer];
    
    self.shopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.checkImg.right+10,15, 60, 70)];
    
    self.shopImageView.image = IMAGENAMED(@"detais_image.png");
    [self addSubview:self.shopImageView];
    
    self.priceLab = [[UILabel alloc]initWithFrame:CGRectMake(LCF_SCREEN_WIDTH-90, (110-20)/2.0-20, 80, 20)];
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.text = @"￥123.00";
    self.priceLab.textAlignment = NSTextAlignmentRight;
    self.priceLab.font = XNFont(16);
    [self addSubview:self.priceLab];
    
    /* LineLabel 自己封装带画线的lable */
    self.oldPriceLab = [[LineLabel alloc]initWithFrame:CGRectMake(LCF_SCREEN_WIDTH-70,self.priceLab.bottom+5, 58, 14)];
    self.oldPriceLab.textColor = [UIColor grayColor];
    self.oldPriceLab.text = @"￥200.00";
    self.oldPriceLab.backgroundColor = [UIColor clearColor];
    self.oldPriceLab.textAlignment = NSTextAlignmentRight;
    self.oldPriceLab.font = XNFont(13);
    [self addSubview:self.oldPriceLab];
    
    
    self.shopNameLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right+10,self.shopImageView.top-5,LCF_SCREEN_WIDTH-self.shopImageView.right-20-self.priceLab.width, 40)];
    self.shopNameLab.text = @"合生元金装3段1-3岁";
    self.shopNameLab.numberOfLines = 0;
    self.shopNameLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.shopNameLab.adjustsFontSizeToFitWidth = YES;
    self.shopNameLab.font = XNFont(13);
    [self addSubview:self.shopNameLab];
    
    self.shopTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopNameLab.left,self.shopNameLab.bottom,self.shopNameLab.width, 20)];
    self.shopTypeLab.text = @"通用型号";
    self.shopTypeLab.textColor = [UIColor redColor];
    self.shopTypeLab.font = XNFont(12);
    [self addSubview:self.shopTypeLab];
    
    UILabel *numberTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopTypeLab.left,self.shopImageView.bottom-5,35, 16)];
    numberTitleLab.text = @"数量:";
    numberTitleLab.textColor = [UIColor darkGrayColor];
    numberTitleLab.font = XNFont(12);
    [self addSubview:numberTitleLab];
    
    /* 加减背景view*/
    self.addNumberView = [[AddNumberView alloc]initWithFrame:CGRectMake(numberTitleLab.right+5, numberTitleLab.top-2, 93, 22)];
    self.addNumberView.delegate = self;
    self.addNumberView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.addNumberView];
    
}


/**
 * 点击减按钮数量的减少
 *
 * @param sender 减按钮
 */
- (void)deleteBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view{
    
    NSLog(@"减按钮");
    //判断是否选中，选中才能操作
    if (self.selectState == YES)
    {
        
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选中你想要的商品。" delegate:self cancelButtonTitle:@"好吧" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}

/**
 * 点击加按钮数量的增加
 *
 * @param sender 加按钮
 */
- (void)addBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view{
    
    NSLog(@"加按钮");
    //判断是否选中，选中才能操作
    if (self.selectState == YES)
    {
        
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选中你想要的商品" delegate:self cancelButtonTitle:@"好吧" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}

-(void)setShoppingModel:(ShoppingModel *)shoppingModel{
    
    _shoppingModel = shoppingModel;
    self.shopNameLab.text = shoppingModel.goodsTitle;
    
    /* 判断是否选中 */
    if (shoppingModel.selectState)
    {
        self.checkImg.image = [UIImage imageNamed:@"check_p"];
        self.selectState = YES;
        
    }else{
        self.selectState = NO;
        self.checkImg.image = [UIImage imageNamed:@"check_n"];
    }
    self.shopTypeLab.text  = shoppingModel.goodsType;
    
    self.priceLab.text = shoppingModel.goodsPrice;
    self.oldPriceLab.text = shoppingModel.oldPrice;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shoppingModel.imageName]];
    //IMAGENAMED(shoppingModel.imageName);
    // self.numberLab.text = [NSString stringWithFormat:@"%d",shoppingModel.goodsNum];
    self.addNumberView.numberString = [NSString stringWithFormat:@"%d",shoppingModel.goodsNum];
    
}

- (void)tapImageAction:(UITapGestureRecognizer *)recognize{
    _shoppingModel.selectState = !_shoppingModel.selectState;
    self.checkImg.image = [UIImage imageNamed:_shoppingModel.selectState?@"check_n":@"check_p"];
    if (_selectHandle) {
        _selectHandle();
    }
}



@end
