require 'rails_helper'

RSpec.describe "Incidents", :type => :request do
  let(:default_params) do
    {format: :json}
  end

  describe "GET /incidents" do
    it "returns incidents" do
      incident = create(:incident)
      get incidents_path, default_params
      expect(response.body).to be_json_as([{
        'id' => incident.id,
        'description' => incident.description,
        'provider' => {
          'id' => incident.provider.id,
          'name' => incident.provider.name,
          'kind' => incident.provider.kind,
          'created_at' => incident.provider.created_at.as_json,
          'updated_at' => incident.provider.updated_at.as_json,
          'details' => incident.provider.details,
        },
        'details' => incident.details,
        'url' => incident_url(incident, format: :json),
      }])
      expect(response.status).to be(200)
    end
  end

  describe "GET /incidents/1" do
    it "returns an incident" do
      incident = create(:incident)
      get incident_path(incident), default_params
      expect(response.body).to be_json_as({
        'id' => incident.id,
        'description' => incident.description,
        'provider' => {
          'id' => incident.provider.id,
          'name' => incident.provider.name,
          'kind' => incident.provider.kind,
          'created_at' => incident.provider.created_at.as_json,
          'updated_at' => incident.provider.updated_at.as_json,
          'details' => incident.provider.details,
        },
        'details' => incident.details,
        'created_at' => incident.created_at.as_json,
        'updated_at' => incident.updated_at.as_json,
      })
      expect(response.status).to be(200)
    end
  end

  describe "POST /incidents" do
    it "creates an incident" do
      provider = create(:provider)
      attributes = attributes_for(:incident).merge(provider_id: provider.id)
      post incidents_path, default_params.merge(incident: attributes)
      incidnet = Incident.last
      expect(incidnet.description).to eq(attributes[:description])
      expect(incidnet.provider.id).to eq(attributes[:provider_id])
      expect(incidnet.details).to eq(attributes[:details])
      expect(response.status).to be(201)
    end
  end
end
