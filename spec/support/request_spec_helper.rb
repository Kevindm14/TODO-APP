module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def valid_headers
    {
      "Content-Type" => "application/json"
    }
  end
end