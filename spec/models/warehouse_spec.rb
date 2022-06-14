require 'rails_helper'

describe 'Warehouse' do
  context '.all' do
    it 'deve retornar todos os galpões' do
      # Arrange
      json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
      fake_response = double("faraday_response", status: 200, body: json_data)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

      # Act
      result = Warehouse.all

      # Assert
      expect(result.length).to eq 2
      expect(result[0].name).to eq 'Aeroporto TESTE'
      expect(result[0].code).to eq 'TESTE'
      expect(result[0].city).to eq 'Cidade Teste'
      expect(result[0].area).to eq 100000
      expect(result[0].address).to eq 'Avenida Teste, 1000'
      expect(result[0].cep).to eq '15000-123'
      expect(result[0].description).to eq 'Galpão destinado para cargas teste'

      expect(result[1].name).to eq 'Segundo Aeroporto'
      expect(result[1].code).to eq 'SEGUNDO'
      expect(result[1].city).to eq 'Cidade 2'
      expect(result[1].area).to eq 200000
      expect(result[1].address).to eq 'Avenida Teste, 1000'
      expect(result[1].cep).to eq '26000-321'
      expect(result[1].description).to eq 'Segundo galpão de teste'

    end

    it "deve retornar vazio se a API está indisponível" do
      # Arrange
      fake_response = double("faraday_resp", status: 500, body: "{'error': 'Erro ao obter dados}")
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/warehouses').and_return(fake_response)

      # Act
      result = Warehouse.all

      # Assert
      expect(result).to eq []
    end
    
  end
end
