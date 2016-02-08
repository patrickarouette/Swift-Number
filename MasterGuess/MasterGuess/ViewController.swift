//
//  ViewController.swift
//  MasterGuess
//
//  Created by Patrick Arouette on 24/01/16.
//  Copyright © 2016 Patrick Arouette. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var sliderLabelValue: UILabel!
    @IBOutlet weak var scoreLabelValue: UILabel!
    @IBOutlet weak var gainLabelValue: UILabel!
    
    //Value initialization
    var sliderIntegerValue: Int = 0
    var numberToGuessValue: Int = 0
    var scoreValue: Int = 0
    var roundValue: Int = 0
    var gainValue: Int = 0
    
    var differenceValue: Int = 0
    
    var title1Value: String = ""
    var title2Value: String = ""
    var title3Value: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Slider Icon
        
        /*let thumbImageNormal = UIImage(named: "Apple-Logo-Icon-42")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        let thumbImageHighlighted = UIImage(named: "Apple-Blue-Icon-42")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        if let trackLeftImage = UIImage(named: "SliderTrackLeft")
        {
            let trackLeftResizable =
            trackLeftImage.resizableImageWithCapInsets(insets) slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight")
        {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }*/
        
        //
        
        
        
        scoreLabelValue.text = "0"
        startNewGame()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func displayResult() {

        roundValue+=1
        gainValue-=1
        if (gainValue<0) {gainValue=0}
        gainLabelValue.text = String(gainValue)
        
        differenceValue = abs(numberToGuessValue-sliderIntegerValue)
        
        if (differenceValue==0)
        {
            title1Value = "Bravo! Trouvé en \(roundValue) tours"
            title2Value = "Vous avez gagné \(gainValue) point de plus"
            title3Value = "Nouvelle partie"
            
            scoreValue+=gainValue
            scoreLabelValue.text = String(scoreValue)
            
            startNewGame()
        } else
        {
            title1Value = "\(sliderIntegerValue)"
            title2Value = ""
            
            if (differenceValue<2)
            {
                title2Value+="Plus qu'à 1 ou 2 du nombre!"
            } else if (differenceValue<5)
            {
                title2Value+="Moins de 5 du nombre!"
            } else if (differenceValue<10)
            {
                title2Value+="Très proche du nombre!"
            } else if (differenceValue<20)
            {
                title2Value+="Assez proche du nombre!"
            } else if (differenceValue<30)
            {
                title2Value+="Moyennement loin!"
            } else if (differenceValue<50)
            {
                title2Value+="Assez loin du nombre!"
            } else
            {
                title2Value+="Très loin du nombre!"
            }
            
            title3Value = "Continuer"
        }
        
        let alert = UIAlertController(title: title1Value, message: title2Value, preferredStyle: .Alert)
        let action = UIAlertAction(title: title3Value, style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderNumberSelection(slider: UISlider) {
        sliderIntegerValue = lroundf(slider.value)
        print("The value of the slider is now: \(sliderIntegerValue)")
        sliderLabelValue.text = String(sliderIntegerValue)
    }

    @IBAction func sliderNumberMoins() {
    sliderIntegerValue = lroundf(slider.value)-1
    if (sliderIntegerValue<0) {sliderIntegerValue = 0}
    print("The value of the slider is now: \(sliderIntegerValue)")
    slider.value = Float(sliderIntegerValue)
    sliderLabelValue.text = String(sliderIntegerValue)
    }

    @IBAction func sliderNumberPlus() {
        sliderIntegerValue = lroundf(slider.value)+1
        if (sliderIntegerValue>100) {sliderIntegerValue = 100}
        print("The value of the slider is now: \(sliderIntegerValue)")
        slider.value = Float(sliderIntegerValue)
        sliderLabelValue.text = String(sliderIntegerValue)
    }
    
    @IBAction func startNewGame() {
        numberToGuessValue = 1 + Int(arc4random_uniform(100))
        sliderIntegerValue = 50
        sliderLabelValue.text = "50"
        slider.value = Float(sliderIntegerValue)
        gainValue = 10
        gainLabelValue.text = "10"
        roundValue = 0
            
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
        kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
            
    }
    
    @IBAction func resetNewGame() {
            
        scoreLabelValue.text = "0"
        scoreValue = 0
            
        startNewGame()
            
    }
    
}

