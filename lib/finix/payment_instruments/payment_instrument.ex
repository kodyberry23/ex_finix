defmodule Finix.PaymentInstruments.PaymentInstrument do
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
