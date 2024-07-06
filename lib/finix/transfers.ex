defmodule Finix.Transfers do
  @moduledoc """
  # Transfers

  A Transfer represents any flow of funds either to or from a Payment Instrument. All payments in Finix are represented by a Transfer.

  See Finix Transfers API Documentation: https://finix.com/docs/api/tag/Transfers/
  """
  alias Finix.Client

  @transfers_url "/transfers"

  defmodule Transfer do
    @derive [Poison.Encoder]
    defstruct [
      :id,
      :created_at,
      :updated_at,
      :additional_buyer_charges,
      :additional_healthcare_data,
      :address_verification,
      :amount,
      :amount_requested,
      :application,
      :currency,
      :destination,
      :externally_funded,
      :failure_code,
      :failure_message,
      :fee,
      :idempotency_id,
      :merchant,
      :merchant_identity,
      :messages,
      :raw,
      :ready_to_settle_at,
      :security_code_verification,
      :source,
      :split_transfers,
      :state,
      :statement_descriptor,
      :subtype,
      :_links
    ]
  end

  def create_transfer(body, client_opts \\ %{}) do
    %{
      method: :post,
      body: body,
      url: @transfers_url
    }
    |> Client.request(client_opts)
    |> Client.handle_response(%Finix.Transfers.Transfer{
      _links: %Finix.Links{
        self: %Finix.Links.Link{},
        verifications: %Finix.Links.Link{},
        merchants: %Finix.Links.Link{},
        settlements: %Finix.Links.Link{},
        authorizations: %Finix.Links.Link{},
        transfers: %Finix.Links.Link{},
        payment_instruments: %Finix.Links.Link{},
        associated_identities: %Finix.Links.Link{},
        disputes: %Finix.Links.Link{},
        application: %Finix.Links.Link{}
      }
    })
  end
end
