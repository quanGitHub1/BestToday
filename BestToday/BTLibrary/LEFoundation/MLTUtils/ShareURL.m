//
//  ShareURL.m
//  Finance
//
//  Created by 周洪静 on 2017/5/21.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#import "ShareURL.h"

@implementation ShareURL
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"links" : [ShareURLModel class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    for (ShareURLModel *model in self.links) {
        NSString *tempURL = [NSString stringWithFormat:@"%@?order=%ld&setUrl=%d&setName=%d&setOrder=%d&id=",model.url,model.order,model.setUrl,model.setName,model.setOrder];
        if ([model.name isEqualToString:@"StockMarketH5"]) {
            self.StockMarketH5 = [NSString stringWithFormat:@"%@?id=",model.url];
        }
        if ([model.name isEqualToString:@"ImageNewH5"]) {
            self.ImageNewH5 = [NSString stringWithFormat:@"%@?id=",model.url];
        }
        if ([model.name isEqualToString:@"TextNewH5"]) {
            self.TextNewH5 = [NSString stringWithFormat:@"%@?Gid=",model.url];
        }
        if ([model.name isEqualToString:@"VDNewH5"]) {
            self.VDNewH5 = [NSString stringWithFormat:@"%@?Nid=",model.url];
        }
        if ([model.name isEqualToString:@"ShareDetailH5"]) {
            self.ShareDetailH5 =  [NSString stringWithFormat:@"%@?id=",model.url];
        }
        if ([model.name isEqualToString:@"SpecialNewsH5"]) {
            self.SpecialNewsH5 = [NSString stringWithFormat:@"%@?id=",model.url];
        }
        if ([model.name isEqualToString:@"RealTimeNewH5"]) {
            self.RealTimeNewH5 = model.url;
        }
        if ([model.name isEqualToString:@"ExchangeDetailH5"]) {
            self.ExchangeDetailH5 = [NSString stringWithFormat:@"%@?id=",model.url];
        }
        if ([model.name isEqualToString:@"FocusNewsH5"]) {
            NSString *tempURL = [NSString stringWithFormat:@"%@",model.url];
            self.FocusNewsH5 = tempURL;
        }
        if ([model.name isEqualToString:@"DirectSeedingH5"]) {
            self.DirectSeedingH5 = tempURL;
        }
        if ([model.name isEqualToString:@"WealthPassH5"]) {
            self.WealthPassH5 = tempURL;
        }
        
        
    }
    
    return YES;
}


+ (instancetype)getShareURL {
    
    return [ShareURL keyedUnarchiver:kShareURLKey path:kShareURLPath];
    
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.StockMarketH5 forKey:@"StockMarketH5"];
    [aCoder encodeObject:self.ImageNewH5 forKey:@"ImageNewH5"];
    [aCoder encodeObject:self.TextNewH5 forKey:@"TextNewH5"];
    [aCoder encodeObject:self.VDNewH5 forKey:@"VDNewH5"];
    [aCoder encodeObject:self.ShareDetailH5 forKey:@"ShareDetailH5"];
    [aCoder encodeObject:self.SpecialNewsH5 forKey:@"SpecialNewsH5"];
    [aCoder encodeObject:self.RealTimeNewH5 forKey:@"RealTimeNewH5"];
    [aCoder encodeObject:self.ExchangeDetailH5 forKey:@"ExchangeDetailH5"];
    [aCoder encodeObject:self.FocusNewsH5 forKey:@"FocusNewsH5"];
    [aCoder encodeObject:self.DirectSeedingH5 forKey:@"DirectSeedingH5"];
    [aCoder encodeObject:self.WealthPassH5 forKey:@"WealthPassH5"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.StockMarketH5 = [aDecoder decodeObjectForKey:@"StockMarketH5"];
        self.ImageNewH5 = [aDecoder decodeObjectForKey:@"ImageNewH5"];
        self.TextNewH5 = [aDecoder decodeObjectForKey:@"TextNewH5"];
        self.VDNewH5 = [aDecoder decodeObjectForKey:@"VDNewH5"];
        self.ShareDetailH5 = [aDecoder decodeObjectForKey:@"ShareDetailH5"];
        self.SpecialNewsH5 = [aDecoder decodeObjectForKey:@"SpecialNewsH5"];
        self.RealTimeNewH5 = [aDecoder decodeObjectForKey:@"RealTimeNewH5"];
        self.ExchangeDetailH5 = [aDecoder decodeObjectForKey:@"ExchangeDetailH5"];
        self.FocusNewsH5 = [aDecoder decodeObjectForKey:@"FocusNewsH5"];
        self.DirectSeedingH5 = [aDecoder decodeObjectForKey:@"DirectSeedingH5"];
        self.WealthPassH5 = [aDecoder decodeObjectForKey:@"WealthPassH5"];
    }
    return self;
}



@end

@implementation ShareURLModel



@end
