require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
    def setup
        @item1 = Item.new({name: 'Peach', price: "$0.75"})
        @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    end
    
    def test_it_exists_and_has_attributes
        assert_instance_of Item, @item1
        assert_equals "Tomato", @item2.name
        assert_equals 0.5, @item2.price
    end
end
