require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "基本功能" do

    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      cart = Cart.new
      cart.add_item(1)
      expect(cart.empty?).to be false
    end

    it "加相同的商品，購買項目（CartItem）並不會增加，商品的數量會改變" do
      cart = Cart.new

      3.times { cart.add_item(1) }
      5.times { cart.add_item(2) }
      2.times { cart.add_item(1) }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 5
    end

    it "商品可以放到購物車裡，也可以再拿出來" do
      cart = Cart.new
      p1 = FactoryBot.create(:product)
      p2 = FactoryBot.create(:product)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.items.first.product.id).to be p1.id
      expect(cart.items.last.product.id).to be p2.id
    end

    it "每個 Cart Item 都可以計算它自己的金額（小計）" do
      cart = Cart.new
      p1 = FactoryBot.create(:product, price: 10)

      3.times { cart.add_item(p1.id) }

      expect(cart.items.first.total).to be 30
    end

    it "可以計算整台購物車的總消費金額" do
      cart = Cart.new
      p1 = FactoryBot.create(:product, price: 10)
      p2 = FactoryBot.create(:product, price: 20)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.total).to be 70
    end

    it "聖誕節全面 9 折" do
      t = Time.local(2008, 12, 25, 10, 5, 0)
      Timecop.travel(t)

      cart = Cart.new
      p1 = FactoryBot.create(:product, price: 10)
      p2 = FactoryBot.create(:product, price: 20)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.total).to eq 63
    end
  end

  describe "進階功能" do
    # - 可以將購物車內容轉換成 Hash 並存到 Session 裡。
    # - 也可以存放在 Session 的內容（Hash 格式），還原成購物車的內容。
  end
end
