defmodule Finix.Transfers do
  @moduledoc """
  # Transfers

  A Transfer represents any flow of funds either to or from a Payment Instrument. All payments in Finix are represented by a Transfer.

  See Finix Transfers API Documentation: https://finix.com/docs/api/tag/Transfers/
  """
  @transfers_url "/transfers"

  defmodule Transfer do
    use Finix.Schema

    defmodule AdditionalBuyerCharges do
      use Finix.Schema

      embedded_schema do
        field(:convenience_amount, :integer)
        field(:surcharge_amount, :integer)
        field(:rent_surcharge_amount, :integer)
      end

      def changeset(additional_buyer_chargers, params \\ %{}) do
        additional_buyer_chargers
        |> cast(params, [:convenience_amount, :surcharge_amount, :rent_surcharge_amount])
      end
    end

    defmodule AdditionalPurchaseData do
      use Finix.Schema

      embedded_schema do
        field(:customer_reference_number, :string)
        field(:sales_tax, :integer)
      end

      def changeset(additional_purchase_data, params \\ %{}) do
        additional_purchase_data
        |> cast(params, [:customer_reference_number, :sales_tax])
      end
    end

    embedded_schema do
      field(:id, :string)
      field(:created_at, :utc_datetime)
      field(:updated_at, :utc_datetime)
      field(:additional_healthcare_data, :string)
      field(:address_verification, :string)
      field(:amount, :integer)
      field(:amount_requested, :integer)
      field(:application, :string)
      field(:currency, Finix.Enums.Currency)
      field(:destination, :string)
      field(:externally_funded, :string)
      field(:failure_code, :string)
      field(:failure_message, :string)
      field(:fee, :integer)
      field(:idempotency_id, :string)
      field(:merchant, :string)
      field(:merchant_identity, :string)
      field(:messages, {:array, :string})
      field(:raw, Finix.Utils.RawType)
      field(:ready_to_settle_at, :utc_datetime)
      field(:security_code_verification, :string)
      field(:source, :string)
      field(:split_transfers, {:array, :string})
      field(:state, Finix.Enums.TransferState)
      field(:statement_descriptor, :string)
      field(:subtype, Finix.Enums.TransferSubType)

      embeds_one(:additional_purchase_data, Finix.Transfers.Transfer.AdditionalPurchaseData)
      embeds_one(:additional_buyer_charges, Finix.Transfers.Transfer.AdditionalBuyerCharges)
      embeds_one(:_links, Finix.Links)
    end

    def changeset(transfer, params \\ %{}) do
      transfer
      |> cast(
        params,
        __schema__(:fields) -- [:additional_buyer_charges, :additional_purchase_data, :_links]
      )
      |> cast_embed(:_links)
      |> cast_embed(:additional_purchase_data)
      |> cast_embed(:additional_buyer_charges)
    end
  end

  def create(body, client_opts \\ %{}) do
    %{
      method: :post,
      body: body,
      url: @transfers_url
    }
    |> Finix.request(client_opts)
    |> Finix.handle_response(Finix.Transfers.Transfer)
  end
end
