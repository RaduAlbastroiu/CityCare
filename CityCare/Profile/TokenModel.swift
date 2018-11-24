//
//  TokenModel.swift
//  CityCare
//
//  Created by Anisia Iova on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation

protocol TokenModel {
    var accessToken: String { get set }
    var tokenType: String { get set }
    var expiresIn: Int { get set }
    var userName: String { get set }
    var userData: ProfileModel { get set }
}

class TokenStubData : TokenModel {
    var accessToken = "YTbeRc2dWTsluw3FmnJSxr4RoExjf9A7PI6jWwf_VQP5e8B0PUPSYzHLDMWDnpAx3QTyK4cixI2q29dy-Y8zHQ2z6SZyjJaZYsNd4RqhPmoLpGYoE6JJpN0Q8yDmFL6XBEm17U9xpgtPHQLqNN32AM8LMEWpFoPZs7DfUHxs7cvh0lzYHptfGxCLp0uFm0GZFkFu-yhYU9kWiNnVGk6IyJkllI1pYrC7JsGDgNplzF2APDYi4CXUmqOticebBMwsxG0ULw2SVxblDKq0I4w7e7r1CrJLk7xJpDj3tI9oRzm13Ar6UTALw_22SXGnfQcS3fhmIOsCeLBDAeNINQdobjKRJBVkul0cH7quZ5Hh2qipjrJ2JAVngPXfLYJvTYNHkbwd-w3NOe-ei-Ek9R8gLQQE0MC3qqJyit2aKcmnsLovOId2jmglt4xZ9B2jdNsTdKnSC0RY1xVj-NJPJKBcSk5eIwRJ2g99_GqUYVOjKRRCcHwJQYtaaEdWf1krgWUbcP68kPo8imKU4D3BiAie_EmQpPNAVFjvJOpbpD3FAxLcaFBV1d03kUHhKIlR_kLNjX-K7AsiVjn5iQ83iJn1aLK1p0c0B7UySa-3wXiccl4py4eWYlGo9osOfGxh-sA60E0w26WtjaZCt1UfgG65vl3TNVHGkmAD_X6mIAYh5lIeb5CRYy8pz457HUT-U4H-0sBZKyBgsJGc-almj20E29IDTkMDIR6WWu1uNSD0kKbvlbzfBs4avWK3G8E5AfuvbRqzWQzPr4WYm1C_I7mYtwRzQsUQn3p5S1pvLb8OuWPT6GTtGl6Z3K5IL1WXty0c-7cKtf9Z5XahIAktXy2ZLZPF8QiRGZ-l8Yy7GAPPwODanYL72EGELsV00NKVojOk3zGZWMaPkEPDT1DSz_FezN6JIpE8IWYNGunbO8gPTTigcRpo26zqZo-4MtIn-Zes1BUwSaQVgHt4mu-z-XlYUgC9CTE6gGWJGsaX0CwpSk1CTiwYD26bCFdu6G5D6S5vlIGxVTosaX55G9GPjzA1TQFtpnK_E9H7XUSFPCM4-Sgc6QfUHj5jj2J-mUmEO19SI0cPTkveMX1ctMucd6rHXoM0DiPQMk-O8EVXa0PgxPUTtL1WK5TfvOQcF2SdTQ8Qz5meR0UwxCTgIB8JM-pOIxBqLdf9anDhJrgaZmw8Lwt04WmGnHw11E8E_jtbaK6_I_6Kwzh6YilcXZmBsuEeW7ejNmlHqAd-hznoklLN8VCdlrIV4FBdpgVAdVH38vpO"
    var tokenType = "bearer"
    var expiresIn = -1
    var userName = "deventureadmin@deventure.co"
    var userData: ProfileModel = ProfileStubData()
}
