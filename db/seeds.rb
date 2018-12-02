
m = Merchant.create(
  name: Faker::HeyArnold.character
)
10.times do 
  Item.create(
    name: Faker::Commerce.product_name,
    description: Faker::ChuckNorris.fact, merchant_id: 1
  )
end