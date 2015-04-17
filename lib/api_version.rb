class ApiVersion

  def initialize(version, default=false)
    @version, @default = version, default 
  end

  def matches?(request)
   @default || check_headers(request.headers)
  end

private

  def check_headers(headers)
    headers['Accept'].present? && headers['Accept'].include?("application/vnd.thenitespot.v#{@version}")
  end
end