defmodule Finix.Merchants.Merchant do
  use Finix.Schema

  import Ecto.Changeset

  alias Finix.Links

  defmodule ProcessorDetails do
    use Finix.Schema
    import Ecto.Changeset

    embedded_schema do
      field(:mid, :string)
      field(:api_key, :string)
    end

    def changeset(details, params \\ %{}) do
      details
      |> cast(params, __schema__(:fields))
    end
  end

  embedded_schema do
    field(:id, :string)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
    field(:application, :string)
    field(:card_cvv_required, :boolean)
    field(:card_expiration_date_required, :boolean)
    field(:convenience_charges_enabled, :boolean)
    field(:creating_transfer_from_report_enabled, :boolean)
    field(:default_partial_authorization_enabled, :boolean)
    field(:fee_ready_to_settle_upon, :string)
    field(:gateway, Finix.Enums.Gateway)
    field(:gross_settlement_enabled, :boolean)
    field(:identity, :string)
    field(:level_two_level_three_data_enabled, :boolean)
    field(:mcc, :string)
    field(:merchant_name, :string)
    field(:merchant_profile, :string)
    field(:mid, :string)
    field(:onboarding_state, Finix.Enums.OnboardingState)
    field(:processing_enabled, :boolean)
    field(:processor, Finix.Enums.PaymentProcessor)
    field(:ready_to_settle_upon, Finix.Enums.ReadyToSettleUpon)
    field(:rent_surcharges_enabled, :boolean)
    field(:settlement_enabled, :boolean)
    field(:settlement_funding_identifier, :string)
    field(:surcharges_enabled, :boolean)
    field(:tags, :map)
    field(:verification, :string)

    embeds_one(:processor_details, ProcessorDetails)
    embeds_one(:_links, Links)
  end

  def changeset(merchant, params \\ %{}) do
    fields = __schema__(:fields) -- [:processor_details, :_links]

    merchant
    |> cast(params, fields)
    |> cast_embed(:processor_details)
    |> cast_embed(:_links)
  end
end
