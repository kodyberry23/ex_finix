defmodule Finix.Client do
  def new(opts \\ %{}) do
    middleware = [
      {Tesla.Middleware.BaseUrl, get_base_url(opts)},
      {Tesla.Middleware.BasicAuth, username: get_username(opts), password: get_password(opts)},
      Tesla.Middleware.JSON
    ]

    adapter = {get_adapter(opts), get_http_opts(opts)}

    Tesla.client(middleware, adapter)
  end

  def request(opts) do
    Tesla.request(new(opts))
  end

  @spec handle_response(Tesla.Env.t() | %Tesla.Error{}) :: Finix.Error.t()
  def handle_response(%Tesla.Env{status: status} = response) when status in [400..500] do
    raise Finix.Error, response
  end

  def handle_response(response) do
  end

  def handle_response(%Tesla.Error{message: message}) do
    {:error, message}
  end

  # -------------- Private Functions --------------
  defp get_adapter(config) do
    adapter = Map.get(config, :adapter)

    adapter || Application.get_env(:finix, :adapter, Tesla.Adapter.Hackney)
  end

  defp get_base_url(config) do
    base_url = Map.get(config, :base_url)

    # Default to sandbox environment
    base_url || Application.get_env(:finix, :base_url, "https://finix.sandbox-payments-api.com")
  end

  defp get_http_opts(config) do
    http_opts = Map.get(config, :http_opts)

    http_opts || Application.get_env(:finix, :http_opts, [])
  end

  defp get_password(config) do
    password = Map.get(config, :password) || Application.get_env(:finix, :password)

    case password do
      nil ->
        raise Finix.InvalidPasswordError

      _ ->
        password
    end
  end

  defp get_username(config) do
    username = Map.get(config, :username) || Application.get_env(:finix, :username)

    case username do
      nil ->
        raise Finix.InvalidUsernameError

      _ ->
        username
    end
  end
end
