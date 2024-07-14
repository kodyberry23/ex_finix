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

    embeds_many(:messages, Finix.Verifications.Verification.Message)

    embeds_one(
      :payment_instrument_verification_details,
      Finix.Verifications.Verification.PaymentInstrumentVerificationDetails
    )

    embeds_one(:_links, Finix.Links)
  end

  def changeset(verification, params \\ %{}) do
    fields = __schema__(:fields) -- [:messages, :payment_instrument_verification_details, :_links]

    verification
    |> cast(params, fields)
    |> cast_embed(:messages)
    |> cast_embed(:payment_instrument_verification_details)
    |> cast_embed(:_links)
  end

  defmodule Message do
    use Finix.Schema
    import Ecto.Changeset

    embedded_schema do
      field(:detail, :string)
    end

    def changeset(message, params \\ %{}) do
      fields = __schema__(:fields)

      message
      |> cast(params, fields)
    end
  end

  defmodule PaymentInstrumentVerificationDetails do
    use Finix.Schema
    import Ecto.Changeset

    embedded_schema do
      field(:push_to_card_domestic, :string)
      field(:push_to_card_cross_border, :string)
      field(:card_type, Finix.Enums.CardType)
      field(:billing_currency, Finix.Enums.Currency)
      field(:issuer_country, Finix.Enums.IssuerCountry)
    end

    def changeset(details, params \\ %{}) do
      fields = __schema__(:fields)

      details
      |> cast(params, fields)
    end
  end

  defmodule ValidationDetails do
    use Finix.Schema

    import Ecto.Changeset

    embedded_schema do
      field(:systems_trace_audit_number, :string)
      field(:error_result, :string)
      field(:transaction_identifier, :string)
      field(:approval_code, :string)
      field(:action_code, :string)
      field(:response_code, :string)
      field(:address_verification_results, :string)
      field(:cvv2_result_code, :string)
    end

    def changeset(details, params \\ %{}) do
      fields = __schema__(:fields)

      details
      |> cast(params, fields)
    end
  end

  defmodule InquiryDetails do
    use Finix.Schema

    import Ecto.Changeset

    embedded_schema do
      field(:systems_trace_audit_number, :string)
      field(:error_result, :string)

      embeds_many(:visa_network_info, Finix.Verifications.Verification.VisaNetworkInfo)
      embeds_many(:ppgs_network_info, Finix.Verifications.Verification.PPGSNetworkInfo)
    end

    def changeset(details, params \\ %{}) do
      fields = __schema__(:fields) -- [:visa_network_info, :ppgs_network_info]

      details
      |> cast(params, fields)
      |> cast_embed(:visa_network_info)
      |> cast_embed(:ppgs_network_info)
    end
  end

  defmodule VisaNetworkInfo do
    use Finix.Schema

    import Ecto.Changeset

    embedded_schema do
      field(:card_type_code, :string)
      field(:billing_currency_code, :integer)
      field(:billing_currency_minor_digits, :integer)
      field(:issuer_name, :string)
      field(:card_issuer_country_code, :integer)
      field(:fast_funds_indicator, :string)
      field(:push_funds_block_indicator, :string)
      field(:online_gambing_block_indicator, :string)
      field(:card_product_type, :string)
      field(:billing_currency, :integer)
      field(:billing_currency_code_minor_digits, :integer)
      field(:non_money_transfer_push_funds_domestic, :string)
      field(:non_money_transfer_push_funds_cross_border, :string)
      field(:online_gambling_push_funds_domestic, :string)
      field(:online_gambling_push_funds_cross_border, :string)
      field(:money_transfer_push_funds_domestic, :string)
      field(:money_transfer_push_funds_cross_border, :string)
      field(:non_money_transfer_fast_funds_domestic, :string)
      field(:non_money_transfer_fast_funds_cross_border, :string)
      field(:online_gambling_fast_funds_domestic, :string)
      field(:online_gambling_fast_funds_cross_border, :string)
      field(:money_transfer_fast_funds_domestic, :string)
      field(:money_transfer_fast_funds_cross_border, :string)
      field(:combo_card_range, :string)
      field(:card_platform_code, :string)
      field(:issuer_country_code, :integer)
    end

    def changeset(info, params \\ %{}) do
      cast(info, params, __schema__(:fields))
    end
  end

  defmodule PPGSNetworkInfo do
    use Finix.Schema

    import Ecto.Changeset

    embedded_schema do
      field(:info, :string)
    end

    def changeset(info, params \\ %{}) do
      cast(info, params, __schema__(:fields))
    end
  end
end
