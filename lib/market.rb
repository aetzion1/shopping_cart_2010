class Market

    attr_reader :name, :vendors, :date

    def initialize(name)
        @name = name
        @vendors = []
        @date = Date.today
    end

    def date
        @date.strftime("%m-%d-%Y")
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
        list = @vendors.map do |vendor|
            vendor.inventory.map do |item|
                item[0].name if item[1] > 0
            end
        end.flatten

        list.sort.uniq
    end

    def all_items
        items = @vendors.map do |vendor|
            vendor.inventory.map do |item|
                item[0] if item[1] > 0
            end
        end.flatten.uniq
    end
    
    def total_inventory
        total_inventory = {}
        all_items.each do |item|
            total_inventory[item] = {
                quantity: 0,
                vendors: []
            }
        end

        @vendors.each do |vendor|
            total_inventory.each do |item|
                item[1][:quantity] += vendor.check_stock(item[0])
            end
        end

        total_inventory.each do |item|
            item[1][:vendors] = vendors_that_sell(item[0])
        end
        total_inventory
    end

    def overstocked_items
        total_inventory.filter_map do |item| 
            item[0] if item[1][:quantity] > 50 && item[1][:vendors].count >1
        end
    end

end