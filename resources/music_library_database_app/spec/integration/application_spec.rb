require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a><br />')
    end

  end

  context "POST /albums" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = post("/albums", title: "Voyage", release_year: "2022", artist_id: "2" )
    

      expect(response.status).to eq(200)
      response = get('/albums')
      expect(response.body).to include('Voyage')

    end

  end

  context "GET /artists" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/artists')


      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/artists/1">Pixies</a><br />')
    end
  end

  context "POST /artists" do
    it "adds an artist to artists table" do

      response = post("/artists", name: "Dave", genre: "rap")

       expect(response.status).to eq 200

       artists = get('/artists')

       expect(artists.body).to include("Dave")
    end
  end

  context "GET albums/:id" do
    it "return the html content for a single album" do
      
      response = get('/albums/2')

      expect(response.status).to eq 200
      expect(response.body).to include("<h1>Surfer Rosa</h1>")
      expect(response.body).to include("Artist: Pixies")
      expect(response.body).to include("Release year: 1988")
    end
  end

  context "GET albums/:id" do
    it "returns the html content for a single album" do

      response = get('/artists/2')

      expect(response.status).to eq 200
      expect(response.body).to include("<h1>ABBA</h1>")
      expect(response.body).to include("Genre: Pop")
    

    end
  end


end
