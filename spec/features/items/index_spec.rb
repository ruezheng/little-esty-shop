require 'rails_helper'

RSpec.describe "Merchant Items Index Page" do

  let!(:merchant_1) { Merchant.create!(name: "REI") }
  let!(:merchant_2) { Merchant.create!(name: "Target") }

  let!(:item1) {merchant_1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135)}
  let!(:item2) {merchant_1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99)}
  let!(:item3) {merchant_1.items.create!(name: "Backpack", description: "Can carry all your things", unit_price: 99)}
  let!(:item4) {merchant_1.items.create!(name: "Socks", description: "Oooooh, wool", unit_price: 15)}
  let!(:item5) {merchant_1.items.create!(name: "Nalgene", description: "Put all your cool stickers here", unit_price: 12)}
  let!(:item6) {merchant_1.items.create!(name: "Fanny Pack", description: "Forget what the haters say, they're stylish", unit_price: 25)}
  let!(:item7) {merchant_1.items.create!(name: "Mountain Bike", description: "Shred the gnar!!", unit_price: 1199)}
  let!(:item8) {merchant_2.items.create!(name: "Conditioner", description: "Bye slit ends!", unit_price: 7)}

  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }
  let!(:customer3) { Customer.create!(first_name: "Heber", last_name: "Kuhn") }
  let!(:customer4) { Customer.create!(first_name: "Mariah", last_name: "Toy") }
  let!(:customer5) { Customer.create!(first_name: "Carl", last_name: "Junior") }
  let!(:customer6) { Customer.create!(first_name: "Tony", last_name: "Bologna") }

  let!(:invoice1) { customer1.invoices.create!(status: 2) }
  let!(:invoice2) { customer2.invoices.create!(status: 2) }
  let!(:invoice3) { customer3.invoices.create!(status: 2) }
  let!(:invoice4) { customer4.invoices.create!(status: 2) }
  let!(:invoice5) { customer5.invoices.create!(status: 2) }
  let!(:invoice6) { customer6.invoices.create!(status: 2) }

  let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 13635, status: "packaged") }
  let!(:invoice_item2) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 9, unit_price: 23324, status: "pending") }
  let!(:invoice_item3) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice3.id, quantity: 8, unit_price: 34873, status: "packaged") }
  let!(:invoice_item4) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice4.id, quantity: 1, unit_price: 2196, status: "packaged") }
  let!(:invoice_item5) { InvoiceItem.create!(item_id: item4.id, invoice_id: invoice5.id, quantity: 2, unit_price: 79140, status: "shipped") }
  let!(:invoice_item6) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice6.id, quantity: 3, unit_price: 52100, status: "packaged") }
  let!(:invoice_item7) { InvoiceItem.create!(item_id: item4.id, invoice_id: invoice6.id, quantity: 1, unit_price: 13635, status: "packaged") }
  let!(:invoice_item8) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, quantity: 2, unit_price: 23324, status: "pending") }
  let!(:invoice_item9) { InvoiceItem.create!(item_id: item6.id, invoice_id: invoice1.id, quantity: 4, unit_price: 34873, status: "packaged") }
  let!(:invoice_item10) { InvoiceItem.create!(item_id: item7.id, invoice_id: invoice4.id, quantity: 1, unit_price: 2196, status: "packaged") }

  let!(:transaction1) { Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "2/22", result: "success") }
  let!(:transaction2) { Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4580251236515201, credit_card_expiration_date: "1/22", result: "success") }
  let!(:transaction3) { Transaction.create!(invoice_id: invoice3.id, credit_card_number: 4354495077693036, credit_card_expiration_date: "10/22", result: "success") }
  let!(:transaction4) { Transaction.create!(invoice_id: invoice4.id, credit_card_number: 4515551623735607, credit_card_expiration_date: "4/25", result: "success") }
  let!(:transaction5) { Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4844518708741275, credit_card_expiration_date: "4/23", result: "success") }
  let!(:transaction6) { Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4203696133194408, credit_card_expiration_date: "5/22", result: "success") }
  let!(:transaction7) { Transaction.create!(invoice_id: invoice6.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "failed") }

  before do
    visit merchant_items_path(merchant_1)
  end

  it "displays only a specified merchant's items" do

    expect(page).to have_content("Boots")
    expect(page).to have_content("Tent")
    expect(page).to_not have_content("Conditioner")
  end

  it "can click a button to disable or enable a specific item" do
    within ".enabled-items" do
      expect(page).to_not have_content("Boots")
    end

    within ".disabled-items" do
      within "#item-#{item1.id}" do
        expect(page).to have_content("Boots")
        expect(page).to have_button("Enable")
        expect(page).to_not have_content("Tent")

        click_button "Enable"

      end
    end
    expect(current_path).to eq(merchant_items_path(merchant_1))

    within ".enabled-items" do
      within "#item-#{item1.id}" do
        expect(page).to have_content("Boots")
        expect(page).to have_button("Disable")

        click_button "Disable"
      end
    end
  end

  it "has a link to create a new item" do
    click_link "Create A New Item"

    expect(current_path).to eq(new_merchant_item_path(merchant_1))
  end

  xit "displays the top 5 most popular items ordered by total revenue" do
    within(".top_5") do

    end
  end

  xit "displays the total revenue next to the item" do
    within(".top_5") do

    end
  end

# Merchant Items Index: Top Item's Best Day

# Then next to each of the 5 most popular items I see the date with the most sales for each item.
# And I see a label “Top selling date for <item name> was <date with most sales>"
#
# Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.

  it "displays the top selling date next to an item" do
    within "#item-#{item2.id}" do
      expect(page).to have_content("01 Jun 2022")
    end
    
    expect(page).to have_content("Top selling date for Tent was 01 Jun 2022")
  end
end
