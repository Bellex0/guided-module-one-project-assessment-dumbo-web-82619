Customer.destroy_all
Product.destroy_all
Company.destroy_all
Trial.destroy_all


belle = Customer.create(name: "Belle", age: 27, location: "Brooklyn")
yuki = Customer.create(name: "Yuki", age: 28, location: "Portland")
mason = Customer.create(name: "Mason", age: 35, location: "Los Angeles")

apple = Company.create(name: "Apple", category: "electronics")
glamglow = Company.create(name: "Glam Glow", category: "skincare")
dyson = Company.create(name: "Dyson", category: "electronics")
dior = Company.create(name: "Dior", category: "cosmetics")

glamglow_mask = Product.create(name: "SuperMud Mask", company_id: glamglow.id, category: "skincare", rating: "❤️❤️❤️❤️" )
airpods = Product.create(name: "Air Pods", company_id: apple.id, category: "electronics", rating: "❤️❤️❤️" )
iphone100 = Product.create(name: "Iphone 100", company_id: apple.id, category: "electronics", rating: "❤️❤️❤️" )
dyson_dryer = Product.create(name: "Supersonic hair dryer", company_id: dyson.id, category: "haircare", rating: "❤️❤️❤️❤️" )
dior_mascara = Product.create(name: "Blackout mascara", company_id: dior.id, category: "cosmestics", rating: "❤️❤️❤️❤️" )

airpods_trial = Trial.create(customer_id: mason.id, product_id: airpods.id, date: "08/20/2019", review: "Fell out of my ears and dropped it in the subway tracks 😩" )
airpods_trial2 = Trial.create(customer_id: yuki.id, product_id: airpods.id, date: "09/10/2019", review: "No comment." )
glamglow_mask_trial = Trial.create(customer_id: belle.id, product_id: glamglow_mask.id, date: "07/19/2019", review: "Love this!! My skin is so smooooooth!")
dyson_dryer_trial = Trial.create(customer_id: yuki.id, product_id: dyson_dryer.id, date: "09/03/2019", review: "Dried my hair in 30 seconds! Amazing glowing,sleek hair!")
dior_mascara_trial = Trial.create(customer_id: belle.id, product_id: dior_mascara.id, date: "08/29/2019", review: "Must have in my collection! Works wonders!")