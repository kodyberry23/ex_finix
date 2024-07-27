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
      Tesla.Middleware.PathParams,
      {Tesla.Middleware.JSON,
       decode_content_types: ["application/vnd.finix.1.0.0+json", "application/hal+json"]}
    ]

    adapter = {get_adapter(opts), get_http_opts(opts)}

    Tesla.client(middleware, adapter)
  end

  # -------------- Private Functions --------------
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
