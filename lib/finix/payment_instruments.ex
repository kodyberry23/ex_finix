defmodule Finix.PaymentInstruments do
  @moduledoc """
  # Payment Instruments

  A Payment Instrument resource represents the payment details of a credit card or bank account. Payment details get tokenized multiple times and each tokenization produces a unique Payment Instrument.
  A Payment Instrument is associated with a single Identity. Once a Payment Instrument is created, the Identity it's associated with can't be changed.
  Including an address when creating a Payment Instrument can lower interchange on credit card transactions.

  See Finix Payment Instruments API Documentation: https://finix.com/docs/api/tag/Payment-Instruments/
  """
  alias Finix.Client

  @payment_instruments_url "/payment_instruments"

  defmodule PaymentInstrument do
    @derive [Poison.Encoder]
    defstruct [
      :id,
      :created_at,
      :updated_at,
      :application,
      :created_via,
      :currency,
      :enabled,
      :fingerprint,
      :identity,
      :instrument_type,
      :address,
      :address_verification,
      :bin,
      :brand,
      :card_type,
      :expiration_month,
      :expiration_year,
      :issuer_country,
      :last_four,
      :name,
      :security_code_verification,
      :tags,
      :type,
      :_links
    ]
  end

  @doc """
  Create a Payment Instrument resource using a card or bank account.

  The creation of Payment Instruments directly via Finix's API should only be done for testing purposes.
  You MUST use Finix's hosted fields or the javascript client to remain out of PCI scope.
  """
  @spec create_payment_instrument(map(), map()) :: struct()
  def create_payment_instrument(body, client_opts \\ %{}) do
    %{
      method: :post,
      body: body,
      url: @payment_instruments_url
    }
    |> Client.request(client_opts)
    |> Client.handle_response(%Finix.PaymentInstruments.PaymentInstrument{
      address: %Finix.Address{},
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
