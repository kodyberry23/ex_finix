defmodule Finix.Verifications.Verification do
  use Finix.Schema

  import Ecto.Changeset

  embedded_schema do
    field(:id, :string)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
    field(:application, :string)
    field(:identity, :string)
    field(:merchant, :string)
    field(:merchant_identity, :string)
    field(:payment_instrument, :string)
    field(:processor, Finix.Enums.PaymentProcessor)
    field(:state, Finix.Enums.TransferState)
    field(:tags, :map)
    field(:trace_id, :string)
    field(:type, Finix.Enums.PaymentInstrumentType)
    field(:raw, Finix.Utils.RawType)

    embeds_many :messages, Finix.Verifications.Verification.Message, primary_key: false do
      field(:detail, :string)
    end

    embeds_one :payment_instrument_verification_details, PaymentInstrumentVerificationDetails,
      primary_key: false do
      field(:push_to_card_domestic, Finix.Enums.PushToCardSupportCode)
      field(:push_to_card_cross_border, Finix.Enums.PushToCardSupportCode)
      field(:card_type, Finix.Enums.CardType)
      field(:billing_currency, Finix.Enums.Currency)
      field(:issuer_country, Finix.Enums.IssuerCountry)
    end

    embeds_one(:_links, Finix.Links)
  end

  def changeset(verification, params \\ %{}) do
    fields = __schema__(:fields) -- [:messages, :payment_instrument_verification_details, :_links]

    verification
    |> cast(params, fields)
    |> cast_embed(:messages, with: &message_changeset/2)
    |> cast_embed(:payment_instrument_verification_details,
      with: &payment_instrument_verification_details_changeset/2
    )
    |> cast_embed(:_links)
  end

  def message_changeset(message, params \\ %{}) do
    cast(message, params, [:detail])
  end

  def payment_instrument_verification_details_changeset(
        payment_instrument_verification_details,
        params \\ %{}
      ) do
    cast(payment_instrument_verification_details, params, [
      :push_to_card_domestic,
      :push_to_card_cross_border,
      :card_type,
      :billing_currency,
      :issuer_country
    ])
  end
end
