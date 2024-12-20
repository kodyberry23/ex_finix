defmodule Finix do
  import Ecto.Changeset

  alias Finix.Errors
  alias Finix.Client

  @type req_params() :: %{
          url: String.t(),
          method: atom(),
          body: map()
        }

  @type client_opts() :: map()

  @spec request(req_params(), client_opts()) :: struct() | {:error, term()}
  def request(params, client_opts \\ %{}) do
    url = Map.get(params, :url, "")
    method = Map.get(params, :method, :get)
    body = Map.get(params, :body)
    opts = Map.get(params, :opts, [])

    req_params = [url: url, method: method, body: body, opts: opts]

    Tesla.request(Client.new(client_opts), req_params)
  end

  def handle_response({:ok, %Tesla.Env{status: status, body: body}}, mapper)
      when status in 200..299 do
    map_response(body, mapper)
  end

  def handle_response({:ok, %Tesla.Env{status: status, body: body}}, _mapper)
      when status >= 400 do
    result =
    body
    |> Map.merge(%{"status" => status})
    |> map_response(Errors)

    case result do
      {:ok, error} -> {:error, error}
      error -> error
    end
  end

  def handle_response({:error, _reason} = error, _mapper) do
    error
  end

  def map_response(body, fun) when is_function(fun) do
    module = fun.(body)

    map_response(body, module)
  end

  def map_response(body, module) when is_atom(module) do
    changeset = apply(module, :changeset, [struct(module), body])

    if changeset.valid? do
      result = apply_changes(changeset)

      {:ok, result}
    else
      {:error, changeset}
    end
  end
end
