//
//  GeneratePassWord.swift
//  generateNum
//
//  Created by fancymax on 15/7/24.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Foundation

private let characters = Array("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".characters)

func generateRandomString(length:Int) -> String
{
    var string = ""
    for _ in 0..<length{
        string.append(generateRandomCharacter())
    }
    return string
}

func generateRandomCharacter() -> Character{
    let index = Int(arc4random_uniform(UInt32(characters.count)))
    let character = characters[index]
    return character
}
