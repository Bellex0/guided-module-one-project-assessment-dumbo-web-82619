Customer.destroy_all
Product.destroy_all
Company.destroy_all
Trial.destroy_all

#customers
belle = Customer.create(name: "Belle", age: 27, location: "Brooklyn")
# yuki = Customer.create(name: "Yuki", age: 28, location: "Portland")
mason = Customer.create(name: "Mason", age: 35, location: "Los Angeles")

#companies
apple = Company.create(name: "Apple", category: "Electronics")
glamglow = Company.create(name: "Glam Glow", category: "Skincare")
dyson = Company.create(name: "Dyson", category: "Electronics")
dior = Company.create(name: "Dior", category: "Cosmetics")

#products of Apple
airpods = Product.create(name: "Air Pods", company_id: apple.id, category: "Electronics", rating: "❤️❤️❤️" )
iphone100 = Product.create(name: "iPhone 100", company_id: apple.id, category: "Electronics", rating: "❤️❤️❤️" )
ipad_pro = Product.create(name: "iPad Pro", company_id: apple.id, category: "Electronics", rating: "❤️❤️❤️❤️" )
macBook = Product.create(name: "MacBook", company_id: apple.id, category: "Electronics", rating: "❤️❤️❤️❤️" )
iwatch = Product.create(name: "iWatch", company_id: apple.id, category: "Electronics", rating: "❤️❤️❤️❤️" )

#products of Glam Glow
glamglow_mask = Product.create(name: "SuperMud Mask", company_id: glamglow.id, category: "Skincare", rating: "❤️❤️❤️❤️" )

#products of dyson
dyson_dryer = Product.create(name: "Supersonic hair dryer", company_id: dyson.id, category: "Haircare", rating: "❤️❤️❤️❤️" )
dyson_vacuum = Product.create(name: "V11 cord-free vacuum", company_id: dyson.id, category: "Appliance", rating: "❤️❤️❤️❤️" )

#products of dior
dior_mascara = Product.create(name: "Blackout mascara", company_id: dior.id, category: "Cosmestics", rating: "❤️❤️❤️❤️" )
dior_perfume = Product.create(name: "Addict perfume", company_id: dior.id, category: "Cosmestics", rating: "❤️❤️❤️" )

#Belle's trials
airpods_trial2 = Trial.create(customer_id: belle.id, product_id: airpods.id, date: "09/10/2019", review: "Not for me." )
macBook_trial = Trial.create(customer_id: belle.id, product_id: macBook.id, date: "09/10/2019", review: "Wish it was bigger." )
glamglow_mask_trial = Trial.create(customer_id: belle.id, product_id: glamglow_mask.id, date: "07/19/2019", review: "Love this!! My skin is so smooooooth!")
dior_mascara_trial = Trial.create(customer_id: belle.id, product_id: dior_mascara.id, date: "08/29/2019", review: "Must have in my collection! Works wonders!")

# dyson_dryer_trial = Trial.create(customer_id: yuki.id, product_id: dyson_dryer.id, date: "09/03/2019", review: "Dried my hair in 30 seconds! Amazing glowing,sleek hair!")
airpods_trial = Trial.create(customer_id: mason.id, product_id: airpods.id, date: "08/20/2019", review: "Fell out of my ears and dropped it in the subway tracks 😩" )
