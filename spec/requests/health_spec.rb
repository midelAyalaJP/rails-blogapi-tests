require "rails_helper"

RSpec.describe "Health endpoint", type: :request do
    
    #prueba
    describe "GET /health" do
        #antes de cada prueba
        before { get '/health'}

        it "Should return OK" do
            #dentro de "response" está la respuesta al endpoint
            payload = JSON.parse(response.body);
            expect(payload).not_to be_empty;
            expect(payload['api']).to eq('OK');
            
        end

        #que la prueba sea 200
        it "Should return status code 200" do
            expect(response).to have_http_status(200);
        end
    end
end