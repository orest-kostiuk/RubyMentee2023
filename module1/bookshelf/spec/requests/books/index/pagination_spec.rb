context "given invalid page and per_page params" do
  it "returns a 422 unprocessable response" do
    get "/books?page=-1&per_page=3000"

    expect(last_response).to be_unprocessable

    response_body = JSON.parse(last_response.body)

    expect(response_body).to eq(
                               "errors" => {
                                 "page" => ["must be greater than 0"],
                                 "per_page" => ["must be less than or equal to 100"]
                               }
                             )
  end
end