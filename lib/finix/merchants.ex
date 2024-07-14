defmodule Finix.Merchants do
  @moduledoc """
  # Merchants

  A Merchant resource represents the entity's merchant account on a processor. You need to create and successfully validate a Merchant before processing any payments for your merchant.

  See Finix Merchants API Documentation For More Info: https://finix.com/docs/api/tag/Merchants/
  """

  alias Finix.Merchants.Merchant

  @doc """
  Create a Merchant to start the underwriting (also called provisioning) process for your seller. Merchants must be created under an Identity.
  A bank account must be associated with the previously created Identity before a Merchant can be successfully onboarded and verified.
  """
  def create(identity_id, processor, client_opts \\ %{}) do
    body = %{processor: processor}

    params =
      %{
        method: :post,
        url: create_merchant_url(identity_id),
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
        url: merchant_url(merchant_id)
      }

    params
    |> Finix.request(client_opts)
    |> Finix.handle_response(Merchant)
  end

  # -------------- Private Functions --------------
  defp create_merchant_url(identity_id), do: "/identities/#{identity_id}/merchants"
  defp merchant_url(merchant_id), do: "/merchants/#{merchant_id}"
end
