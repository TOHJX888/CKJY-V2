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

    // MARK: Recipe Ingredients
    
    @Published var recipeIngredients: [RecipeIngredient] = [] {
        didSet {
            recipeIngredients.sort(by: { $0.ingredient.name < $1.ingredient.name })
            save()
        }
    }

    @Published var searchTerm2 = ""

    var recipesIngredientsFiltered: Binding<[RecipeIngredient]> {
        Binding (
            get: {
                if self.searchTerm2 == "" { return self.recipeIngredients }
                return self.recipeIngredients.filter {
                    $0.ingredient.name.lowercased().contains(self.searchTerm2.lowercased())
                }
            },
            set: {
                self.recipeIngredients = $0
            }
        )
    }
    
    // MARK: Preset Ingredients

    @Published var presetIngredients: [Ingredient] = [
        Ingredient(name: "Zucchini", points: 1),
        Ingredient(name: "Yellow squash", points: 0),
        Ingredient(name: "Yellow onions", points: 0),
        Ingredient(name: "yellow mustard", points: 0),
        Ingredient(name: "Worcestershire sauce", points: 0),
        Ingredient(name: "Whole wheat pasta ", points: 0),
        Ingredient(name: "Whole wheat flour", points: 1),
        Ingredient(name: "Whole wheat bread", points: 0),
        Ingredient(name: "Whole grain cereal", points: 0),
        Ingredient(name: "White wine vinegar ", points: 0),
        Ingredient(name: "White wine", points: 0),
        Ingredient(name: "White vinegar", points: 0),
        Ingredient(name: "White sugar", points: 0),
        Ingredient(name: "White rice", points: 0),
        Ingredient(name: "White potatoes", points: 0),
        Ingredient(name: "White pepper", points: 0),
        Ingredient(name: "White onions", points: 0),
        Ingredient(name: "White mushrooms", points: 0),
        Ingredient(name: "White chocolate chips", points: 0),
        Ingredient(name: "White chocolate", points: 0),
        Ingredient(name: "White cheddar cheese", points: 0),
        Ingredient(name: "White bread", points: 0),
        Ingredient(name: "White beans", points: 0),
        Ingredient(name: "White balsamic vinegar", points: 1),
        Ingredient(name: "Wheat thins", points: 0),
        Ingredient(name: "Wheat flour", points: 0),
        Ingredient(name: "Watermelon radish", points: 1),
        Ingredient(name: "Watermelon", points: 1),
        Ingredient(name: "Watercress", points: 1),
        Ingredient(name: "Wasabi", points: 1),
        Ingredient(name: "Walnuts", points: 0),
        Ingredient(name: "Vanilla extract", points: 0),
        Ingredient(name: "Vanilla", points: 1),
        Ingredient(name: "Udon noodles", points: 1),
        Ingredient(name: "Twizzlers", points: 0),
        Ingredient(name: "Twix", points: 0),
        Ingredient(name: "Turnips", points: 1),
        Ingredient(name: "Turmeric root", points: 1),
        Ingredient(name: "Turmeric powder", points: 1),
        Ingredient(name: "Turmeric", points: 1),
        Ingredient(name: "Turkey sausage", points: 0),
        Ingredient(name: "Turkey burgers", points: 0),
        Ingredient(name: "Turkey Breasts", points: 0),
        Ingredient(name: "Turkey bacon", points: 0),
        Ingredient(name: "Tuna", points: 1),
        Ingredient(name: "Truffle oil", points: 1),
        Ingredient(name: " Triscuits", points: 0),
        Ingredient(name: "Tortilla chips", points: -1),
        Ingredient(name: "Tomato sauce", points: 0),
        Ingredient(name: "Tomato paste", points: 0),
        Ingredient(name: "Tomatoes", points:1),
        Ingredient(name: "Tomatillos", points: 1),
        Ingredient(name: "Tofu", points: 1),
        Ingredient(name: "Toffee", points: -1),
        Ingredient(name: "Tilapia", points: 0),
        Ingredient(name: "Teriyaki sauce", points: 0),
        Ingredient(name: "Tempeh", points: 1),
        Ingredient(name: "Teddy Grahams", points: 0),
        Ingredient(name: "TarTar sauce", points: -1),
        Ingredient(name: "Tarragon", points: 1),
        Ingredient(name: "Tapioca pudding", points: 0),
        Ingredient(name: "Tangelo", points: 1),
        Ingredient(name: "Taco", points: -1),
        Ingredient(name: "Swiss chard", points: 1),
        Ingredient(name: "Sweetened sunflower milk", points: -1),
        Ingredient(name: "Sweetened soy milk", points: -1),
        Ingredient(name: "Sweetened rice milk", points: -1),
        Ingredient(name: "Sweetened oat milk", points: -1),
        Ingredient(name: "Sweetened hemp milk", points: -1),
        Ingredient(name: "Sweetened condensed milk", points: -1),
        Ingredient(name: "Sweetened coconut milk", points: -1),
        Ingredient(name: "Sweetened cashew milk", points: -1),
        Ingredient(name: "Sweetened almond milk", points: -1),
        Ingredient(name: "Sweet potato fries", points: -1),
        Ingredient(name: "Sweet potatoes", points: 1),
        Ingredient(name: "Sweet peppers", points: 0),
        Ingredient(name: "Sweet onion", points: 1),
        Ingredient(name: "Sweet corn", points: 0),
        Ingredient(name: "Swedish fish", points: 0),
        Ingredient(name: "Sunflower seeds", points: 1),
        Ingredient(name: "Sunflower oil", points: 0),
        Ingredient(name: "Sun-dried tomatoes", points: 1),
        Ingredient(name: "Sunchokes", points: 1),
        Ingredient(name: "Sucralose", points: -1),
        Ingredient(name: "Strawberries", points: 1),
        Ingredient(name: "Star fruit", points: 1),
        Ingredient(name: "Starbursts", points: 0),
        Ingredient(name: "Star anise", points: 1),
        Ingredient(name: "Spinach", points: 1),
        Ingredient(name: "Spaghetti", points: 0),
        Ingredient(name: "Soy sauce", points: 0),
        Ingredient(name: "Soy milk", points: 0),
        Ingredient(name: "Soursop", points: 1),
        Ingredient(name: "Sour Patch Kids", points: 0),
        Ingredient(name: "Sourdough bread", points: 0),
        Ingredient(name: "Sour cream", points: 0),
        Ingredient(name: "Sorrel", points: 1),
        Ingredient(name: "Sorghum", points: 1),
        Ingredient(name: "Sodium benzoate", points: -1),
        Ingredient(name: "Sodium Aluminium Sulfate", points: -1),
        Ingredient(name: "Sodas", points: -1),
        Ingredient(name: "Soba noodles", points: 1),
        Ingredient(name: "Snickers", points: 0),
        Ingredient(name: "Skittles", points: 0),
        Ingredient(name: "Shrimp", points: 0),
        Ingredient(name: "Shallots", points: 1),
        Ingredient(name: "Sesame seeds", points: 1),
        Ingredient(name: "Sesame oil", points: 1),
        Ingredient(name: "Seaweed", points: 1),
        Ingredient(name: "Scallions", points: 0),
        Ingredient(name: "Sausage rolls", points: 0),
        Ingredient(name: "Sausages", points: 0),
        Ingredient(name: "Sardines", points: 1),
        Ingredient(name: "Saltines", points: 0),
        Ingredient(name: "Salsify", points: 1),
        Ingredient(name: "Salmon", points: 1),
        Ingredient(name: "Sage", points: 1),
        Ingredient(name: "Saffron", points: 1),
        Ingredient(name: "Saccharin", points: -1),
        Ingredient(name: "Rutabaga", points: 1),
        Ingredient(name: "Romanesco", points: 1),
        Ingredient(name: "Romaine lettuce", points: 1),
        Ingredient(name: "Ritz crackers", points: 0),
        Ingredient(name: "Ricotta cheese", points: 0),
        Ingredient(name: "Rice vinegar", points: 0),
        Ingredient(name: "Rice pudding", points: 0),
        Ingredient(name: "Rice noodles", points: 0),
        Ingredient(name: "Rice Krispie treats", points: 0),
        Ingredient(name: "Rice Krispies", points: 0),
        Ingredient(name: "Rice flour", points: 0),
        Ingredient(name: "Rice cereal", points: 0),
        Ingredient(name: "Rice cakes", points: 0),
        Ingredient(name: "Rice bran oil", points: 1),
        Ingredient(name: "Reese’s Pieces", points: 0),
        Ingredient(name: "Red wine vinegar", points: 0),
        Ingredient(name: "Red wine", points: 0),
        Ingredient(name: "Red snapper", points: 1),
        Ingredient(name: "Red quinoa", points: 1),
        Ingredient(name: "Red potatoes", points: 0),
        Ingredient(name: "Red pepper flakes", points: 0),
        Ingredient(name: "Red peppers", points: 1),
        Ingredient(name: "Red lentils", points: 1),
        Ingredient(name: "Red cabbage", points: 1),
        Ingredient(name: "Red bell peppers", points: 0),
        Ingredient(name: "Raspberry vinegar", points: 0),
        Ingredient(name: "Raspberry jam", points: 0),
        Ingredient(name: "Raspberries", points: 1),
        Ingredient(name: "Ranch dressing", points: 0),
        Ingredient(name: "Ramen noodles", points: 0),
        Ingredient(name: "Raisin bran", points: 0),
        Ingredient(name: "Raisins", points: 0),
        Ingredient(name: "Radishes", points: 1),
        Ingredient(name: "Radicchio", points: 0),
        Ingredient(name: "Quinoa", points: 1),
        Ingredient(name: "Quince", points: 1),
        Ingredient(name: "Quark cheese", points: 1),
        Ingredient(name: "Quail eggs", points: 1),
        Ingredient(name: "Pumpkin seeds", points: 1),
        Ingredient(name: "Pumpkin oil", points: 1),
        Ingredient(name: "Pumpkin", points: 1),
        Ingredient(name: "Pudding cups", points: 0),
        Ingredient(name: "Prunes", points: 1),
        Ingredient(name: "Processed cheese", points: -1),
        Ingredient(name: "Pringles", points: 0),
        Ingredient(name: "Pretzels", points: 0),
        Ingredient(name: "Potato skins", points: 0),
        Ingredient(name: "Potato salad", points: 0),
        Ingredient(name: "Potato chips", points: -1),
        Ingredient(name: "Potatoes", points: 1),
        Ingredient(name: "Potassium sorbate", points: -1),
        Ingredient(name: "Pork tenderloin", points: 0),
        Ingredient(name: "Pork ribs", points: 0),
        Ingredient(name: "Pork chops", points: 0),
        Ingredient(name: "Pop tarts", points: -1),
        Ingredient(name: "Popcorn", points: 0),
        Ingredient(name: "Pomegranate seeds", points: 1),
        Ingredient(name: "Pomegranate molasses", points: 1),
        Ingredient(name: "Plums", points: 1),
        Ingredient(name: "Plantains", points: 1),
        Ingredient(name: "Plain flour", points: 0),
        Ingredient(name: "Pizza rolls", points: 0),
        Ingredient(name: "Pizza", points: -1),
        Ingredient(name: "Pistachio oil", points: 1),
        Ingredient(name: "Pistachio", points: 1),
        Ingredient(name: "Pinto beans", points: 1),
        Ingredient(name: "Pink grapefruit", points: 1),
        Ingredient(name: "Pine nuts", points: 1),
        Ingredient(name: "Pineapple juice", points: 0),
        Ingredient(name: "Pineapple", points: 1),
        Ingredient(name: "Pies", points: -1),
        Ingredient(name: "Persimmons", points: 1),
        Ingredient(name: "Pecan pie", points: 0),
        Ingredient(name: "Pecans", points: 1),
        Ingredient(name: "Pears", points: 1),
        Ingredient(name: "Peas", points: 1),
        Ingredient(name: "Pasta", points: 0),
        Ingredient(name: "Passion fruit", points: 1),
        Ingredient(name: "Parsley", points: 0),
        Ingredient(name: "Parmesan cheese", points: 0),
        Ingredient(name: "Paprika", points: 1),
        Ingredient(name: "Pappardelle", points: 1),
        Ingredient(name: "Papaya", points: 1),
        Ingredient(name: "Pancake syrup", points: -1),
        Ingredient(name: "Palm oil", points: -1),
        Ingredient(name: "Oregano", points: 0),
        Ingredient(name: "Orange juice", points: 1),
        Ingredient(name: "Oranges", points: 1),
        Ingredient(name: "Onion powder", points: 0),
        Ingredient(name: "Onions", points: 1),
        Ingredient(name: "Olive oil", points: 1),
        Ingredient(name: "Olestra", points: -1),
        Ingredient(name: "Okra", points: 1),
        Ingredient(name: "Oats", points: 1),
        Ingredient(name: "Nutritional yeast", points: 1),
        Ingredient(name: "Nutmeg", points: 0),
        Ingredient(name: "Nutella", points: 0),
        Ingredient(name: "Nori", points: 1),
        Ingredient(name: "Navy beans", points: 1),
        Ingredient(name: "Napa cabbage", points: 1),
        Ingredient(name: "M&M’s", points: 0),
        Ingredient(name: "Mustard greens", points: 1),
        Ingredient(name: "Mustard", points: 0),
        Ingredient(name: "Mushrooms", points: 1),
        Ingredient(name: "Mung beans", points: 1),
        Ingredient(name: "Mulberries", points: 1),
        Ingredient(name: "Mozzarella sticks", points: -1),
        Ingredient(name: "Mozzarella cheese", points: 0),
        Ingredient(name: "Miso", points: 1),
        Ingredient(name: "Millet", points: 1),
        Ingredient(name: "Milky Way", points: 0),
        Ingredient(name: "Milkshakes", points: -1),
        Ingredient(name: "Mayonnaise", points: -1),
        Ingredient(name: "Marshmallow fluff", points: 0),
        Ingredient(name: "Marshmallows", points: 0),
        Ingredient(name: "Margarine", points: -1),
        Ingredient(name: "Maple syrup", points: 0),
        Ingredient(name: "Mango", points: 1),
        Ingredient(name: "Mache", points: 1),
        Ingredient(name: "Lychee", points: 1),
        Ingredient(name: "Lucky Charms", points: 0),
        Ingredient(name: "Loquats", points: 1),
        Ingredient(name: "Limes", points: 1),
        Ingredient(name: "Licorice", points: -1),
        Ingredient(name: "Lettuce", points: 0),
        Ingredient(name: "Lentils", points: 1),
        Ingredient(name: "Lemongrass", points: 1),
        Ingredient(name: "Lemonade with added sugar", points: -1),
        Ingredient(name: "Lemonade", points: 0),
        Ingredient(name: "Leeks", points: 1),
        Ingredient(name: "Lavender", points: 1),
        Ingredient(name: "Lard", points: -1),
        Ingredient(name: "Kohlrabi", points: 1),
        Ingredient(name: "Kix cereal", points: 0),
        Ingredient(name: "Kiwi berries", points: 1),
        Ingredient(name: "Kiwi", points: 1),
        Ingredient(name: "Kit Kat", points: 0),
        Ingredient(name: "Kidney beans", points: 1),
        Ingredient(name: "Ketchup", points: 0),
        Ingredient(name: "Kelp", points: 1),
        Ingredient(name: "Kamut", points: 1),
        Ingredient(name: "Kale", points: 1),
        Ingredient(name: "Jicama", points: 1),
        Ingredient(name: "Jelly beans", points: -1),
        Ingredient(name: "Jasmine rice", points: 0),
        Ingredient(name: "Jams", points: 0),
        Ingredient(name: "Jalapenos", points: 1),
        Ingredient(name: "Jaggery", points: 1),
        Ingredient(name: "Instant rice with seasoning packets", points: -1),
        Ingredient(name: "Instant ramen noodles", points: -1),
        Ingredient(name: "Instant noodles", points: -1),
        Ingredient(name: "Instant mashed potato flakes", points: -1),
        Ingredient(name: "Instant mashed potatoes", points: -1),
        Ingredient(name: "Instant gravy mix", points: -1),
        Ingredient(name: "Iced teas with added sugar", points: -1),
        Ingredient(name: "Ice cream cones", points: 0),
        Ingredient(name: "Ice cream", points: -1),
        Ingredient(name: "Iceberg lettuce", points: 0),
        Ingredient(name: "Hydrogenated oils", points: -1),
        Ingredient(name: "Huckleberries", points: 1),
        Ingredient(name: "Hot sauce", points: 0),
        Ingredient(name: "Hot dogs", points: -1),
        Ingredient(name: "Horseradish", points: 0),
        Ingredient(name: "Honeydew melon", points: 1),
        Ingredient(name: "Honeycomb cereal", points: 0),
        Ingredient(name: "Honey Bunches of Oats", points: 0),
        Ingredient(name: "Honey", points: 0),
        Ingredient(name: "Hershey", points: 0),
        Ingredient(name: "Herring", points: 1),
        Ingredient(name: "Hemp seeds", points: 1),
        Ingredient(name: "Hearts of palm", points: 1),
        Ingredient(name: "Hazelnut oil", points: 1),
        Ingredient(name: "Hazelnuts", points: 1),
        Ingredient(name: "Hash browns with added preservatives", points: -1),
        Ingredient(name: "Hard candies", points: -1),
        Ingredient(name: "Hamburger Helper", points: -1),
        Ingredient(name: "Gummy worms", points: 0),
        Ingredient(name: "Gummy candies", points: -1),
        Ingredient(name: "Gummy bears", points: 0),
        Ingredient(name: "Guava", points: 1),
        Ingredient(name: "Ground venison", points: 0),
        Ingredient(name: "Ground veal", points: 0),
        Ingredient(name: "Ground turkey", points: 0),
        Ingredient(name: "Ground rabbit", points: 0),
        Ingredient(name: "Ground pork", points: 0),
        Ingredient(name: "Ground ostrich", points: 0),
        Ingredient(name: "Ground lamb", points: 0),
        Ingredient(name: "Ground chicken", points: 0),
        Ingredient(name: "Ground buffalo", points: 0),
        Ingredient(name: "Ground bison", points: 0),
        Ingredient(name: "Ground beef", points: 0),
        Ingredient(name: "Green tea", points: 1),
        Ingredient(name: "Green peas", points: 1),
        Ingredient(name: "Green onions", points: 1),
        Ingredient(name: "Green olives", points: 0),
        Ingredient(name: "Green lentils", points: 0),
        Ingredient(name: "Green cabbage", points: 0),
        Ingredient(name: "Green bell peppers", points: 1),
        Ingredient(name: "Green beans", points: 1),
        Ingredient(name: "Green yogurt", points: 1),
        Ingredient(name: "Green olives", points: 1),
        Ingredient(name: "Grape juice", points: 0),
        Ingredient(name: "Grapefruit", points: 1),
        Ingredient(name: "Granola", points: 0),
        Ingredient(name: "Graham crackers", points: 0),
        Ingredient(name: "Gouda cheese", points: 0),
        Ingredient(name: "Goldfish crackers", points: 0),
        Ingredient(name: "Gingersnaps", points: 0),
        Ingredient(name: "Ginger", points: 1),
        Ingredient(name: "Ghee", points: 1),
        Ingredient(name: "Garlic powder", points: 0),
        Ingredient(name: "Garlic", points: 0),
        Ingredient(name: "Garam masala", points: 1),
        Ingredient(name: "Fudges", points: -1),
        Ingredient(name: "Fruit snacks", points: 0),
        Ingredient(name: "Fruit roll-ups", points: -1),
        Ingredient(name: "Fruit loops", points: 0),
        Ingredient(name: "Fruit-flavored snacks", points: -1),
        Ingredient(name: "Frozen toaster pastries", points: -1),
        Ingredient(name: "Frozen tater tots", points: -1),
        Ingredient(name: "Frozen taquitos", points: -1),
        Ingredient(name: "Frozen sandwiches", points: -1),
        Ingredient(name: "Frozen pot pies", points: -1),
        Ingredient(name: "Frozen pizza", points: -1),
        Ingredient(name: "Frozen onion rings", points: -1),
        Ingredient(name: "Frozen fried foods", points: -1),
        Ingredient(name: "Frozen French fries", points: -1),
        Ingredient(name: "Frozen corndogs", points: -1),
        Ingredient(name: "Frozen chimichangas", points: -1),
        Ingredient(name: "Frozen burritos", points: -1),
        Ingredient(name: "Frozen breaded chicken nuggets", points: -1),
        Ingredient(name: "Flour tortillas", points: 0),
        Ingredient(name: "Fries", points: -1),
        Ingredient(name: "Fried fish", points: -1),
        Ingredient(name: "Fried chicken", points: -1),
        Ingredient(name: "Flaxseed oil", points: 1),
        Ingredient(name: "Flaxseed meal", points: 1),
        Ingredient(name: "Flaxseeds", points: 1),
        Ingredient(name: "Flavored coffee creamer", points: -1),
        Ingredient(name: "Fish sticks", points: -1),
        Ingredient(name: "Fig vinegar", points: 1),
        Ingredient(name: "Fig Newtons", points: 0),
        Ingredient(name: "Figs", points: 1),
        Ingredient(name: "Fettuccine", points: 0),
        Ingredient(name: "Feta cheese", points: 1),
        Ingredient(name: "Fennel", points: 1),
        Ingredient(name: "Fava beans", points: 1),
        Ingredient(name: "Farro", points: 1),
        Ingredient(name: "Fajita seasoning", points: 0),
        Ingredient(name: "Enriched flour", points: -1),
        Ingredient(name: "Energy drinks", points: -1),
        Ingredient(name: "Endive", points: 1),
        Ingredient(name: "Emmer wheat", points: 1),
        Ingredient(name: "Elderberries", points: 1),
        Ingredient(name: "Eggs", points: 1),
        Ingredient(name: "Edamame", points: 1),
        Ingredient(name: "Durian", points: 1),
        Ingredient(name: "Dragon fruit", points: 1),
        Ingredient(name: "Donuts", points: -1),
        Ingredient(name: "Dill", points: 1),
        Ingredient(name: "Dijon mustard", points: 0),
        Ingredient(name: "Diet soda", points: -1),
        Ingredient(name: "Deli meats", points: -1),
        Ingredient(name: "Dates", points: 1),
        Ingredient(name: "Dark chocolate", points: 0),
        Ingredient(name: "Dark brown sugar", points: 0),
        Ingredient(name: "Dandelion greens", points: 1),
        Ingredient(name: "Daikon radish", points: 1),
        Ingredient(name: "Currants", points: 1),
        Ingredient(name: "Cumin", points: 1),
        Ingredient(name: "Cucumbers", points: 1),
        Ingredient(name: "Cranberry sauce", points: 0),
        Ingredient(name: "Cranberries", points: 1),
        Ingredient(name: "Cotton candy", points: -1),
        Ingredient(name: "Cottage cheese", points: 1),
        Ingredient(name:"Cotija cheese", points: 1),
        Ingredient(name: "Corn syrup", points: 0),
        Ingredient(name: "Cornstarch", points: 0),
        Ingredient(name: "Corn snacks", points: -1),
        Ingredient(name: "Corn oil", points: 0),
        Ingredient(name: "Cornmeal", points: 0),
        Ingredient(name: "Corn flakes", points: 0),
        Ingredient(name: "Corn dogs", points: 0),
        Ingredient(name: "Corn chips", points: 0),
        Ingredient(name: "Cornbread", points: 0),
        Ingredient(name: "Corn", points: 0),
        Ingredient(name: "Cookies", points: -1),
        Ingredient(name: "Concord grapes", points: 1),
        Ingredient(name: "Cola", points: 0),
        Ingredient(name: "Cod", points: 1),
        Ingredient(name: "Coconut water", points: 1),
        Ingredient(name: "Coconut oil", points: 0),
        Ingredient(name: "Coconut milk", points: 0),
        Ingredient(name: "Coconut flour", points: 1),
        Ingredient(name: "Cocoa Puffs", points: 0),
        Ingredient(name: "Cocktail sauce", points: -1),
        Ingredient(name: "Clams", points: 1),
        Ingredient(name: "Cinnamon sugar", points: 0),
        Ingredient(name: "Cinnamon", points: 1),
        Ingredient(name: "Cilantro", points: 1),
        Ingredient(name: "Chocolate syrup", points: -1),
        Ingredient(name: "Chocolate-coated candies", points: -1),
        Ingredient(name: "Chocolate chips", points: 0),
        Ingredient(name: "Chocolate bars", points: -1),
        Ingredient(name: "Chives", points: 1),
        Ingredient(name: "Chickpea flour", points: 1),
        Ingredient(name: "Chickpeas", points: 1),
        Ingredient(name: "Chicken wings", points: 0),
        Ingredient(name: "Chicken thighs", points: 0),
        Ingredient(name: "Chicken nuggets", points: -1),
        Ingredient(name: "Chicken breasts", points: 0),
        Ingredient(name: "Chia seeds", points: 1),
        Ingredient(name: "Chex Mix", points: 0),
        Ingredient(name: "Chervil", points: 1),
        Ingredient(name: "Cheez-Its", points: 0),
        Ingredient(name: "Cheese whiz", points: -1),
        Ingredient(name: "Cheese spread", points: -1),
        Ingredient(name: "Cheese puffs", points: -1),
        Ingredient(name: "Cheese-flavored snacks", points: -1),
        Ingredient(name: "Cheese-flavored popcorn", points: -1),
        Ingredient(name: "Cheese curls", points: -1),
        Ingredient(name: "Cheese balls", points: -1),
        Ingredient(name: "Cheddar cheese", points: 0),
        Ingredient(name: "Chard", points: 1),
        Ingredient(name: "Celery root", points: 1),
        Ingredient(name: "Celery", points: 1),
        Ingredient(name: "Celeriac", points: 1),
        Ingredient(name: "Cayenne pepper", points: 0),
        Ingredient(name: "Cauliflower", points: 1),
        Ingredient(name: "Cashew butter", points: 1),
        Ingredient(name: "Cashews", points: 1),
        Ingredient(name: "Carrots", points: 1),
        Ingredient(name: "Cardamon", points: 1),
        Ingredient(name: "Caramel", points: -1),
        Ingredient(name: "Cap’n Crunch", points: 0),
        Ingredient(name: "Capers", points: 1),
        Ingredient(name: "Cantaloupe", points: 1),
        Ingredient(name: "Canned Vienna sausages", points: -1),
        Ingredient(name: "Canned tuna", points: 0),
        Ingredient(name: "Canned spaghetti", points: -1),
        Ingredient(name: "Canned soups", points: -1),
        Ingredient(name: "Canned ravioli", points: -1),
        Ingredient(name: "Canned processed meats", points: -1),
        Ingredient(name: "Canned pasta", points: -1),
        Ingredient(name: "Canned meatballs", points: -1),
        Ingredient(name: "Canned creamy soups", points: -1),
        Ingredient(name: "Canned chilli", points: -1),
        Ingredient(name: "Candy bars", points: -1),
        Ingredient(name: "Cakes", points: -1),
        Ingredient(name: "Cactus", points: 1),
        Ingredient(name: "Cacao powder", points: 1),
        Ingredient(name: "Cacao nibs", points: 1),
        Ingredient(name: "Cabbage", points: 1),
        Ingredient(name: "Butternut squash", points: 1),
        Ingredient(name: "Buttermilk", points: 1),
        Ingredient(name: "Burrito", points: -1),
        Ingredient(name: "Burgers", points: -1),
        Ingredient(name: "Bulgur", points: 1),
        Ingredient(name: "Buckwheat", points: 1),
        Ingredient(name: "Brussels sprouts", points: 1),
        Ingredient(name: "Brown sugar", points: 0),
        Ingredient(name: "Brown rice vinegar", points: 1),
        Ingredient(name: "Brown rice syrup", points: 0),
        Ingredient(name: "Brown rice", points: 1),
        Ingredient(name: "Brown mustard", points: 0),
        Ingredient(name: "Brownies", points: -1),
        Ingredient(name: "Broccolini", points: 1),
        Ingredient(name: "Broccoli", points: 1),
        Ingredient(name: "Bread", points: -1),
        Ingredient(name: "Boxed scalloped potatoes", points: -1),
        Ingredient(name: "Boxed macaroni and cheese", points: -1),
        Ingredient(name: "Boxed au gratin potatoes", points: -1),
        Ingredient(name: "Bottled salad dressings", points: -1),
        Ingredient(name: "Bottled frappuccinos", points: -1),
        Ingredient(name: "Bok choy", points: 1),
        Ingredient(name: "Blue potatoes", points: 1),
        Ingredient(name: "Blue cheese", points: 0),
        Ingredient(name: "Blueberries", points: 1),
        Ingredient(name: "Blood oranges", points: 1),
        Ingredient(name: "Black truffle", points: 1),
        Ingredient(name: "Black sesame seeds", points: 1),
        Ingredient(name: "Black rice", points: 1),
        Ingredient(name: "Black pepper", points: 0),
        Ingredient(name: "Black olives", points: 0),
        Ingredient(name: "Black-eyed peas", points: 1),
        Ingredient(name: "Black currants", points: 1),
        Ingredient(name: "Black beans", points: 1),
        Ingredient(name: "BHT (Butylated hydroxytoluene)", points: -1),
        Ingredient(name: "BHA (Butylated hydroxyanisole)", points: -1),
        Ingredient(name: "Bell peppers", points: 0),
        Ingredient(name: "Beets", points: 1),
        Ingredient(name: "Beef sirloin", points: 0),
        Ingredient(name: "BBQ sauce", points: 0),
        Ingredient(name: "Basmati rice", points: 0),
        Ingredient(name: "Barley", points: 1),
        Ingredient(name: "Banana", points: 1),
        Ingredient(name: "Bamboo shoots", points: 1),
        Ingredient(name: "Balsamic vinegar", points: 0),
        Ingredient(name: "Baby spinach", points: 0),
        Ingredient(name: "Avocado oil", points: 1),
        Ingredient(name: "Avocado", points: 1),
        Ingredient(name: "Aspartame", points: -1),
        Ingredient(name: "Asparagus", points: 1),
        Ingredient(name: "Arugula", points: 1),
        Ingredient(name: "Artificial sweeteners", points: -1),
        Ingredient(name: "Artificial preservatives", points: -1),
        Ingredient(name: "Artificial food coloring", points: -1),
        Ingredient(name: "Artificial flavorings", points: -1),
        Ingredient(name: "Artichokes", points: 1),
        Ingredient(name: "Arrowroot", points: 1),
        Ingredient(name: "Apricot oil", points: 1),
        Ingredient(name: "Apricots", points: 1),
        Ingredient(name: "Applesauce", points: 1),
        Ingredient(name: "Apple juice", points: 0),
        Ingredient(name: "Apple cider vinegar", points: 0),
        Ingredient(name: "Apple cider", points: 0),
        Ingredient(name: "Apples", points: 1),
        Ingredient(name: "Animal crackers", points: 0),
        Ingredient(name: "Anchovy paste", points: 1),
        Ingredient(name: "Anchovies", points: 1),
        Ingredient(name: "Ancho chiles", points: 1),
        Ingredient(name: "Almond milk", points: 1),
        Ingredient(name: "Almond flour", points: 1),
        Ingredient(name: "Almond extract", points: 1),
        Ingredient(name: "Almond butter", points: 1),
        Ingredient(name: "Almonds", points: 1),
        Ingredient(name: "Agave syrup", points: -1),
        Ingredient(name: "Agave nectar", points: 0),
        Ingredient(name: "Acorn squash", points: 1),
        Ingredient(name: "Acesulfame potassium​", points: -1)
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
