require "rails_helper"

RSpec.describe "Post", type: :request do
    
    #prueba
    describe "GET /posts" do
        #antes de cada prueba
        # before {}

        it "Should return OK" do
            get '/posts'
            #dentro de "response" está la respuesta al endpoint
            payload = JSON.parse(response.body);
            expect(payload).to be_empty;
            expect(response).to have_http_status(200);
            
        end


        #busqueda de post
        describe "Search" do
            let!(:hola_mundo) {create(:published_post, title: 'hola mundo')}
            let!(:hola_rails) {create(:published_post, title: 'hola rails')}
            let!(:curso_rails) {create(:published_post, title: 'curso rails')}

            it "should filter post by title" do
                get "/posts?search=hola";

                payload = JSON.parse(response.body);
               
                expect(payload.size).to eq(2);
                expect(payload.map{|p| p["id"]}.sort).to eq([hola_mundo.id, hola_rails.id].sort);
                expect(response).to have_http_status(200);
            
            end
        end
      
    end

    describe "with data in DB" do
        #una variable que está disponible en las pruebas
        let!(:posts) { create_list(:post, 10, published: true)}
        

        it "should return all the published post" do
            get '/posts'

            
            payload = JSON.parse(response.body);


            expect(payload.size).to eq(posts.size);
            expect(response).to have_http_status(200);
        end
    end


    describe "GET /posts/{id}" do
        #una variable que está disponible en las pruebas
        let!(:post) { create(:post, published: true)}

        
        it "should return a post" do
            get "/posts/#{post.id}"
            payload = JSON.parse(response.body);


            expect(payload).to_not be_empty;
            expect(payload["id"]).to eq(post.id);
            expect(payload["title"]).to eq(post.title);
            expect(payload["content"]).to eq(post.content);
            expect(payload["published"]).to eq(post.published);
            expect(payload["author"]["name"]).to eq(post.user.name);
            expect(payload["author"]["email"]).to eq(post.user.email);
            expect(payload["author"]["id"]).to eq(post.user.id);
            expect(response).to have_http_status(200);
        end
    end


    # describe "POST /posts" do
    #     let!(:user) {create(:user)}
    #     it "Should create a post" do
    #         req_payload = {
    #             post:{
    #                 title: "titulo",
    #                 content: "contendiod",
    #                 published: false,
    #                 user_id: user.id
    #             }
    #         }

    #         post "/posts", params: req_payload

    #         payload = JSON.parse(response.body);
    #         expect(payload).to_not be_empty;
    #         expect(payload["id"]).to_not be_nil
    #         expect(response).to have_http_status(:created);
    #     end

    #     it "Should return error message on invalid post" do
    #         req_payload = {
    #             post:{
                    
    #                 content: "contendiod",
    #                 published: false,
    #                 user_id: user.id
    #             }
    #         }

    #         post "/posts", params: req_payload

    #         payload = JSON.parse(response.body);
    #         expect(payload).to_not be_empty;
    #         expect(payload["error"]).to_not be_empty
    #         expect(response).to have_http_status(:unprocessable_entity);
    #     end
    # end


    # describe "PUT /posts/{id}" do
    #     let!(:article) {create(:post)}

    #     it "Should create a post" do
    #         req_payload = {
    #             post:{
    #                 title: "titulo",
    #                 content: "contendiod",
    #                 published: true
    #             }
    #         }

    #         put "/posts/#{article.id}", params: req_payload

    #         payload = JSON.parse(response.body);
    #         expect(payload).to_not be_empty;
    #         expect(payload["id"]).to eq(article.id);
    #         expect(response).to have_http_status(:ok);
    #     end


    #     it "Should return error message on invalid post" do
    #         req_payload = {
    #             post:{
    #                 title: nil,
    #                 content: nil,
    #                 published: true
    #             }
    #         }

    #         put "/posts/#{article.id}", params: req_payload

    #         payload = JSON.parse(response.body);
    #         expect(payload).to_not be_empty;
    #         expect(payload["error"]).to_not be_empty
    #         expect(response).to have_http_status(:unprocessable_entity);
    #     end
    # end
end