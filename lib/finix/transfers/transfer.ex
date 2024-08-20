defmodule Finix.Transfers.Transfer do
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
      field(:customs_duty_amount, :integer)
      field(:destination_country_code, :string)
      field(:destination_postal_code, :string)
      field(:discount_amount, :integer)
      field(:invoice_reference_number, :string)
      field(:sales_tax, :integer)
      field(:ship_from_postal_code, :string)
      field(:shipping_amount, :integer)
      field(:tax_exempt, :boolean)

      embeds_one(:order_date, OrderDate)

      embeds_many(:item_data, ItemData)
    end

    def changeset(additional_purchase_data, attrs) do
      additional_purchase_data
      |> cast(attrs, __schema__(:fields) -- [:item_data, :order_date])
      |> cast_embed(:item_data)
    end

    defmodule ItemData do
      use Finix.Schema

      embedded_schema do
        field(:amount_excluding_sales_tax, :integer)
        field(:amount_including_sales_tax, :integer)
        field(:commodity_code, :string)
        field(:cost_per_unit, :integer)
        field(:item_description, :string)
        field(:item_discount_amount, :integer)
        field(:merchant_product_code, :string)
        field(:quantity, :integer)
        field(:unit_of_measure, :string)
      end

      def changeset(item_data, attrs) do
        item_data
        |> cast(attrs, __schema__(:fields))
      end
    end

    defmodule OrderDate do
      use Finix.Schema

      embedded_schema do
        field(:day, :integer)
        field(:month, :integer)
        field(:year, :integer)
      end

      def changeset(order_date, attrs) do
        order_date
        |> cast(attrs, __schema__(:fields))
      end
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
