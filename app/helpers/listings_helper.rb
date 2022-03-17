module ListingsHelper
    # def format_condition(condition)
    #     arr = condition.split("_").map {|word| word.capitalize}.join(" ")
    # end

    # taking out underscore and capitalizing first letter of words

    def format_price(price)
        "$#{price/ 100}"
    end 
end
