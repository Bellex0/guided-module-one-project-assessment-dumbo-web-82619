Customer.destroy_all
Product.destroy_all
Company.destroy_all
Trial.destroy_all


belle = Customer.create(name: "Belle", age: 27, location: "Brooklyn")
yuki = Customer.create(name: "Yuki", age: 28, location: "Portland")
mason = Customer.create(name: "Mason", age: 35, location: "Los Angeles")

glamglow_mask = Product.create(name: "SuperMud Mask", brand: "Glam Glow", category: "skincare", rating: "❤️❤️❤️❤️" )
airpods = Product.create(name: "Air Pods", brand: "Apple", category: "electronics", rating: "❤️❤️❤️" )
dyson_dryer = Product.create(name: "Supersonic hair dryer", brand: "Dyson", category: "haircare", rating: "❤️❤️❤️❤️" )

apple = Company.create(name: "Apple", category: "electronics")
glamglow = Company.create(name: "Glam Glow", category: "skincare")
dyson = Company.create(name: "Dyson", category: "electronics")

airpods_trial = Trial.create(customer_id: mason.id, product_id: airpods.id, date: "08/20/2019", review: "Fell out of my ears and dropped it in the subway tracks 😩" )
glamglow_mask_trial = Trial.create(customer_id: belle.id, product_id: glamglow_mask.id, date: "07/19/2019", review: "Love this!! My skin is so smooooooth!")
dyson_dryer_trial = Trial.create(customer_id: yuki.id, product_id: dyson_dryer.id, date: "09/03/2019", review: "Dried my hair in 30 seconds! Amazing glowing,sleek hair!")