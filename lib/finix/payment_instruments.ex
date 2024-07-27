defmodule Finix.PaymentInstruments do
  @moduledoc """
  # Payment Instruments

  A Payment Instrument resource represents the payment details of a credit card or bank account. Payment details get tokenized multiple times and each tokenization produces a unique Payment Instrument.
  A Payment Instrument is associated with a single Identity. Once a Payment Instrument is created, the Identity it's associated with can't be changed.
  Including an address when creating a Payment Instrument can lower interchange on credit card transactions.

  See Finix Payment Instruments API Documentation For More Info: https://finix.com/docs/api/tag/Payment-Instruments/
  """

  @payment_instruments_url "/payment_instruments"

  @doc """
  Create a Payment Instrument resource using a card or bank account.

  The creation of Payment Instruments directly via Finix's API should only be done for testing purposes.
  You MUST use Finix's hosted fields or the javascript client to remain out of PCI scope.
  """
  @spec create(map(), map()) :: struct()
  def create(body, client_opts \\ %{}) do
    %{
      method: :post,
      body: body,
      url: @payment_instruments_url
    }
    |> Finix.request(client_opts)
    |> Finix.handle_response(&get_embedded_schema/1)
  end

  @doc """
  Retrieve the details of a Payment Instrument.
  """
  def fetch(payment_instrument_id, client_opts \\ %{}) do
    %{
      method: :get,
      opts: [path_params: [payment_instrument_id: payment_instrument_id]],
      url: @payment_instruments_url <> "/:payment_instrument_id"
    }
    |> Finix.request(client_opts)
    |> Finix.handle_response(&get_embedded_schema/1)
  end

  @doc """
  Verify a Payment Instrument to determine CVV and AVS results.

  You can also determine Push To Card eligibility for Push To Card customers.
  """
  def verify(payment_instrument_id, body, client_opts \\ %{}) do
    %{
      method: :post,
      opts: [path_params: [payment_instrument_id: payment_instrument_id]],
      url: @payment_instruments_url <> "/:payment_instrument_id/verifications",
      body: body
    }
    |> Finix.request(client_opts)
    |> Finix.handle_response(Finix.Verifications.Verification)
  end

  # -------------- Private Functions --------------
  defp get_embedded_schema(%{"type" => "BANK_ACCOUNT"}),
    do: Finix.PaymentInstruments.PaymentInstrument.BankAccount

  defp get_embedded_schema(%{"type" => "PAYMENT_CARD"}),
    do: Finix.PaymentInstruments.PaymentInstrument.Card

  defp get_embedded_schema(%{"type" => "TOKEN"}),
    do: Finix.PaymentInstruments.PaymentInstrument.Token
end
