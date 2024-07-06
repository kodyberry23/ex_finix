defmodule Finix.Client do
  @type req_params() :: %{
          url: String.t(),
          method: atom(),
          body: map()
        }

  @type client_opts() :: map()

  def new(opts \\ %{}) do
    middleware = [
      {Tesla.Middleware.BaseUrl, get_base_url(opts)},
      {Tesla.Middleware.BasicAuth, username: get_username(opts), password: get_password(opts)},
      {Tesla.Middleware.Headers,
       [
         {"Content-Type", "application/json"},
         {"Accept", "application/json"},
         {"Finix-Version", get_api_version(opts)}
       ]},
      {Tesla.Middleware.JSON,
       engine: Poison,
       decode_content_types: ["application/vnd.finix.1.0.0+json", "application/hal+json"]}
    ]

    adapter = {get_adapter(opts), get_http_opts(opts)}

    Tesla.client(middleware, adapter)
  end

  @spec request(req_params(), client_opts()) :: struct() | {:error, term()}
  def request(params, client_opts \\ %{}) do
    url = Map.get(params, :url, "")
    method = Map.get(params, :method, :get)
    body = Map.get(params, :body, %{})

    req_params = [url: url, method: method, body: body]

    Tesla.request(new(client_opts), req_params)
  end

  @spec handle_response({:ok, Tesla.Env.t()} | {:error, %Tesla.Error{}}, struct()) :: struct()
  def handle_response({:ok, %Tesla.Env{status: status, body: body}}, mapper)
      when status in 200..299 do
    convert_to_struct(body, mapper)
  end

  def handle_response({:ok, %Tesla.Env{status: status, body: body}}, _mapper)
      when status >= 400 do
    Poison.Decode.transform(
      body,
      %{
        as: %Finix.Error{
          _embedded: %Finix.Error.Embedded{
            errors: [
              %Finix.Error.Error{
                logref: %Finix.Error.Logref{},
                _links: %Finix.Error.Links{
                  source: %Finix.Error.Links.Source{}
                }
              }
            ]
          }
        }
      }
    )
  end

  def handle_response({:error, _reason} = error, _mapper) do
    error
  end

  # -------------- Private Functions --------------
  defp convert_to_struct(body, mapper) when is_map(body) do
    Poison.Decode.transform(body, %{as: mapper})
  end

  defp convert_to_struct(body, mapper) when is_list(body) do
    for elem <- body do
      Poison.Decode.transform(elem, %{as: mapper})
    end
  end

  defp get_adapter(config) do
    adapter = Map.get(config, :adapter)

    # Defaults to Hackney adapter
    adapter || Application.get_env(:ex_finix, :adapter, Tesla.Adapter.Hackney)
  end

  defp get_api_version(config) do
    api_version = Map.get(config, :api_version)

    api_version || Application.get_env(:ex_finix, :api_version, "2018-01-01")
  end

  defp get_base_url(config) do
    base_url = Map.get(config, :base_url)

    # Default to sandbox url
    base_url ||
      Application.get_env(:ex_finix, :base_url, "https://finix.sandbox-payments-api.com")
  end

  defp get_http_opts(config) do
    http_opts = Map.get(config, :http_opts)

    http_opts || Application.get_env(:ex_finix, :http_opts, [])
  end

  defp get_password(config) do
    password = Map.get(config, :password) || Application.get_env(:ex_finix, :password)

    case password do
      nil ->
        raise Finix.InvalidPasswordError

      _ ->
        password
    end
  end

  defp get_username(config) do
    username = Map.get(config, :username) || Application.get_env(:ex_finix, :username)

    case username do
      nil ->
        raise Finix.InvalidUsernameError

      _ ->
        username
    end
  end
end
