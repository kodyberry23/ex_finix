defmodule Finix.Authorizations do
  @moduledoc """
  # Authorizations

  An Authorization (also known as a card hold) reserves a specific amount on a card to be captured (i.e. debited) at a later date, usually within seven days.

  When an Authorization is captured it produces a Transfer resource.
  """
  alias Finix.Authorizations.Authorization

  @authorizations_url "/authorizations"

  @doc """
  Use a PUT request to capture an Authorization. If captured successfully, the transfer field of the Authorization
  will contain the ID of the Transfer resource that moves funds.
  """
  def capture(authorization_id, body, client_opts \\ %{}) do
    %{
      method: :put,
      opts: [path_params: [authorization_id: authorization_id]],
      body: body,
      url: @authorizations_url <> "/:authorization_id"
    }
    |> Finix.request(client_opts)
    |> Finix.handle_response(Authorization)
  end

  @doc """
  Create an Authorization to process a transaction.
  """
  def create(body, client_opts \\ %{}) do
    %{
      method: :post,
      body: body,
      url: @authorizations_url
    }
    |> Finix.request(client_opts)
    |> Finix.handle_response(Authorization)
  end

  @doc """
  Retrieve the details of a previously created Authorization.
  """
  def fetch(authorization_id, client_opts \\ %{}) do
    %{
      method: :get,
      opts: [path_params: [authorization_id: authorization_id]],
      url: @authorizations_url <> "/:authorization_id"
    }
    |> Finix.request(client_opts)
    |> Finix.handle_response(Authorization)
  end

  @doc """
  Use a PUT request to void an Authorization. If voided successfully, funds get released and the transaction stops from
  completing. Additionally, voided Authorization can no longer be captured.
  """
  def void(authorization_id, client_opts \\ %{}) do
    %{
      method: :put,
      opts: [path_params: [authorization_id: authorization_id]],
      body: %{void_me: true},
      url: @authorizations_url <> "/:authorization_id"
    }
    |> Finix.request(client_opts)
    |> Finix.handle_response(Authorization)
  end
end
