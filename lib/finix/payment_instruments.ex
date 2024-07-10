defmodule Finix.PaymentInstruments do
  @moduledoc """
  # Payment Instruments

  A Payment Instrument resource represents the payment details of a credit card or bank account. Payment details get tokenized multiple times and each tokenization produces a unique Payment Instrument.
  A Payment Instrument is associated with a single Identity. Once a Payment Instrument is created, the Identity it's associated with can't be changed.
  Including an address when creating a Payment Instrument can lower interchange on credit card transactions.

  See Finix Payment Instruments API Documentation: https://finix.com/docs/api/tag/Payment-Instruments/
  """
  require Logger

  @payment_instruments_url "/payment_instruments"

  defmodule PaymentInstrument do
    defmodule BankAccount do
      use Finix.Schema

      alias Finix.Links

      embedded_schema do
        field(:id, :string)
        field(:created_at, :utc_datetime)
        field(:updated_at, :utc_datetime)
        field(:application, :string)
        field(:created_via, :string)
        field(:currency, Finix.Enums.Currency)
        field(:disabled_code, :string)
        field(:disabled_message, :string)
        field(:enabled, :boolean)
        field(:fingerprint, :string)
        field(:identity, :string)
        field(:instrument_type, Finix.Enums.PaymentInstrumentType)
        field(:account_type, Finix.Enums.BankAccountType)
        field(:bank_account_validation_check, Finix.Enums.BankAccoiuntValidationCheck)
        field(:bank_code, :string)
        field(:country, Finix.Enums.Country)
        field(:institution_number, :string)
        field(:masked_account_number, :string)
        field(:name, :string)
        field(:tags, :map)
        field(:transit_number, :string)
        field(:third_party, :string)
        field(:third_party_token, :string)
        field(:type, Finix.Enums.PaymentInstrumentType)

        embeds_one(:_links, Links)
      end

      def changeset(bank_account, params \\ %{}) do
        bank_account
        |> cast(params, __schema__(:fields) -- [:_links])
        |> cast_embed(Links)
      end
    end

    defmodule Card do
      use Finix.Schema

      alias Finix.Address
      alias Finix.Links


      embedded_schema do
        field(:id, :string)
        field(:created_at, :utc_datetime)
        field(:updated_at, :utc_datetime)
        field(:application, :string)
        field(:created_via, :string)
        field(:currency, Finix.Enums.Currency)
        field(:enabled, :boolean)
        field(:fingerprint, :string)
        field(:identity, :string)
        field(:instrument_type, Finix.Enums.PaymentInstrumentType)
        field(:address_verification, Finix.Enums.AddressVerification)
        field(:bin, :string)
        field(:brand, Finix.Enums.CardBrand)
        field(:card_type, Finix.Enums.CardType)
        field(:expiration_month, :integer)
        field(:expiration_year, :integer)
        field(:issuer_country, Finix.Enums.IssuerCountry)
        field(:last_four, :string)
        field(:name, :string)
        field(:payload_type, Finix.Enums.PayloadType)
        field(:security_code_verification, Finix.Enums.SecurityCodeVerification)
        field(:tags, :map)
        field(:type, Finix.Enums.PaymentInstrumentType)

        embeds_one(:_links, Links)
        embeds_one(:address, Address)
      end

      def changeset(card, params \\ %{}) do
        card
        |> cast(params, __schema__(:fields) -- [:address, :_links])
        |> cast_embed(:_links)
        |> cast_embed(:address)
      end
    end

    defmodule Token do
      use Finix.Schema

      alias Finix.Address
      alias Finix.Links


      embedded_schema do
        field(:id, :string)
        field(:created_at, :utc_datetime)
        field(:updated_at, :utc_datetime)
        field(:application, :string)
        field(:created_via, :string)
        field(:currency, Finix.Enums.IssuerCountry)
        field(:enabled, :boolean)
        field(:fingerprint, :string)
        field(:identity, :string)
        field(:instrument_type, Finix.Enums.PaymentInstrumentType)
        field(:address_verification, Finix.Enums.AddressVerification)
        field(:bin, :string)
        field(:brand, Finix.Enums.CardBrand)
        field(:card_type, Finix.Enums.CardType)
        field(:expiration_month, :integer)
        field(:expiration_year, :integer)
        field(:issuer_country, Finix.Enums.IssuerCountry)
        field(:last_four, :string)
        field(:name, :string)
        field(:security_code_verification, Finix.Enums.SecurityCodeVerification)
        field(:type, Finix.Enums.PaymentInstrumentType)
        field(:tags, :map)

        embeds_one(:address, Address)
        embeds_one(:_links, Links)
      end

      def changeset(token, params \\ %{}) do
        token
        |> cast(params, __schema__(:fields) -- [:address, :_links])
        |> cast_embed(Links)
        |> cast_embed(Address)
      end
    end
  end

  @doc """
  Create a Payment Instrument resource using a card or bank account.

  %{"type" => "PAYMENT_CARD"}

  The creation of Payment Instruments directly via Finix's API should only be done for testing purposes.
  You MUST use Finix's hosted fields or the javascript client to remain out of PCI scope.
  """
  @spec create(map(), map()) :: struct()
  def create(body, client_opts \\ %{}) do
    params =
      %{
        method: :post,
        body: body,
        url: @payment_instruments_url
      }

    params
    |> Finix.request(client_opts)
    |> Finix.handle_response(&get_embedded_schema/1)
  end

  def fetch(payment_instrument_id, client_opts \\ %{}) do
    params =
      %{
        method: :get,
        opts: [path_params: [payment_instrument_id: payment_instrument_id]],
        url: @payment_instruments_url <> "/:payment_instrument_id"
      }

    params
    |> Finix.request(client_opts)
    |> Finix.handle_response(&get_embedded_schema/1)
  end

  # -------------- Private Functions --------------
  defp get_embedded_schema(%{"type" => "BANK_ACCOUNT"}), do: PaymentInstrument.BankAccount
  defp get_embedded_schema(%{"type" => "PAYMENT_CARD"}), do: PaymentInstrument.Card
  defp get_embedded_schema(%{"type" => "TOKEN"}), do: PaymentInstrument.Token

  defp get_embedded_schema(_params) do
    Logger.error(
      "Error: Response retruned \"instrument_type\" that doesn't have a matching schema"
    )

    {:error, :NO_MATCH}
  end
end
