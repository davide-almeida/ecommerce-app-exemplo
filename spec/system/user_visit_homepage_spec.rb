require 'rails_helper'

describe "Usuário visita tela inicial" do
  it "e vê galpoes" do
    # Arrange
    # json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    # fake_response = double("faraday_response", status: 200, body: json_data)
    # allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)
    warehouses = []
    warehouses << Warehouse.new(id: 1, name: "Aeroporto SP", code: "GRU", cep: "10000123", address:"Endereço do aeroporto de SP", city:"São Paulo", description:"Descrição teste", area:100000)
    allow(Warehouse).to receive(:all).and_return(warehouses)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'E-Commerce App'
    expect(page).to have_content 'Aeroporto SP'

  end

  it "e não existem galpoes" do
    # Arrange
    # json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double("faraday_response", status: 200, body: "[]")
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Nenhum galpão encontrado'

  end

  it "e vê detalhes de um galpão" do
    # Arrange
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double("faraday_response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)
    
    json_data = File.read(Rails.root.join('spec/support/json/warehouse.json'))
    fake_response = double("faraday_response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses/1').and_return(fake_response)

    # Act
    visit root_path
    click_on 'Aeroporto TESTE'

    # Assert
    expect(page).to have_content 'Aeroporto TESTE'

  end

  it "e não é possível carregar o galpão" do
    # Arrange
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double("faraday_response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)
    
    json_data = File.read(Rails.root.join('spec/support/json/warehouse.json'))
    error_response = double("faraday_response", status: 500, body: "{}")
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses/1').and_return(error_response)

    # Act
    visit root_path
    click_on 'Aeroporto TESTE'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Não foi possível carregar o galpão'

  end
end
