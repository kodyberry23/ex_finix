defmodule Finix.Identities do
  @moduledoc """
  # Identities

  An Identity resource represents either a person or business in Finix. You'll create an Identity to onboard your sellers, and verify the different owners.

  See Finix Indentities API Documentation for more info: https://finix.com/docs/api/tag/Identities/
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
      body: body
    }
    |> Finix.request(client_opts)
    |> Finix.handle_response(Identity)
  end
end
