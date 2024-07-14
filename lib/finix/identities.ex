defmodule Finix.Identities do
  @moduledoc """
  # Identities

  An Identity resource represents either a person or business in Finix. You'll create an Identity to onboard your sellers, and verify the different owners.

  See Finix Indentities API Documentation: https://finix.com/docs/api/tag/Identities/
  """
  alias Finix.Identities.Identity

  @indentities_url "/identities"

  @doc """
  Create an Identity for your seller or buyer.

  All fields for a buyer's Identity are optional.

  Providing `business_type` indicates that the Identity is being created for a Merchant.
  """
  @spec create(map(), map()) :: struct()
  def create(body, client_opts \\ %{}) do
    %{
      url: @indentities_url,
      method: :post,
      body: body,
      opts: [struct: "test"]
    }
    |> Finix.request(client_opts)
    |> Finix.handle_response(Identity)
  end

  def provision_recipient_account(identity_id, processor, client_opts \\ %{}) do
    body = %{processor: processor}

    params =
      %{
        method: :get,
        opts: [path_params: [identity_id: identity_id]],
        url: @indentities_url <> "/:identity_id/merchants",
        body: body
      }

    params
    |> Finix.request(client_opts)
    |> Finix.handle_response(Identity)
  end
end
