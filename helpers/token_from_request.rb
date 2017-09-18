module Gate
  module TokenFromRequest
    def token_from_request(site = nil)
      begin
        body_params = JSON.parse(request.body.read, symbolize_names: true)
        token = body_params[:token] || params[:token]
      rescue JSON::ParserError => _
        token = body_params[:token] || params[:token]
      end
      params[:token] = '*' * 8
      Controllers::Token.parse(token, site || params[:site])
    end
  end
end
