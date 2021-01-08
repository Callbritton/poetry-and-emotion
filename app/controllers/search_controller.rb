class SearchController < ApplicationController
  def index
    author = params[:author]
    poem_conn = Faraday.new(url: "https://poetrydb.org")
    poem_response = poem_conn.get("/author,poemcount/#{author};10")
    poem_parsed = JSON.parse(poem_response.body, symbolize_names: true)

    ibm_conn = Faraday.new(url: "https://api.us-south.tone-analyzer.watson.cloud.ibm.com") do |faraday|
      faraday.basic_auth("apikey", ENV["API_KEY"])
    end

    ibm_response = ibm_conn.get("/instances/852d8535-673f-46f0-9dc1-fbd966ae40f0/v3/tone?version=2017-09-21&text=#{@text}")

    ibm_parsed = JSON.parse(ibm_response.body, symbolize_names: true)

    def fetch_poem_data(poem_parsed, ibm_parsed)
      poem_parsed.map do |poem_data|
        @text = poem_data[:lines].join(" ")
        Poem.new(poem_data, ibm_data)
      end
      ibm_parsed.map do |ibm_data|
        Poem.new(poem_data, ibm_data)
      end
    end

    @poems = fetch_poem_data(poem_parsed, ibm_parsed)
  end
end
