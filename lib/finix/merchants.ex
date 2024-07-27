defmodule Finix.Merchants do
  @moduledoc """
  # Merchants

  A Merchant resource represents the entity's merchant account on a processor. You need to create and successfully validate a Merchant before processing any payments for your merchant.

  See Finix Merchants API Documentation for more info: https://finix.com/docs/api/tag/Merchants/
  """

  alias Finix.Merchants.Merchant

  @merchants_url "/merchants"

  @doc """
  Create a Merchant to start the underwriting (also called provisioning) process for your seller. Merchants must be created under an Identity.

  A bank account must be associated with the previously created Identity before a Merchant can be successfully onboarded and verified.
  """
  def create(identity_id, body, client_opts \\ %{}) do
    # body = %{processor: processor}

    params =
      %{
        method: :post,
        opts: [path_params: [identity_id: identity_id]],
        url: "/identities/:identity_id" <> @merchants_url,
        body: body
      }

    params
    |> Finix.request(client_opts)
    |> Finix.handle_response(Merchant)
  end

  @doc """
  Retrieve the details of a Merchant.
  """
  def fetch(merchant_id, client_opts \\ %{}) do
    params =
      %{
        method: :get,
        opts: [path_params: [merchant_id: merchant_id]],
        url: @merchants_url <> "/:merchant_id"
      }

    params
    |> Finix.request(client_opts)
    |> Finix.handle_response(Merchant)
  end
end
