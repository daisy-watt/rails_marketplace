module ListingsHelper
    # def format_condition(condition)
    #     arr = condition.split("_").map do |word|
    #       word.capitalize
    #     end
    #     arr.join(" ")
    # end
    # taking out underscore and capitalizing first letter of word

    def format_price(price)
        "$#{price/ 100}"
    end 
end