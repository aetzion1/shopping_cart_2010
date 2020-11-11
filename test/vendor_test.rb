require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/'

class _CLASS < Minitest::Test
    def setup
        @vendor = Vendor.new("Rocky Mountain Fresh")
        @item1 = Item.new({name: 'Peach', price: "$0.75"})
        @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    end
    
    def test_it_exists_and_has_attributes
        assert_instance_of Vendor, @vendor
        assert_equals "Rocky Mountain Fresh", @vendor.name
        assert_equals ({}), @vendor.inventory
    end

    def test_check_stock
        assert_equal 0, @vendor,check_stock(@item1)
    end

    def test_stock
        @vendor.stock(@item1, 30)
        assert_equal ({@item1 => 30}), @vendor.inventory
        assert_equal 30, @vendor,check_stock(@item1)

        @vendor.stock(@item1, 25)
        assert_equal 55, @vendor,check_stock(@item1)
        
        @vendor.stock(@item2, 12)
        assert_equal ({@item1 => 55, @item2 => 12}), @vendor.inventory
    end

end