class SubscriptionSerializer
    include JSONAPI::Serializer
    
    attributes :title, :price, :frequency, :status

    def self.format_recipe_details(recipe_details)
        {
            data: {
                id: recipe_details.id,
                type: "recipe",
                attributes: {
                    recipe_name: recipe_details.name,
                    total_price: recipe_details.total_price,
                    image: recipe_details.image,
                    serving_size: recipe_details.serving_size,
                    ingredients: recipe_details.ingredients,
                    cookwares: recipe_details.cookwares,
                    instructions: recipe_details.instructions,
                    cooking_tips: recipe_details.cooking_tips
                }
            }
        }
    end
end