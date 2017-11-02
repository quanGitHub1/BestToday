//
//  NSObject+CallMethod.m
//  Finance
//
//  Created by Gnet_lulizhi on 2017/6/16.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#import "NSObject+CallMethod.h"

@implementation NSObject (CallMethod)
-(BOOL)getCurrencyByID:(NSString *)currencyID
{
    if ([currencyID isEqualToString:@"EUR_USD"]) {
        return true;
    }
    else if ([currencyID isEqualToString:@"EUR_AUD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"EUR_CAD"])
    {
        return true;
    }else if ([currencyID isEqualToString:@"EUR_CHF"])
    {
        return true;
    }else if ([currencyID isEqualToString:@"EUR_CNH"])
    {
        return true;
    }else if ([currencyID isEqualToString:@"EUR_CNY"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"EUR_GBP"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"EUR_HKD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"EUR_JPY"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"EUR_SGD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"EUR_NZD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"GBP_USD"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"GBP_AUD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"GBP_CAD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"GBP_CHF"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"GBP_CNH"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"GBP_CNY"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"GBP_JPY"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"GBP_SGD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"GBP_NZD"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"GBP_HKD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"USD_CAD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"CAD_AUD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"CAD_AUD"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"CAD_CHF"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"CAD_CNH"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"CAD_HKD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"CAD_JPY"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"CAD_SGD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"CAD_NZD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"AUD_USD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"AUD_CHF"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"AUD_CNH"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"AUD_CNY"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"AUD_HKD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"AUD_JPY"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"AUD_SGD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"AUD_NZD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"USD_CHF"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"CHF_JPY"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"CHF_CNY"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"CHF_CNH"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"CHF_HKD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"CHF_NZD"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"USD_SGD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"SGD_CHF"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"SGD_CNH"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"SGD_CNY"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"SGD_JPY"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"SGD_HKD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"SGD_NZD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"USD_JPY"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"JPY_CNY"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"JPY_HKD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"JPY_NZD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"NZD_USD"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"NZD_HKD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"NZD_CNY"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"USD_CNH"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"CNH_JPY"])
    {
        return true;
    }
    
    else if ([currencyID isEqualToString:@"CNH_HKD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"USD_CNY"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"USD_HKD"])
    {
        return true;
    }
    else if ([currencyID isEqualToString:@"HKD_CNY"])
    {
        return true;
    }
    else
        
        return false;
}

-(BOOL)themarket:(NSString *)currentID
{
    if ([currentID isEqualToString:@"SH_000001"]) {
        return true;
    }
    else if ([currentID isEqualToString:@"SH_000300"])
    {
        return true;
    }
    else if ([currentID isEqualToString:@"SZ_399001"])
    {
        return true;
    }else if ([currentID isEqualToString:@"HSI"])
    {
        return true;
    }
    else if ([currentID isEqualToString:@"HSCEI"])
    {
        return true;
    }
    else if ([currentID isEqualToString:@"HSCCI"])
    {
        return true;
    }
    else if ([currentID isEqualToString:@"NASDAQ"])
    {
        return true;
    }else if ([currentID isEqualToString:@"SP500"])
    {
        return true;
    }
    else if ([currentID isEqualToString:@"DJIA"])
    {
        return true;
    }
    else
    {
        return false;
    }
    
}
-(NSString *)getCurrency:(NSString *)currencyName{
    
    if ([currencyName isEqualToString:@"EUR/USD"]) {
        return @"欧元/美元";
    }
    else if ([currencyName isEqualToString:@"EUR/AUD"])
    {
        return @"欧元/澳元";
    }
    else if ([currencyName isEqualToString:@"EUR/CAD"])
    {
        return @"欧元/加元";
    }
    else if ([currencyName isEqualToString:@"EUR/CHF"])
    {
        return @"欧元/法郎";
    }
    else if ([currencyName isEqualToString:@"EUR/CNH"])
    {
        return @"欧元/离岸人民币";
    }
    else if ([currencyName isEqualToString:@"EUR/CNY"])
    {
        return @"欧元/人民币";
    }
    else if ([currencyName isEqualToString:@"EUR/GBP"])
    {
        return @"欧元/英镑";
    }
    else if ([currencyName isEqualToString:@"EUR/HKD"])
    {
        return @"欧元/港币";
    }
    else if ([currencyName isEqualToString:@"EUR/JPY"])
    {
        return @"欧元/日元";
    }
    else if ([currencyName isEqualToString:@"EUR/SGD"])
    {
        return @"欧元/新加坡元";
    }else if ([currencyName isEqualToString:@"EUR/NZD"])
    {
        return @"欧元/新西兰元";
    }
    else if ([currencyName isEqualToString:@"GBP/USD"])
    {
        return @"英镑/美元";
    }
    else if ([currencyName isEqualToString:@"GBP/AUD"])
    {
        return @"英镑/澳元";
    }
    else if ([currencyName isEqualToString:@"GBP/CAD"])
    {
        return @"英镑/加元";
    }
    else if ([currencyName isEqualToString:@"GBP/CHF"])
    {
        return @"英镑/法郎";
    }
    else if ([currencyName isEqualToString:@"GBP/CNH"])
    {
        return @"英镑/离岸人民币";
    }
    else if ([currencyName isEqualToString:@"GBP/CNY"])
    {
        return @"英镑/人民币";
    }
    else if ([currencyName isEqualToString:@"GBP/JPY"])
    {
        return @"英镑/日元";
    }
    else if ([currencyName isEqualToString:@"GBP/SGD"])
    {
        return @"英镑/新加坡元";
    }
    else if ([currencyName isEqualToString:@"GBP/NZD"])
    {
        return @"英镑/新西兰元";
    }
    else if ([currencyName isEqualToString:@"GBP/HKD"])
    {
        return @"英镑/港币";
    }
    else if ([currencyName isEqualToString:@"USD/CAD"])
    {
        return @"美元/加元";
    }
    else if ([currencyName isEqualToString:@"CAD/AUD"])
    {
        return @"加元/澳元";
    }
    else if ([currencyName isEqualToString:@"CAD/CHF"])
    {
        return @"加元/法郎";
    }
    else if ([currencyName isEqualToString:@"CAD/CNH"])
    {
        return @"加元/离岸人民币";
    }
    
    else if ([currencyName isEqualToString:@"CAD/CNY"])
    {
        return @"加元/人民币";
    }
    else if ([currencyName isEqualToString:@"CAD/HKD"])
    {
        return @"加元/港币";
    }
    else if ([currencyName isEqualToString:@"CAD/JPY"])
    {
        return @"加元/日元";
    }else if ([currencyName isEqualToString:@"CAD/SGD"])
    {
        return @"加元/新加坡元";
    }
    else if ([currencyName isEqualToString:@"CAD/NZD"])
    {
        return @"加元/新西兰元";
    }
    else if ([currencyName isEqualToString:@"AUD/USD"])
    {
        return @"澳元/美元";
    }
    
    
    else if ([currencyName isEqualToString:@"AUD/CHF"])
    {
        return @"澳元/法郎";
    }
    else if ([currencyName isEqualToString:@"AUD/CNH"])
    {
        return @"澳元/离岸人民币";
    }
    else if ([currencyName isEqualToString:@"AUD/CNY"])
    {
        return @"澳元/人民币";
    }else if ([currencyName isEqualToString:@"AUD/HKD"])
    {
        return @"澳元/港币";
    }
    else if ([currencyName isEqualToString:@"AUD/JPY"])
    {
        return @"澳元/日元";
    }
    else if ([currencyName isEqualToString:@"AUD/SGD"])
    {
        return @"澳元/新加坡元";
    }
    
    
    else if ([currencyName isEqualToString:@"AUD/NZD"])
    {
        return @"澳元/新西兰元";
    }
    else if ([currencyName isEqualToString:@"USD/CHF"])
    {
        return @"美元/法郎";
    }
    else if ([currencyName isEqualToString:@"CHF/JPY"])
    {
        return @"法郎/日元";
    }else if ([currencyName isEqualToString:@"CHF/CNY"])
    {
        return @"法郎/人民币";
    }
    else if ([currencyName isEqualToString:@"CHF/CNH"])
    {
        return @"法郎/离岸人民币";
    }
    else if ([currencyName isEqualToString:@"CHF/HKD"])
    {
        return @"法郎/港币";
    }
    
    else if ([currencyName isEqualToString:@"CHF/NZD"])
    {
        return @"法郎/新西兰元";
    }
    else if ([currencyName isEqualToString:@"USD/SGD"])
    {
        return @"美元/新加坡元";
    }
    else if ([currencyName isEqualToString:@"SGD/CHF"])
    {
        return @"新加坡元/法郎";
    }else if ([currencyName isEqualToString:@"SGD/CNH"])
    {
        return @"新加坡元/离岸人民币";
    }
    else if ([currencyName isEqualToString:@"SGD/CNY"])
    {
        return @"新加坡元/人民币";
    }
    else if ([currencyName isEqualToString:@"SGD/JPY"])
    {
        return @"新加坡元/日元";
    }
    
    
    else if ([currencyName isEqualToString:@"SGD/HKD"])
    {
        return @"新加坡元/港币";
    }
    else if ([currencyName isEqualToString:@"SGD/NZD"])
    {
        return @"新加坡元/新西兰元";
    }
    else if ([currencyName isEqualToString:@"USD/JPY"])
    {
        return @"美元/日元";
    }else if ([currencyName isEqualToString:@"JPY/CNY"])
    {
        return @"日元/人民币";
    }
    else if ([currencyName isEqualToString:@"JPY/HKD"])
    {
        return @"日元/港币";
    }
    else if ([currencyName isEqualToString:@"JPY/NZD"])
    {
        return @"日元/新西兰元";
    }
    
    else if ([currencyName isEqualToString:@"NZD/USD"])
    {
        return @"新西兰元/美元";
    }
    else if ([currencyName isEqualToString:@"NZD/HKD"])
    {
        return @"新西兰元/港币";
    }
    else if ([currencyName isEqualToString:@"NZD/CNY"])
    {
        return @"新西兰元/人民币";
    }else if ([currencyName isEqualToString:@"USD/CNH"])
    {
        return @"美元/离岸人民币";
    }
    else if ([currencyName isEqualToString:@"CNH/JPY"])
    {
        return @"离岸人民币/日元";
    }
    else if ([currencyName isEqualToString:@"CNH/HKD"])
    {
        return @"离岸人民币/港币";
    }
    
    else if ([currencyName isEqualToString:@"USD/CNY"])
    {
        return @"美元/人民币";
    }else if ([currencyName isEqualToString:@"USD/HKD"])
    {
        return @"美元/港币";
    }
    else if ([currencyName isEqualToString:@"HKD/CNY"])
    {
        return @"港币/人民币";
    }
    
    
    return nil;
}


@end
