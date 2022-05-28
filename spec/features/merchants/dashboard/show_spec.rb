require 'rails_helper'

RSpec.describe 'merchant dashboard show' do

  let!(:merchant1) { Merchant.create!(name: "Schroeder-Jerde") }
  let!(:merchant2) { Merchant.create!(name: "Klein, Rempel and Jones") }
  let!(:merchant3) { Merchant.create!(name: "Willms and Sons") }

  let!(:item1) { merchant1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti", unit_price: 75107) }
  let!(:item2) { merchant1.items.create!(name: "Autem Minima", description: "Cumque consequuntur ad", unit_price: 67076) }
  let!(:item3) { merchant2.items.create!(name: "Ea Voluptatum", description: "Sunt officia", unit_price: 68723) }
  let!(:item4) { merchant2.items.create!(name: "Nemo Facere", description: "Sunt eum id eius", unit_price: 15925) }
  let!(:item5) { merchant3.items.create!(name: "Expedita Aliquam", description: "Vol pt", unit_price: 31163) }

  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }
  let!(:customer3) { Customer.create!(first_name: "Heber", last_name: "Kuhn") }
  let!(:customer4) { Customer.create!(first_name: "Mariah", last_name: "Toy") }
  let!(:customer5) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer6) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }

  it "displays a merchant's name" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Schroeder-Jerde")
  end

  it "displays links to a merchant's items and invoices index pages" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Items Index")
    expect(page).to have_content("Invoices Index")
  end

# Merchant Dashboard Statistics - Favorite Customers
# As a merchant,
# When I visit my merchant dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions with my merchant
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant

  it "displays the largest number of successful transactions of top 5 customers" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content()
  end
end
