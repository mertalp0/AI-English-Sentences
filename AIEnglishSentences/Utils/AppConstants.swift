//
//  AppConstants.swift
//  AIEnglishSentences
//
//  Created by mert alp on 26.12.2024.
//

import UIKit


struct AppConstants {
    
    struct URLs {

        static let appUrl = "https://apps.apple.com/tr/app/iq-test/id6670162878?l=tr"
        static let iqTestAppURLScheme = "iqtest://"
        static let iqTestAppStoreURL = "https://apps.apple.com/tr/app/iq-test/id6670162878?l=tr"
    }
    
    static let privacyPolicy =
        """
        Condition & Attending
        
        At enim hic etiam dolore. Dulce amarum, leve asperum, prope longe, stare movere, quadratum rotundum. At certe gravis. Nullus est igitur cuiusquam dies natalis. Paulum cum regem Persem captum adduceret, eodem flumine invectio?
        
        Quare hoc videndum est, possitne nobis hoc ratio philosophorum dare.
        Sed fingere non solum callidum eum, qui aliquid improbe faciat, verum etiam praeoptentem, ut M. Est autem officium, quod ita factum est, ut eius facti probabilis ratio reddi possit.
        
        Terms & Use
        
        Ut proverbia non nulla veriora sint quam vestra dogmata. Tamen aberramus a proposito, et, ne longius, prorsus, inquam, Piso, si ista mala sunt, placet. Omnes enim iucundum motum, quo sensus hilaretur. Cum id fugient, ne eadem defendant. Quo Peripatetici verba, Quibusnam praetereis?? Portenta haec esse dicit, quidam haec tuus. Si id dicis, vicimus.
        Qui ista effecit, beatum esse numquam probabis; Igitur neque stultorum quisquam beatus neque sapientium non beatus.
        
        Dicam, inquam, et quidem discendi causa magis, quam quo id ad Epicurum reprehensum velim.
        Dolar ergo, id est summum malum, metuetuer periculum est. Videmusne ut pueri ne verberibus quidem?
        """
    
    
    static let myApps: [AppModel] = [
        AppModel(appIcon: UIImage(named: "iq_test_logo")!, appName: "IQ Test", appDescription: "The IQ Test application allows you to effectively test your mental skills and quickly evaluate your progress. Complete your tests in just 5 minutes and discover your IQ level while tracking your improvement."),
        AppModel(appIcon: UIImage(named: "app_icon_ailex")!, appName: "AILex", appDescription: "AILex helps you improve your English skills by generating sentences using AI-provided words. Practice listening to these sentences and enhance your vocabulary and comprehension. In just a few minutes a day, boost your confidence in English while tracking your progress and mastering the language."),
       
    ]
    
    static let baseDeviceHeight:  CGFloat = 812.0
    static let baseDeviceWidth: CGFloat = 375.0
    
}
