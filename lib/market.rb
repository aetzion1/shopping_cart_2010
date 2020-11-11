class Market

    attr_reader :name, :vendors

    def initialize(name)
        @name = name
        @vendors = []
    end

    def add_vendor(vendor)
        @vendors << vendor
    end

    def vendor_names
        @vendors.map do |vendor|
            vendor.name
        end
    end

    def vendors_that_sell(item)
        @vendors.find_all do |vendor|
            vendor.inventory[item] > 0
        end
    end

    def sorted_item_list
        
        list = []
        @vendors.each do |vendor|
            vendor.inventory.each do |item|
                if item[1] > 0
                    list << item[0].name
                end
            end
        end
        list.sort.uniq
    end

end