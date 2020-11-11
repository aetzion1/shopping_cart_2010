require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/market'
require './lib/vendor'
require './lib/item'

class MarketTest < Minitest::Test
    def setup
        @market = Market.new("South Pearl Street Farmers Market")
        @vendor1 = Vendor.new("Rocky Mountain Fresh")
        @vendor2 = Vendor.new("Ba-Nom-a-Nom")
        @vendor3 = Vendor.new("Palisade Peach Shack")
        @item1 = Item.new({name: 'Peach', price: "$0.75"})
        @item2 = Item.new({name: 'Tomato', price: "$0.50"})
        @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
        @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    end
    
    def test_it_exists_and_has_attributes
        assert_instance_of Market, @market
        assert_equal "South Pearl Street Farmers Market", @market.name
        assert_equal [], @market.vendors
    end

    def test_it_can_return_vendors_and_vendor_names
        @vendor1.stock(@item1, 35)
        @vendor1.stock(@item2, 7)
        @vendor2.stock(@item4, 50)
        @vendor2.stock(@item3, 25)
        @vendor3.stock(@item1, 65)
        @market.add_vendor(@vendor1)
        @market.add_vendor(@vendor2)
        @market.add_vendor(@vendor3)

        expected_1 = [@vendor1, @vendor2, @vendor3]
        expected_2 = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]

        assert_equal expected_1, @market.vendors
        assert_equal expetced_2, @market.vendor_names
    end

    def test_it_can_return_vendors_that_sell
        @vendor1.stock(@item1, 35)
        @vendor1.stock(@item2, 7)
        @vendor2.stock(@item4, 50)
        @vendor2.stock(@item3, 25)
        @vendor3.stock(@item1, 65)
        @market.add_vendor(@vendor1)
        @market.add_vendor(@vendor2)
        @market.add_vendor(@vendor3)

        expected_1 = [@vendor1, @vendor3]
        expected_2 = [@vendor2]

        assert_equal expected_1, @market.vendors_that_sell(@item1)
        assert_equal expected_1, @market.vendors_that_sell(@item4)
    end
end