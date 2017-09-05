//
//  TopUpViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/13.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "TopUpViewController.h"

@interface TopUpTitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation TopUpTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end

@interface TopUpTableViewCell : UITableViewCell {

    __weak IBOutlet UIImageView *_payIcon;

    __weak IBOutlet UILabel *_payTitle;
    
    __weak IBOutlet UIImageView *_selectImage;
    
}
@property (nonatomic,assign) NSInteger type; //1：支付宝  2：微信
@property (nonatomic,assign) BOOL isSelect;
@end

@implementation TopUpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setType:(NSInteger)type {
    _type = type;
    if (_type == 1) {
        _payIcon.image = [UIImage imageNamed:@"aliPay"];
        _payTitle.text = @"支付宝";
    } else if (_type == 2) {
        _payIcon.image = [UIImage imageNamed:@"weChatPay"];
        _payTitle.text = @"微信";
    }
}
- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if (_isSelect) {
        _selectImage.image = [UIImage imageNamed:@"choice"];
    } else {
        _selectImage.image = [UIImage imageNamed:@"unChoice"];
    }
}


@end


@interface TopUpViewController ()<UITableViewDataSource,UITableViewDelegate>{

    
    __weak IBOutlet UIView *_headerView;
    
    __weak IBOutlet UILabel *_accountLabel;
    
    __weak IBOutlet UIButton *_price1Btn;
    __weak IBOutlet UIButton *_price2Btn;
    
    __weak IBOutlet UIButton *_price3Btn;

    __weak IBOutlet UIButton *_price4Btn;
    __weak IBOutlet UIButton *_price5Btn;
    
    __weak IBOutlet UIButton *_price6Btn;
    
    __weak IBOutlet UIButton *_topUpBtn;
    
    
    NSInteger _currentPrice;
    NSInteger _selecteType;//选择的充值类型 1：支付宝  2：微信
    
    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet NSLayoutConstraint *_topUpBtnBottom;//审核的时候后button 上移 kScreenHeight - 276
    
}

@end

@implementation TopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购买钻石";
    NSArray *pointArr = @[@"100钻",@"300钻",@"500钻",@"1200钻",@"2000钻",@"2800钻"];
    NSArray *priceArr = @[@"￥10.00",@"￥30.00",@"￥50.00",@"120.00￥",@"￥200.00",@"￥280.00"];
    
    for (int i = 0; i < 6;  i++) {
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:i+1001];
        btn.titleLabel.numberOfLines = 2;
        btn.layer.cornerRadius = 25.0;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = [Common colorWithHexString:@"#909090" alpha:1.0].CGColor;
        
        NSMutableAttributedString *mulStr = [[NSMutableAttributedString alloc] init];
        NSAttributedString *pointAttr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",pointArr[i]]  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[Common colorWithHexString:@"#323232" alpha:1.0]}];
         NSAttributedString *priceAttr = [[NSAttributedString alloc] initWithString:priceArr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[Common colorWithHexString:@"#909090" alpha:1.0]}];
        [mulStr appendAttributedString:pointAttr];
        [mulStr appendAttributedString:priceAttr];
        [btn setAttributedTitle:mulStr forState:UIControlStateNormal];
        
        NSMutableAttributedString *mulStrSel = [[NSMutableAttributedString alloc] init];
        NSAttributedString *pointAttrSel = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",pointArr[i]]  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        NSAttributedString *priceAttrSel = [[NSAttributedString alloc] initWithString:priceArr[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [mulStrSel appendAttributedString:pointAttrSel];
        [mulStrSel appendAttributedString:priceAttrSel];
        [btn setAttributedTitle:mulStrSel forState:UIControlStateSelected];
        
    }
    
    _price1Btn.layer.borderColor = CommonColor.CGColor;
    _price1Btn.backgroundColor = CommonColor;
    _price1Btn.selected = YES;
    
    
    _topUpBtn.layer.cornerRadius = 21.0;
    _topUpBtn.layer.masksToBounds = YES;
    
    _selecteType = 1;//默认为支付宝

    _tableView.tableFooterView = [[UIView alloc] init];
    
    [self initRightBarButton];
}

- (void)initRightBarButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 44);
    [btn setTitle:@"充值记录" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    
}

- (void)rightBarButtonAction:(UIBarButtonItem *)item {
//跳转充值记录


}




- (IBAction)selectPriceAction:(UIButton *)sender {
    for (int i = 0; i < 6;  i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i + 1001];
        if (btn.selected) {
            btn.layer.borderColor = [Common colorWithHexString:@"#909090" alpha:1.0].CGColor;
            btn.backgroundColor = [UIColor whiteColor];
            btn.selected = NO;
        }
    }
    sender.layer.borderColor = CommonColor.CGColor;
    sender.backgroundColor = CommonColor;
    sender.selected = YES;
    
    _currentPrice = sender.tag - 1001;
}









- (IBAction)topUpAction:(UIButton *)sender {
//    _currentPrice    当前选中的价格
    
    
}




#pragma mark - TopUpTableViewCellDeleagte

- (void)userSelectTopUpType:(NSInteger)type {
    if (type != _selecteType) {
        _selecteType = type;
        [_tableView reloadData];
    }
}



#pragma mark - UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 0;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 || indexPath.row == 2) {
        return 52;
    } else {
        return 40;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 || indexPath.row == 2) {
        TopUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopUpTableViewCell"];
        cell.type = indexPath.row;
        cell.isSelect = indexPath.row == _selecteType ? YES : NO;
        return cell;
    } else {
        TopUpTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopUpTitleTableViewCell"];
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"支付方式";
            cell.titleLabel.font = [UIFont systemFontOfSize:14];
        } else if (indexPath.row == 3) {
            cell.titleLabel.text = @"充值遇到问题请联系客服wwww131688";
            cell.titleLabel.font = [UIFont systemFontOfSize:13];
        }
        return cell;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 || indexPath.row == 2) {
        _selecteType = indexPath.row;
        [_tableView reloadData];
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 40;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//    view.backgroundColor = [UIColor whiteColor];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, kScreenWidth - 24, 20)];
//    titleLabel.text = @"支付方式";
//    titleLabel.textColor = [Common colorWithHexString:@"#909090" alpha:1.0];
//    titleLabel.font = [UIFont systemFontOfSize:14.0];
//    [view addSubview:titleLabel];
//    return view;
//
//}





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




