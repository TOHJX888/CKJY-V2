//
//  IngredientManager.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import Foundation
import SwiftUI

class IngredientManager: ObservableObject {
    
    // MARK: Selected Ingredients
    
    @Published var selectedIngredients: [Ingredient] = [] {
        didSet {
            save()
        }
    }
    @Published var selectedIngredientsSearchTerm = ""

    var selectedIngredientsFilteredHealthy: Binding<[Ingredient]> {
        Binding (
            get: {
                if self.selectedIngredientsSearchTerm == "" {
                    return self.selectedIngredients.filter {
                        $0.points == 1
                    }
                }
                return self.selectedIngredients.filter {
                    $0.name.lowercased().contains(self.selectedIngredientsSearchTerm.lowercased()) && $0.points == 1
                }
            },
            set: {
                self.selectedIngredients = $0
            }
        )
    }
    
    var selectedIngredientsFilteredNeutral: Binding<[Ingredient]> {
        Binding (
            get: {
                if self.selectedIngredientsSearchTerm == "" {
                    return self.selectedIngredients.filter {
                        $0.points == 0
                    }
                }
                return self.selectedIngredients.filter {
                    $0.name.lowercased().contains(self.selectedIngredientsSearchTerm.lowercased()) && $0.points == 0
                }
            },
            set: {
                self.selectedIngredients = $0
            }
        )
    }
    
    var selectedIngredientsFilteredUnhealthy: Binding<[Ingredient]> {
        Binding (
            get: {
                if self.selectedIngredientsSearchTerm == "" {
                    return self.selectedIngredients.filter {
                        $0.points == -1
                    }
                }
                return self.selectedIngredients.filter {
                    $0.name.lowercased().contains(self.selectedIngredientsSearchTerm.lowercased()) && $0.points == -1
                }
            },
            set: {
                self.selectedIngredients = $0
            }
        )
    }
    
    // MARK: Total Points
    
    @Published var totalPoints = 0
    {
        didSet {
            save()
        }
    }
    
    // MARK: Points Goal
    
    @Published var pointsGoal = 30
    {
        didSet {
            save()
        }
    }
    
    // MARK: Recipes
    
    @Published var recipes: [Recipe] = [] {
        didSet {
            recipes.sort(by: { $0.recipeTitle < $1.recipeTitle })
            save()
        }
    }
    @Published var recipesSearchTerm = ""

    var recipesFiltered: Binding<[Recipe]> {
        Binding (
            get: {
                if self.recipesSearchTerm == "" { return self.recipes }
                return self.recipes.filter {
                    $0.recipeTitle.lowercased().contains(self.recipesSearchTerm.lowercased())
                }
            },
            set: {
                self.recipes = $0
            }
        )
    }
    
    // MARK: Preset Ingredients

    @Published var presetIngredients: [Ingredient] = [
        Ingredient(name: "Zucchini", points: 1, image: "https://tinyurl.com/m2pm38p5"),
        Ingredient(name: "Yellow squash", points: 0, image: " https://tinyurl.com/mu6u63hk"),
        Ingredient(name: "Yellow onions  ", points: 0, image: " https://tinyurl.com/bccykbax"),
        Ingredient(name: "yellow mustard  ", points: 0, image: "https://tinyurl.com/mrysp5ar"),
        Ingredient(name: "Worcestershire sauce", points: 0, image: "https://tinyurl.com/yjfmyuck"),
        Ingredient(name: "Whole wheat pasta ", points: 0, image: "https://tinyurl.com/422dp6dr"),
        Ingredient(name: "Whole wheat flour", points: 1, image: "https://tinyurl.com/mr2wzc45"),
        Ingredient(name: "Whole wheat bread", points: 0, image: "https://tinyurl.com/3fh8exc3"),
        Ingredient(name: "Whole grain cereal", points: 0, image: "https://tinyurl.com/mppv6uru"),
        Ingredient(name: "White wine vinegar ", points: 0, image: "https://tinyurl.com/3aap34a7"),
        Ingredient(name: "White wine", points: 0, image: " https://tinyurl.com/2cdfnrd5"),
        Ingredient(name: "White vinegar", points: 0, image: "https://tinyurl.com/bdzahh9r"),
        Ingredient(name: "White sugar", points: 0, image: "https://tinyurl.com/yxkwp9r3"),
        Ingredient(name: "White rice", points: 0, image: "https://tinyurl.com/mr294nzc"),
        Ingredient(name: "White potatoes", points: 0, image: "https://tinyurl.com/4hdvhht4"),
        Ingredient(name: "White pepper", points: 0, image: "https://tinyurl.com/sfcxd2k8"),
        Ingredient(name: "White onions", points: 0, image: "https://tinyurl.com/4khczxpy"),
        Ingredient(name: "White mushrooms", points: 0, image: "https://tinyurl.com/59hdnw5r"),
        Ingredient(name: "White chocolate chips", points: 0, image: "https://tinyurl.com/37btz8uu"),
        Ingredient(name: "White chocolate", points: 0, image: "https://tinyurl.com/ytaz6csx"),
        Ingredient(name: "White cheddar cheese", points: 0, image: "https://tinyurl.com/4ve7zu65"),
        Ingredient(name: "White bread", points: 0, image: "https://tinyurl.com/bdhwar9j"),
        Ingredient(name: "White beans", points: 0, image: "https://tinyurl.com/ae5bn35m"),
        Ingredient(name: "White balsamic vinegar", points: 1, image: "https://tinyurl.com/yxektncw"),
        Ingredient(name: "Wheat thins", points: 0, image: "https://tinyurl.com/3b2jbyw3"),
        Ingredient(name: "Wheat flour", points: 0, image: "https://tinyurl.com/2p9demjw"),
        Ingredient(name: "Watermelon radish", points: 1, image: "https://tinyurl.com/29xzcpsb"),
        Ingredient(name: "Watermelon", points: 1, image: "https://tinyurl.com/bdf6xs2y"),
        Ingredient(name: "Watercress", points: 1, image: "https://tinyurl.com/mu4z8m7s"),
        Ingredient(name: "Wasabi", points: 1, image: "https://tinyurl.com/62j53nnb"),
        Ingredient(name: "Walnuts", points: 1, image: "https://tinyurl.com/5n6szjc3"),
        Ingredient(name: "Vanilla extract", points: 0, image: "https://tinyurl.com/5aykcrr8"),
        Ingredient(name: "Vanilla", points: 1, image: "https://tinyurl.com/4np58n4p"),
        Ingredient(name: "Udon noodles", points: 1, image: "https://tinyurl.com/38mpb38v"),
        Ingredient(name: "Twizzlers", points: 0, image: "https://tinyurl.com/mbbu6j3x"),
        Ingredient(name: "Twix", points: 0, image: "https://tinyurl.com/fvjjaem7"),
        Ingredient(name: "Turnips", points: 1, image: "https://tinyurl.com/mtvnf8fz"),
        Ingredient(name: "Turmeric root", points: 1, image: "https://tinyurl.com/4fbywkm8"),
        Ingredient(name: "Turmeric powder", points: 1, image: "https://tinyurl.com/hwje9v3e"),
        Ingredient(name: "Turmeric", points: 1, image: "https://tinyurl.com/dmwtsydr"),
        Ingredient(name: "Turkey sausage", points: 0, image: "https://tinyurl.com/5n78dcv3"),
        Ingredient(name: "Turkey burgers", points: 0, image: "https://tinyurl.com/34cn8pmk"),
        Ingredient(name: "Turkey Breasts", points: 0, image: "https://tinyurl.com/turkeybb"),
        Ingredient(name: "Turkey bacon", points: 0, image: "https://tinyurl.com/bacon-world"),
        Ingredient(name: "Tuna", points: 1, image: "https://tinyurl.com/y8buyjd3"),
        Ingredient(name: "Truffle oil", points: 1, image: "https://tinyurl.com/yyy5rppj"),
        Ingredient(name: "Triscuits", points: 0, image: "https://tinyurl.com/nxru85b5"),
        Ingredient(name: "Tortilla chips", points: -1, image: "https://tinyurl.com/rr6ha4px"),
        Ingredient(name: "Tomato sauce", points: 0, image: "https://tinyurl.com/tomatoe-sauce"),
        Ingredient(name: "Tomato paste", points: 0, image: "https://tinyurl.com/paste-tomatoe"),
        Ingredient(name: "Tomatoes", points:1, image: "https://tinyurl.com/3dxpbwv4"),
        Ingredient(name: "Tomatillos", points: 1, image: "https://tinyurl.com/tillo-tomato-tillo"),
        Ingredient(name: "Tofu", points: 1, image: "https://tinyurl.com/6fvvbavv"),
        Ingredient(name: "Toffee", points: -1, image: "https://tinyurl.com/57sha8m9"),
        Ingredient(name: "Tilapia", points: 0, image: "https://tinyurl.com/mrxfsmts"),
        Ingredient(name: "Teriyaki sauce", points: 0, image: "https://tinyurl.com/dv7ynjcf"),
        Ingredient(name: "Tempeh", points: 1, image: "https://tinyurl.com/mukt6ynm"),
        Ingredient(name: "Teddy Grahams", points: 0, image: "https://tinyurl.com/4s3xw7wy"),
        Ingredient(name: "TarTar sauce", points: -1, image: "https://tinyurl.com/tar-tar-sauceeee"),
        Ingredient(name: "Tarragon", points: 1, image: "https://tinyurl.com/42ene2nf"),
        Ingredient(name: "Tapioca pudding", points: -1, image: "https://tinyurl.com/omg-tapiocaaaa"),
        Ingredient(name: "Tangelo", points: 1, image: "https://tinyurl.com/yc67r37x"),
        Ingredient(name: "Taco", points: -1, image: "https://tinyurl.com/ycy4xahd"),
        Ingredient(name: "Swiss chard", points: 1, image: "https://tinyurl.com/yj3ne3yy"),
        Ingredient(name: "Sweetened sunflower milk", points: -1, image: "https://tinyurl.com/mr4x5537"),
        Ingredient(name: "Sweetened soy milk", points: -1, image: "https://tinyurl.com/mvsx542p"),
        Ingredient(name: "Sweetened rice milk", points: -1, image: "https://tinyurl.com/mr2xpn3z"),
        Ingredient(name: "Sweetened oat milk", points: -1, image: "https://tinyurl.com/44xuy2y6"),
        Ingredient(name: "Sweetened hemp milk", points: -1, image: "https://tinyurl.com/2f2er8ev"),
        Ingredient(name: "Sweetened condensed milk", points: -1, image: "https://tinyurl.com/3fhshnuh"),
        Ingredient(name: "Sweetened coconut milk", points: -1, image: "https://tinyurl.com/2r9su8vk"),
        Ingredient(name: "Sweetened cashew milk", points: -1, image: "https://tinyurl.com/bdzapahu"),
        Ingredient(name: "Sweetened almond milk", points: -1, image: "https://tinyurl.com/yr2chyf4"),
        Ingredient(name: "Sweet potato fries", points: -1, image: "https://tinyurl.com/yx7b9923"),
        Ingredient(name: "Sweet potatoes", points: 1, image: "https://tinyurl.com/48nb8zan"),
        Ingredient(name: "Sweet peppers", points: 0, image: "https://tinyurl.com/sweettt-peppersss"),
        Ingredient(name: "Sweet onion", points: 1, image: "https://tinyurl.com/im-a-sweet-onion-ahhh"),
        Ingredient(name: "Sweet corn", points: 0, image: "https://tinyurl.com/4kw3p5fr"),
        Ingredient(name: "Swedish fish", points: 0, image: "https://tinyurl.com/gummy-fish"),
        Ingredient(name: "Sunflower seeds", points: 1, image: "https://tinyurl.com/sunflower-seeds-ah"),
        Ingredient(name: "Sunflower oil", points: 0, image: "https://tinyurl.com/zmxhpkpr"),
        Ingredient(name: "Sun-dried tomatoes", points: 1, image: "https://tinyurl.com/sun-dried-tomatoes"),
        Ingredient(name: "Sunchokes", points: 1, image: "https://tinyurl.com/5t4737s9"),
        Ingredient(name: "Sucralose", points: -1, image: "https://tinyurl.com/3b53tbns"),
        Ingredient(name: "Strawberries", points: 1, image: "https://tinyurl.com/58zj6v3p"),
        Ingredient(name: "Star fruit", points: 1, image: "https://tinyurl.com/54wse5dw"),
        Ingredient(name: "Starbursts", points: 0, image: "https://tinyurl.com/starbust-candyyy"),
        Ingredient(name: "Star anise", points: 1, image: "https://tinyurl.com/4e2xd74v"),
        Ingredient(name: "Spinach", points: 1, image: "https://tinyurl.com/spinachhhh"),
        Ingredient(name: "Spaghetti", points: 0, image: "https://tinyurl.com/yrejawx8"),
        Ingredient(name: "Soy sauce", points: 0, image: "https://tinyurl.com/bdzehu8u"),
        Ingredient(name: "Soy milk", points: 1, image: "https://tinyurl.com/3zy58a85"),
        Ingredient(name: "Soursop", points: 1, image: "https://tinyurl.com/4mcjzhps"),
        Ingredient(name: "Sourpatch Kids", points: 0, image: "https://tinyurl.com/fn3pbs9z"),
        Ingredient(name: "Sourdough bread", points: 0, image: "https://tinyurl.com/bddyjc4k"),
        Ingredient(name: "Sour cream", points: 0, image: "https://tinyurl.com/2vj7emf5"),
        Ingredient(name: "Sorrel", points: 1, image: "https://tinyurl.com/3rtrwsxx"),
        Ingredient(name: "Sorghum", points: 1, image: "https://tinyurl.com/2xpce44w"),
        Ingredient(name: "Sodium benzoate", points: -1, image: "https://tinyurl.com/3zreumxp"),
        Ingredient(name: "Sodium Aluminium Sulfate", points: -1, image: "https://tinyurl.com/382n43et"),
        Ingredient(name: "Sodas", points: -1, image: "https://tinyurl.com/eshxa7tw"),
        Ingredient(name: "Soba noodles", points: 1, image: "https://tinyurl.com/4s6atw3f"),
        Ingredient(name: "Snickers", points: 0, image: "https://tinyurl.com/5yt2w6jz"),
        Ingredient(name: "Skittles", points: 0, image: "https://tinyurl.com/yp46zypw"),
        Ingredient(name: "Shrimp", points: 0, image: "https://tinyurl.com/5b5pf7pp"),
        Ingredient(name: "Shallots", points: 1, image: "https://tinyurl.com/5jrvv3s6"),
        Ingredient(name: "Sesame seeds", points: 1, image: "https://tinyurl.com/2yvuef9d"),
        Ingredient(name: "Sesame oil", points: 0, image: "https://tinyurl.com/2m5dxtfc"),
        Ingredient(name: "Seaweed", points: 1, image: "https://tinyurl.com/49tw8fzp"),
        Ingredient(name: "Scallions", points: 0, image: "https://tinyurl.com/bdfuernc"),
        Ingredient(name: "Sausage rolls", points: 0, image: "https://tinyurl.com/44nxwbkj"),
        Ingredient(name: "Sausages", points: 0, image: "https://tinyurl.com/yn7hum5c"),
        Ingredient(name: "Sardines", points: 1, image: "https://tinyurl.com/yc2zth6t"),
        Ingredient(name: "Saltines", points: 0, image: "https://tinyurl.com/5bx8mjmx"),
        Ingredient(name: "Salsify", points: 1, image: "https://tinyurl.com/y5yzban3"),
        Ingredient(name: "Salmon", points: 1, image: "https://tinyurl.com/yhew263v"),
        Ingredient(name: "Sage", points: 1, image: "https://tinyurl.com/3ntpjwa5"),
        Ingredient(name: "Saffron", points: 1, image: "https://tinyurl.com/4tan6ydr"),
        Ingredient(name: "Saccharin", points: -1, image: "https://tinyurl.com/trkbaxev"),
        Ingredient(name: "Rutabaga", points: 1, image: "https://tinyurl.com/2s3vwp4n"),
        Ingredient(name: "Romanesco", points: 1, image: "https://tinyurl.com/t9beww68"),
        Ingredient(name: "Romaine lettuce", points: 1, image: "https://tinyurl.com/4u3vvu8j"),
        Ingredient(name: "Ritz crackers", points: 0, image: "https://tinyurl.com/2xapkjc8"),
        Ingredient(name: "Ricotta cheese", points: 0, image: "https://tinyurl.com/yckjbj3a"),
        Ingredient(name: "Rice vinegar", points: 0, image: "https://tinyurl.com/3u99deay"),
        Ingredient(name: "Rice pudding", points: 0, image: "https://tinyurl.com/5b66hwrh"),
        Ingredient(name: "Rice noodles", points: 0, image: "https://tinyurl.com/3vyzntev"),
        Ingredient(name: "Rice Krispie treats", points: 0, image: "https://tinyurl.com/7cavcxjs"),
        Ingredient(name: "Rice Krispies", points: 0, image: "https://tinyurl.com/yckm2exv"),
        Ingredient(name: "Rice flour", points: 0, image: "https://tinyurl.com/n45pyrjp"),
        Ingredient(name: "Rice cereal", points: 0, image: "https://tinyurl.com/2k3mz4p3"),
        Ingredient(name: "Rice cakes", points: 0, image: "https://tinyurl.com/yj4cm8yf"),
        Ingredient(name: "Rice bran oil", points: 1, image: "https://tinyurl.com/3ryz62dm"),
        Ingredient(name: "Reese’s Pieces", points: 0, image: "https://tinyurl.com/mrx6newx"),
        Ingredient(name: "Red wine vinegar", points: 0, image: "https://tinyurl.com/2uyae444"),
        Ingredient(name: "Red snapper", points: 1, image: "https://tinyurl.com/8ayu6ebc"),
        Ingredient(name: "Red quinoa", points: 1, image: "https://tinyurl.com/3hbbmyj4"),
        Ingredient(name: "Red potatoes", points: 0, image: "https://tinyurl.com/3zstpcvj"),
        Ingredient(name: "Red pepper flakes", points: 0, image: "https://tinyurl.com/34nutm99"),
        Ingredient(name: "Red peppers", points: 1, image: "https://tinyurl.com/3w868rs8"),
        Ingredient(name: "Red lentils", points: 1, image: "https://tinyurl.com/f3ph9x33"),
        Ingredient(name: "Red cabbage", points: 1, image: "https://tinyurl.com/5n8nw9av"),
        Ingredient(name: "Red bell peppers", points: 0, image: "https://tinyurl.com/mppnh8fz"),
        Ingredient(name: "Raspberry vinegar", points: 0, image: "https://tinyurl.com/3psm4hj4"),
        Ingredient(name: "Raspberry jam", points: 0, image: "https://tinyurl.com/52ukc9ff"),
        Ingredient(name: "Raspberries", points: 1, image: "https://tinyurl.com/mptv9jr5"),
        Ingredient(name: "Ranch dressing", points: 0, image: "https://tinyurl.com/3k9f69s4"),
        Ingredient(name: "Ramen noodles", points: 0, image: "https://tinyurl.com/26v588xv"),
        Ingredient(name: "Raisin bran", points: 0, image: "https://tinyurl.com/4hb54d4s"),
        Ingredient(name: "Raisins", points: 0, image: "https://tinyurl.com/yc7r2pu7"),
        Ingredient(name: "Radishes", points: 1, image: "https://tinyurl.com/aazj779k"),
        Ingredient(name: "Radicchio", points: 0, image: "https://tinyurl.com/57zmzh3z"),
        Ingredient(name: "Quinoa", points: 1, image: "https://tinyurl.com/ycx8px7m"),
        Ingredient(name: "Quince", points: 1, image: "https://tinyurl.com/4uan6nwp"),
        Ingredient(name: "Quark cheese", points: 1, image: "https://tinyurl.com/384xyjtx"),
        Ingredient(name: "Quail eggs", points: 1, image: "https://tinyurl.com/3rz2tnzd"),
        Ingredient(name: "Pumpkin seeds", points: 1, image: ""),
        Ingredient(name: "Pumpkin oil", points: 1, image: ""),
        Ingredient(name: "Pumpkin", points: 1, image: ""),
        Ingredient(name: "Pudding cups", points: 0, image: ""),
        Ingredient(name: "Prunes", points: 1, image: ""),
        Ingredient(name: "Processed cheese", points: -1, image: ""),
        Ingredient(name: "Pringles", points: 0, image: ""),
        Ingredient(name: "Pretzels", points: 0, image: ""),
        Ingredient(name: "Potato skins", points: 0, image: ""),
        Ingredient(name: "Potato salad", points: 0, image: ""),
        Ingredient(name: "Potato chips", points: -1, image: ""),
        Ingredient(name: "Potatoes", points: 1, image: ""),
        Ingredient(name: "Potassium sorbate", points: -1, image: ""),
        Ingredient(name: "Pork tenderloin", points: 0, image: ""),
        Ingredient(name: "Pork ribs", points: 0, image: ""),
        Ingredient(name: "Pork chops", points: 0, image: ""),
        Ingredient(name: "Pop tarts", points: -1, image: ""),
        Ingredient(name: "Popcorn", points: 0, image: ""),
        Ingredient(name: "Pomegranate seeds", points: 1, image: ""),
        Ingredient(name: "Pomegranate molasses", points: 1, image: ""),
        Ingredient(name: "Plums", points: 1, image: ""),
        Ingredient(name: "Plantains", points: 1, image: ""),
        Ingredient(name: "Plain flour", points: 0, image: ""),
        Ingredient(name: "Pizza rolls", points: 0, image: ""),
        Ingredient(name: "Pizza", points: -1, image: ""),
        Ingredient(name: "Pistachio oil", points: 1, image: ""),
        Ingredient(name: "Pistachio", points: 1, image: ""),
        Ingredient(name: "Pinto beans", points: 1, image: ""),
        Ingredient(name: "Pink grapefruit", points: 1, image: ""),
        Ingredient(name: "Pine nuts", points: 1, image: ""),
        Ingredient(name: "Pineapple juice", points: 0, image: ""),
        Ingredient(name: "Pineapple", points: 1, image: ""),
        Ingredient(name: "Pies", points: -1, image: ""),
        Ingredient(name: "Persimmons", points: 1, image: ""),
        Ingredient(name: "Pecan pie", points: 0, image: ""),
        Ingredient(name: "Pecans", points: 1, image: ""),
        Ingredient(name: "Pears", points: 1, image: ""),
        Ingredient(name: "Peas", points: 1, image: ""),
        Ingredient(name: "Pasta", points: 0, image: ""),
        Ingredient(name: "Passion fruit", points: 1, image: ""),
        Ingredient(name: "Parsley", points: 0, image: ""),
        Ingredient(name: "Parmesan cheese", points: 0, image: ""),
        Ingredient(name: "Paprika", points: 1, image: ""),
        Ingredient(name: "Pappardelle", points: 1, image: ""),
        Ingredient(name: "Papaya", points: 1, image: ""),
        Ingredient(name: "Pancake syrup", points: -1, image: ""),
        Ingredient(name: "Palm oil", points: -1, image: ""),
        Ingredient(name: "Oregano", points: 0, image: "https://tinyurl.com/re3fjjp5"),
        Ingredient(name: "Orange juice", points: 0, image: "https://shorturl.at/ikCT8"),
        Ingredient(name: "Oranges", points: 1, image: "https://shorturl.at/aciX2"),
        Ingredient(name: "Onion powder", points: 0, image: "https://shorturl.at/moRU7"),
        Ingredient(name: "Onions", points: 1, image: "https://shorturl.at/jnoS7"),
        Ingredient(name: "Olive oil", points: 1, image: "https://images.app.goo.gl/yMWNAscFGLkCzArY6"),
        Ingredient(name: "Olestra", points: -1, image: "https://shorturl.at/egzK6"),
        Ingredient(name: "Okra", points: 1, image: "https://tinyurl.com/3yev55m9"),
        Ingredient(name: "Oats", points: 1, image: "https://tinyurl.com/2s3nvxbj"),
        Ingredient(name: "Nutritional yeast", points: 1, image: "https://tinyurl.com/3w63msnn"),
        Ingredient(name: "Nutmeg", points: 0, image: "https://tinyurl.com/yscyhysa"),
        Ingredient(name: "Nutella", points: 0, image: "https://tinyurl.com/5dvjt4ph"),
        Ingredient(name: "Nori", points: 1, image: "https://tinyurl.com/6zp96tz5"),
        Ingredient(name: "Navy beans", points: 1, image: "https://tinyurl.com/3ybvesvb"),
        Ingredient(name: "Napa cabbage", points: 1, image: "https://tinyurl.com/5n8d6b3b"),
        Ingredient(name: "M&M’s", points: 0, image: "https://tinyurl.com/3mc82zcw"),
        Ingredient(name: "Mustard greens", points: 1, image: "https://tinyurl.com/5n72mb88"),
        Ingredient(name: "Mustard", points: 0, image: "https://tinyurl.com/bde4bea3"),
        Ingredient(name: "Mushrooms", points: 1, image: "https://tinyurl.com/2zv94rnm"),
        Ingredient(name: "Mung beans", points: 1, image: "https://tinyurl.com/4dmsevb"),
        Ingredient(name: "Mulberries", points: 1, image: "https://tinyurl.com/bde4mb4k"),
        Ingredient(name: "Mozzarella sticks", points: -1, image: "https://tinyurl.com/4at34f3f"),
        Ingredient(name: "Mozzarella cheese", points: 0, image: "https://tinyurl.com/mr2ubjy8"),
        Ingredient(name: "Miso", points: 1, image: "https://tinyurl.com/bdh6awa9"),
        Ingredient(name: "Millet", points: 1, image: "https://tinyurl.com/3w46rkmj"),
        Ingredient(name: "Milky Way", points: 0, image: "https://tinyurl.com/yck736tx"),
        Ingredient(name: "Milkshakes", points: -1, image: "https://tinyurl.com/2p8ed5bj"),
        Ingredient(name: "Mayonnaise", points: -1, image: "https://tinyurl.com/yr6fcwep"),
        Ingredient(name: "Marshmallow fluff", points: 0, image: "https://tinyurl.com/mr2bt78j"),
        Ingredient(name: "Marshmallows", points: 0, image: "https://tinyurl.com/my63tey6"),
        Ingredient(name: "Margarine", points: -1, image: "https://tinyurl.com/yc3dwc8z"),
        Ingredient(name: "Maple syrup", points: 0, image: "https://tinyurl.com/2s43j7kn"),
        Ingredient(name: "Mango", points: 1, image: "https://tinyurl.com/yc5ztpba"),
        Ingredient(name: "Mache", points: 1, image: "https://tinyurl.com/yjkmf86t"),
        Ingredient(name: "Lychee", points: 1, image: "https://tinyurl.com/3f3yxe79"),
        Ingredient(name: "Lucky Charms", points: 0, image: "https://tinyurl.com/3yuszb2c"),
        Ingredient(name: "Loquats", points: 1, image: "https://tinyurl.com/mryee5au"),
        Ingredient(name: "Limes", points: 1, image: "https://tinyurl.com/3fkbpbuu"),
        Ingredient(name: "Licorice", points: -1, image: "https://tinyurl.com/3x2pbmam"),
        Ingredient(name: "Lettuce", points: 0, image: "https://tinyurl.com/y668hbnc"),
        Ingredient(name: "Lentils", points: 1, image: "https://tinyurl.com/5funmvcv"),
        Ingredient(name: "Lemongrass", points: 1, image: "https://tinyurl.com/4fasvzyn"),
        Ingredient(name: "Lemonade with added sugar", points: -1, image: "https://tinyurl.com/ntp47tz6"),
        Ingredient(name: "Lemonade", points: 0, image: "https://tinyurl.com/2rnerh4r"),
        Ingredient(name: "Leeks", points: 1, image: "https://tinyurl.com/mr2n848c"),
        Ingredient(name: "Lavender", points: 1, image: "https://tinyurl.com/38n75n65"),
        Ingredient(name: "Lard", points: -1, image: "https://tinyurl.com/3m2ycj5v"),
        Ingredient(name: "Kohlrabi", points: 1, image: "https://tinyurl.com/3krpwxh6"),
        Ingredient(name: "Kix cereal", points: 0, image: "https://tinyurl.com/2y3vrw25"),
        Ingredient(name: "Kiwi berries", points: 1, image: "https://tinyurl.com/3vs4d7bm"),
        Ingredient(name: "Kiwi", points: 1, image: "https://tinyurl.com/x5bw6hdm"),
        Ingredient(name: "Kit Kat", points: 0, image: "https://tinyurl.com/bd69bf93"),
        Ingredient(name: "Kidney beans", points: 1, image: "https://tinyurl.com/3cyf83f2"),
        Ingredient(name: "Ketchup", points: 0, image: "https://tinyurl.com/4htn5fyk"),
        Ingredient(name: "Kelp", points: 1, image: "https://tinyurl.com/52xnzh2t"),
        Ingredient(name: "Kamut", points: 1, image: "https://tinyurl.com/yc8ftx9j"),
        Ingredient(name: "Kale", points: 1, image: "https://tinyurl.com/2akj5v6w"),
        Ingredient(name: "Jicama", points: 1, image: "https://tinyurl.com/bdcn24a9"),
        Ingredient(name: "Jelly beans", points: -1, image: "https://tinyurl.com/ytn6jn4a"),
        Ingredient(name: "Jasmine rice", points: 0, image: "https://tinyurl.com/5x2h29f5"),
        Ingredient(name: "Jams", points: 0, image: "https://tinyurl.com/22s7977p"),
        Ingredient(name: "Jalapenos", points: 1, image: "https://tinyurl.com/4dpbbux7"),
        Ingredient(name: "Jaggery", points: 1, image: "https://tinyurl.com/36vbvv94"),
        Ingredient(name: "Instant rice with seasoning packets", points: -1, image: ""),
        Ingredient(name: "Instant ramen noodles", points: -1, image: ""),
        Ingredient(name: "Instant noodles", points: -1, image: ""),
        Ingredient(name: "Instant mashed potato flakes", points: -1, image: ""),
        Ingredient(name: "Instant mashed potatoes", points: -1, image: ""),
        Ingredient(name: "Instant gravy mix", points: -1, image: ""),
        Ingredient(name: "Iced teas with added sugar", points: -1, image: ""),
        Ingredient(name: "Ice cream cones", points: 0, image: "https://tinyurl.com/ynr7rer2"),
        Ingredient(name: "Ice cream", points: -1, image: "https://tinyurl.com/4zrbuaft"),
        Ingredient(name: "Iceberg lettuce", points: 0, image: ""),
        Ingredient(name: "Hydrogenated oils", points: -1, image: ""),
        Ingredient(name: "Huckleberries", points: 1, image: ""),
        Ingredient(name: "Hot sauce", points: 0, image: ""),
        Ingredient(name: "Hot dogs", points: -1, image: ""),
        Ingredient(name: "Horseradish", points: 0, image: ""),
        Ingredient(name: "Honeydew melon", points: 1, image: ""),
        Ingredient(name: "Honeycomb cereal", points: 0, image: ""),
        Ingredient(name: "Honey Bunches of Oats", points: 0, image: ""),
        Ingredient(name: "Honey", points: 0, image: ""),
        Ingredient(name: "Hershey", points: 0, image: ""),
        Ingredient(name: "Herring", points: 1, image: ""),
        Ingredient(name: "Hemp seeds", points: 1, image: ""),
        Ingredient(name: "Hearts of palm", points: 1, image: ""),
        Ingredient(name: "Hazelnut oil", points: 1, image: ""),
        Ingredient(name: "Hazelnuts", points: 1, image: ""),
        Ingredient(name: "Hash browns with added preservatives", points: -1, image: ""),
        Ingredient(name: "Hard candies", points: -1, image: ""),
        Ingredient(name: "Hamburger Helper", points: -1, image: ""),
        Ingredient(name: "Gummy worms", points: 0, image: ""),
        Ingredient(name: "Gummy candies", points: -1, image: ""),
        Ingredient(name: "Gummy bears", points: 0, image: ""),
        Ingredient(name: "Guava", points: 1, image: ""),
        Ingredient(name: "Ground venison", points: 0, image: ""),
        Ingredient(name: "Ground veal", points: 0, image: ""),
        Ingredient(name: "Ground turkey", points: 0, image: ""),
        Ingredient(name: "Ground rabbit", points: 0, image: ""),
        Ingredient(name: "Ground pork", points: 0, image: ""),
        Ingredient(name: "Ground ostrich", points: 0, image: ""),
        Ingredient(name: "Ground lamb", points: 0, image: ""),
        Ingredient(name: "Ground chicken", points: 0, image: ""),
        Ingredient(name: "Ground buffalo", points: 0, image: ""),
        Ingredient(name: "Ground bison", points: 0, image: ""),
        Ingredient(name: "Ground beef", points: 0, image: "https://tinyurl.com/325fjzxh"),
        Ingredient(name: "Green tea", points: 1, image: "https://tinyurl.com/pnv4sn62"),
        Ingredient(name: "Green peas", points: 1, image: "https://tinyurl.com/bdh6k5wt"),
        Ingredient(name: "Green onions", points: 1, image: "https://tinyurl.com/4cpzrejy"),
        Ingredient(name: "Green olives", points: 0, image: "https://tinyurl.com/4hp24txj"),
        Ingredient(name: "Green lentils", points: 0, image: "https://tinyurl.com/34cuz2rv"),
        Ingredient(name: "Green cabbage", points: 0, image: "https://tinyurl.com/bddn6rhc"),
        Ingredient(name: "Green bell peppers", points: 1, image: "https://tinyurl.com/yy7eeks2"),
        Ingredient(name: "Green beans", points: 1, image: "https://tinyurl.com/2s3ta7fs"),
        Ingredient(name: "Green yogurt", points: 1, image: "https://tinyurl.com/42m7r3jp"),
        Ingredient(name: "Green olives", points: 1, image: "https://tinyurl.com/2xkny63y"),
        Ingredient(name: "Grape juice", points: 0, image: "https://tinyurl.com/grape-juice"),
        Ingredient(name: "Grapefruit", points: 1, image: "https://tinyurl.com/5fcbjzsd"),
        Ingredient(name: "Granola", points: 0, image: "https://t.ly/K83Ez"),
        Ingredient(name: "Graham crackers", points: 0, image: "https://t.ly/gbsx2"),
        Ingredient(name: "Gouda cheese", points: 0, image: "https://shorturl.at/ABOPS"),
        Ingredient(name: "Goldfish crackers", points: 0, image: "https://shorturl.at/foyRX"),
        Ingredient(name: "Gingersnaps", points: 0, image: "https://shorturl.at/bgB08"),
        Ingredient(name: "Ginger", points: 1, image: "https://shorturl.at/kqyOT"),
        Ingredient(name: "Ghee", points: 1, image: "https://shorturl.at/gtvI8"),
        Ingredient(name: "Garlic powder", points: 0, image: ""),
        Ingredient(name: "Garlic", points: 0, image: ""),
        Ingredient(name: "Garam masala", points: 1, image: ""),
        Ingredient(name: "Fudges", points: -1, image: ""),
        Ingredient(name: "Fruit snacks", points: 0, image: ""),
        Ingredient(name: "Fruit roll-ups", points: -1, image: ""),
        Ingredient(name: "Fruit loops", points: 0, image: ""),
        Ingredient(name: "Fruit-flavored snacks", points: -1, image: ""),
        Ingredient(name: "Frozen toaster pastries", points: -1, image: ""),
        Ingredient(name: "Frozen tater tots", points: -1, image: ""),
        Ingredient(name: "Frozen taquitos", points: -1, image: ""),
        Ingredient(name: "Frozen sandwiches", points: -1, image: ""),
        Ingredient(name: "Frozen pot pies", points: -1, image: ""),
        Ingredient(name: "Frozen pizza", points: -1, image: ""),
        Ingredient(name: "Frozen onion rings", points: -1, image: ""),
        Ingredient(name: "Frozen fried foods", points: -1, image: ""),
        Ingredient(name: "Frozen French fries", points: -1, image: ""),
        Ingredient(name: "Frozen corndogs", points: -1, image: ""),
        Ingredient(name: "Frozen chimichangas", points: -1, image: ""),
        Ingredient(name: "Frozen burritos", points: -1, image: ""),
        Ingredient(name: "Frozen breaded chicken nuggets", points: -1, image: ""),
        Ingredient(name: "Flour tortillas", points: -1, image: ""),
        Ingredient(name: "Fries", points: -1, image: ""),
        Ingredient(name: "Fried fish", points: -1, image: ""),
        Ingredient(name: "Fried chicken", points: -1, image: ""),
        Ingredient(name: "Flaxseed oil", points: 1, image: ""),
        Ingredient(name: "Flaxseed meal", points: 1, image: ""),
        Ingredient(name: "Flaxseeds", points: 1, image: ""),
        Ingredient(name: "Flavored coffee creamer", points: -1, image: ""),
        Ingredient(name: "Fish stickers", points: -1, image: ""),
        Ingredient(name: "Fig vinegar", points: 1, image: ""),
        Ingredient(name: "Fig Newtons", points: 0, image: ""),
        Ingredient(name: "Figs", points: 0, image: ""),
        Ingredient(name: "Fettuccine", points: 0, image: ""),
        Ingredient(name: "Feta cheese", points: 1, image: ""),
        Ingredient(name: "Fennel", points: 1, image: ""),
        Ingredient(name: "Fava beans", points: 1, image: ""),
        Ingredient(name: "Farro", points: 1, image: ""),
        Ingredient(name: "Fajita seasoning", points: 1, image: ""),
        Ingredient(name: "Enriched flour", points: -1, image: ""),
        Ingredient(name: "Energy drinks", points: -1, image: ""),
        Ingredient(name: "Endive", points: 1, image: ""),
        Ingredient(name: "Emmer wheat", points: 1, image: ""),
        Ingredient(name: "Elderberrries", points: 1, image: ""),
        Ingredient(name: "Eggs", points: 1, image: ""),
        Ingredient(name: "Edamame", points: 1, image: ""),
        Ingredient(name: "Durian", points: 1, image: ""),
        Ingredient(name: "Dragon fruit", points: 1, image: ""),
        Ingredient(name: "Donuts", points: -1, image: ""),
        Ingredient(name: "Dill", points: 1, image: "https://tinyurl.com/2n4auj6d"),
        Ingredient(name: "Dijon mustard", points: 0, image: ""),
        Ingredient(name: "Diet soda", points: -1, image: ""),
        Ingredient(name: "Deli meats", points: -1, image: ""),
        Ingredient(name: "Dates", points: 1, image: ""),
        Ingredient(name: "Dark chocolate", points: 0, image: ""),
        Ingredient(name: "Dark brown sugar", points: 0, image: ""),
        Ingredient(name: "Dandelion greens", points: 1, image: ""),
        Ingredient(name: "Daikon radish", points: 1, image: ""),
        Ingredient(name: "Currants", points: 1, image: "https://tinyurl.com/mpbks698"),
        Ingredient(name: "Cumin", points: 1, image: "https://tinyurl.com/2p84hfbc"),
        Ingredient(name: "Cucumbers", points: 1, image: "https://tinyurl.com/2f2ystmf"),
        Ingredient(name: "Cranberry sauce", points: 0, image: "https://tinyurl.com/mwfrcp95"),
        Ingredient(name: "Cranberries", points: 1, image: "https://tinyurl.com/585pkwpc"),
        Ingredient(name: "Cotton candy", points: -1, image: "https://tinyurl.com/3yd64kwb"),
        Ingredient(name: "Cottage cheese", points: 1, image: "https://tinyurl.com/5aac4fsu"),
        Ingredient(name: "Cotijia cheese", points: 1, image: "https://tinyurl.com/3v9bc5rd"),
        Ingredient(name: "Corn syrup", points: 0, image: "https://tinyurl.com/3ky42xcw"),
        Ingredient(name: "Cornstarch", points: 0, image: "https://tinyurl.com/48423zmx"),
        Ingredient(name: "Corn snacks", points: -1, image: "https://tinyurl.com/3kxr63ry"),
        Ingredient(name: "Corn oil", points: 0, image: ""),
        Ingredient(name: "Cornmeal", points: 0, image: ""),
        Ingredient(name: "Corn flakes", points: 0, image: ""),
        Ingredient(name: "Corn dogs", points: 0, image: ""),
        Ingredient(name: "Corn chips", points: 0, image: ""),
        Ingredient(name: "Cornbread", points: 0, image: ""),
        Ingredient(name: "Corn", points: 0, image: ""),
        Ingredient(name: "Cookies", points: -1, image: ""),
        Ingredient(name: "Concord grapes", points: 1, image: ""),
        Ingredient(name: "Cola", points: 0, image: ""),
        Ingredient(name: "Cod", points: 1, image: ""),
        Ingredient(name: "Coconut water", points: 1, image: "https://tinyurl.com/2p8e4z66"),
        Ingredient(name: "Coconut oil", points: 0, image: "https://tinyurl.com/4z2u26ns"),
        Ingredient(name: "Coconut milk", points: 0, image: "https://tinyurl.com/kj6kn7zs"),
        Ingredient(name: "Coconut flour", points: 1, image: "https://tinyurl.com/y2syupdj"),
        Ingredient(name: "Cocoa Puffs", points: 0, image: "https://tinyurl.com/4raruzpe"),
        Ingredient(name: "Cocktail sauce", points: -1, image: "https://tinyurl.com/2nh5c7bu"),
        Ingredient(name: "Clams", points: 1, image: "https://tinyurl.com/5n8utb3v"),
        Ingredient(name: "Cinnamon sugar", points: 0, image: "https://tinyurl.com/mr8d8pbf"),
        Ingredient(name: "Cinnamon", points: 1, image: "https://tinyurl.com/yc2csp9t"),
        Ingredient(name: "Cilantro", points: 1, image: "https://tinyurl.com/r7x2knvc"),
        Ingredient(name: "Chocolate syrup", points: -1, image: "https://tinyurl.com/5dyuckpe"),
        Ingredient(name: "Chocolate-coated candies", points: -1, image: "https://tinyurl.com/3tdpkxre"),
        Ingredient(name: "Chocolate chips", points: 0, image: "https://tinyurl.com/yj6kat58"),
        Ingredient(name: "Chocolate bars", points: -1, image: "https://tinyurl.com/yyv3hav4"),
        Ingredient(name: "Chives", points: 1, image: "https://tinyurl.com/mstk6and"),
        Ingredient(name: "Chickpea flour", points: -1, image: "https://tinyurl.com/3k6xavte"),
        Ingredient(name: "Chickpeas", points: 1, image: "https://tinyurl.com/yprsedrs"),
        Ingredient(name: "Chicken wings", points: 0, image: "https://tinyurl.com/4ewap968"),
        Ingredient(name: "Chicken thighs", points: 0, image: "https://tinyurl.com/35taxu67"),
        Ingredient(name: "Chicken nuggets", points: -1, image: "https://tinyurl.com/4fkyz8b4"),
        Ingredient(name: "Chicken breasts", points: 0, image: "https://tinyurl.com/3bk9c2vd"),
        Ingredient(name: "Chia seeds", points: 1, image: "https://tinyurl.com/3b6vastd"),
        Ingredient(name: "Chex Mix", points: 0, image: "https://tinyurl.com/4vcuyezn"),
        Ingredient(name: "Chervil", points: 1, image: "https://tinyurl.com/5n8tds5r"),
        Ingredient(name: "Cheez-Its", points: 0, image: "https://tinyurl.com/yc455653"),
        Ingredient(name: "Cheese whiz", points: -1, image: "https://tinyurl.com/mw6esjjc"),
        Ingredient(name: "Cheese spread", points: -1, image: "https://tinyurl.com/4rmjsnnz"),
        Ingredient(name: "Cheese puffs", points: -1, image: "https://tinyurl.com/3und4xsk"),
        Ingredient(name: "Cheese-flavored snacks", points: -1, image: "https://tinyurl.com/mrx4cyz5"),
        Ingredient(name: "Cheese-flavored popcorn", points: -1, image: "https://tinyurl.com/ynsvcth8"),
        Ingredient(name: "Cheese curls", points: -1, image: "https://tinyurl.com/4a9h4huf"),
        Ingredient(name: "Cheese balls", points: -1, image: "https://tinyurl.com/ycyzxwwt"),
        Ingredient(name: "Cheddar cheese", points: 0, image: "https://tinyurl.com/wnncc92m"),
        Ingredient(name: "Chard", points: 1, image: "https://tinyurl.com/2p2m6859"),
        Ingredient(name: "Celery root", points: 1, image: "https://tinyurl.com/2p89zt5p"),
        Ingredient(name: "Celery", points: 1, image: "https://tinyurl.com/224ccxsv"),
        Ingredient(name: "Celeriac", points: 1, image: "https://tinyurl.com/zz86es9a"),
        Ingredient(name: "Cayenne pepper", points: 0, image: "https://tinyurl.com/5jd649jk"),
        Ingredient(name: "Cauliflower", points: 1, image: "https://tinyurl.com/5n8p4yj5"),
        Ingredient(name: "Cashew butter", points: 1, image: "https://tinyurl.com/dpzkymw2"),
        Ingredient(name: "Cashews", points: 1, image: "https://tinyurl.com/mu3rn6v2"),
        Ingredient(name: "Carrots", points: 1, image: "https://tinyurl.com/5byvppp9"),
        Ingredient(name: "Cardamon", points: 1, image: "https://tinyurl.com/3kpn5pb9"),
        Ingredient(name: "Caramel", points: -1, image: "https://tinyurl.com/yc4tjch7"),
        Ingredient(name: "Cap’n Crunch", points: 0, image: "https://tinyurl.com/yjjsub5a"),
        Ingredient(name: "Capers", points: 1, image: "https://tinyurl.com/murajs9t"),
        Ingredient(name: "Cantaloupe", points: 1, image: "https://tinyurl.com/ymp68dzf"),
        Ingredient(name: "Canned Vienna sausages", points: -1, image: "https://tinyurl.com/mv6cu6nb"),
        Ingredient(name: "Canned tuna", points: 0, image: "https://tinyurl.com/yktr6xab"),
        Ingredient(name: "Canned spaghetti", points: -1, image: "https://tinyurl.com/jb9de3v9"),
        Ingredient(name: "Canned soups", points: -1, image: "https://tinyurl.com/5yb8yxte"),
        Ingredient(name: "Canned ravioli", points: -1, image: "https://tinyurl.com/wauxra3h"),
        Ingredient(name: "Canned processed meats", points: -1, image: "https://tinyurl.com/3d53vpcr"),
        Ingredient(name: "Canned pasta", points: -1, image: "https://tinyurl.com/44c2jy5t"),
        Ingredient(name: "Canned meatballs", points: -1, image: "https://tinyurl.com/vbn5zvkw"),
        Ingredient(name: "Canned creamy soups", points: -1, image: "https://tinyurl.com/ycyfttbr"),
        Ingredient(name: "Canned chilli", points: -1, image: "https://tinyurl.com/56skvt6p"),
        Ingredient(name: "Candy bars", points: -1, image: "https://tinyurl.com/4yxafx8j"),
        Ingredient(name: "Cakes", points: -1, image: "https://tinyurl.com/469jm8ap"),
        Ingredient(name: "Cactus", points: 1, image: "https://tinyurl.com/39zruzpz"),
        Ingredient(name: "Cacao powder", points: 1, image: "https://tinyurl.com/4wzmn633"),
        Ingredient(name: "Cacao nibs", points: 1, image: "https://tinyurl.com/3n6r2vks"),
        Ingredient(name: "Cabbage", points: 1, image: "https://tinyurl.com/jhaevzps"),
        Ingredient(name: "Butternut squash", points: 1, image: "https://tinyurl.com/44yr7whm"),
        Ingredient(name: "Buttermilk", points: 1, image: "https://tinyurl.com/mpv7x5bz"),
        Ingredient(name: "Burrito", points: -1, image: "https://tinyurl.com/3pr8swkc"),
        Ingredient(name: "Burgers", points: -1, image: "https://tinyurl.com/yc34sa2e"),
        Ingredient(name: "Bulgur", points: 1, image: "https://tinyurl.com/5n8pdpan"),
        Ingredient(name: "Buckwheat", points: 1, image: "https://tinyurl.com/5x4ybjd9"),
        Ingredient(name: "Brussels sprouts", points: 1, image: "https://tinyurl.com/y4xhuxk8"),
        Ingredient(name: "Brown sugar", points: 0, image: "https://tinyurl.com/chfd5f7p"),
        Ingredient(name: "Brown rice syrup", points: 0, image: "https://tinyurl.com/5n9bduux"),
        Ingredient(name: "Brown rice", points: 1, image: "")
    ] {
        didSet {
            save()
        }
    }

    @Published var presetIngredientsSearchTerm = ""

    var presetIngredientsFiltered: Binding<[Ingredient]> {
        Binding (
            get: {
                if self.presetIngredientsSearchTerm == "" { return self.presetIngredients }
                return self.presetIngredients.filter {
                    $0.name.lowercased().contains(self.presetIngredientsSearchTerm.lowercased())
                }
            },
            set: {
                self.presetIngredients = $0
            }
        )
    }

    
        
    init() {
        presetIngredients.sort(by: { $0.name < $1.name })
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "ingredients.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedSelectedIngredients = try? propertyListEncoder.encode(selectedIngredients)
        try? encodedSelectedIngredients?.write(to: archiveURL, options: .noFileProtection)

    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedIngredientData = try? Data(contentsOf: archiveURL),
            let ingredientsDecoded = try? propertyListDecoder.decode([Ingredient].self, from: retrievedIngredientData) {
            selectedIngredients = ingredientsDecoded
        }
    }
}
