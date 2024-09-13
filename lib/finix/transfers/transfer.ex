defmodule Finix.Transfers.Transfer do
  use Finix.Schema

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

    embeds_one :additional_purchase_data, AdditionalPurchaseData, primary_key: false do
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

      embeds_one :order_date, OrderDate, primary_key: false do
        field(:day, :integer)
        field(:month, :integer)
        field(:year, :integer)
      end

      embeds_many :item_data, ItemData, primary_key: false do
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
    end

    embeds_one :additional_buyer_charges, AdditionalBuyerCharges, primary_key: false do
      field(:convenience_amount, :integer)
      field(:surcharge_amount, :integer)
      field(:rent_surcharge_amount, :integer)
    end

    embeds_one(:_links, Finix.Links)
  end

  def changeset(transfer, params \\ %{}) do
    transfer
    |> cast(
      params,
      __schema__(:fields) -- [:additional_buyer_charges, :additional_purchase_data, :_links]
    )
    |> cast_embed(:_links)
    |> cast_embed(:additional_purchase_data, with: &additonal_purchase_data_changeset/2)
    |> cast_embed(:additional_buyer_charges, with: &additional_buyer_charges_changeset/2)
  end

  def additional_buyer_charges_changeset(additional_buyer_chargers, params \\ %{}) do
    additional_buyer_chargers
    |> cast(params, [:convenience_amount, :surcharge_amount, :rent_surcharge_amount])
  end

  def additonal_purchase_data_changeset(additional_purchase_data, attrs) do
    additional_purchase_data
    |> cast(attrs, [
      :customer_reference_number,
      :customs_duty_amount,
      :destination_country_code,
      :destination_postal_code,
      :discount_amount,
      :invoice_reference_number,
      :sales_tax,
      :ship_from_postal_code,
      :shipping_amount,
      :tax_exempt
    ])
    |> cast_embed(:item_data, with: &item_data_changeset/2)
    |> cast_embed(:order_date, with: &order_date_changeset/2)
  end

  def item_data_changeset(item_data, params) do
    cast(
      item_data,
      params,
      [
        :amount_excluding_sales_tax,
        :amount_including_sales_tax,
        :commodity_code,
        :cost_per_unit,
        :item_description,
        :item_discount_amount,
        :merchant_product_code,
        :quantity,
        :unit_of_measure
      ]
    )
  end

  def order_date_changeset(order_date, attrs) do
    cast(order_date, attrs, [:day, :month, :year])
  end
end
