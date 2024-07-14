defmodule Finix.PaymentInstruments do
  @moduledoc """
  # Payment Instruments

  A Payment Instrument resource represents the payment details of a credit card or bank account. Payment details get tokenized multiple times and each tokenization produces a unique Payment Instrument.
  A Payment Instrument is associated with a single Identity. Once a Payment Instrument is created, the Identity it's associated with can't be changed.
  Including an address when creating a Payment Instrument can lower interchange on credit card transactions.

  See Finix Payment Instruments API Documentation For More Info: https://finix.com/docs/api/tag/Payment-Instruments/
  """
  require Logger

  @payment_instruments_url "/payment_instruments"

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

  def verify(payment_instrument_id, %{processor: processor} = params, client_opts \\ %{}) do
    body = %{params | processor: processor_mapper(processor)}

    params =
      %{
        method: :post,
        opts: [path_params: [payment_instrument_id: payment_instrument_id]],
        url: @payment_instruments_url <> "/:payment_instrument_id/verifications",
        body: body
      }

    result = IO.inspect(params |> Finix.request(client_opts))

    result
    |> Finix.handle_response(Finix.Verifications.Verification)
  end

  # -------------- Private Functions --------------
  # for sandbox env
  defp processor_mapper(:DUMMY_V1), do: "DUMMY_V1"
  defp processor_mapper(:FINIX_V1), do: "FINIX_V1"
  defp processor_mapper(:MASTERCARD_V1), do: "MASTERCARD_V1"
  defp processor_mapper(:VISA_V1), do: "VISA_V1"

  defp processor_mapper(_) do
    Logger.error(
      "Error: Please provide a valid processor. Available processors are: DUMMY_V1, FINIX_V1, MASTERCARD_V1, VISA_V1"
    )

    {:error, :INVALID_PROCESSOR}
  end

  defp get_embedded_schema(%{"type" => "BANK_ACCOUNT"}),
    do: Finix.PaymentInstruments.PaymentInstrument.BankAccount

  defp get_embedded_schema(%{"type" => "PAYMENT_CARD"}),
    do: Finix.PaymentInstruments.PaymentInstrument.Card

  defp get_embedded_schema(%{"type" => "TOKEN"}),
    do: Finix.PaymentInstruments.PaymentInstrument.Token

  defp get_embedded_schema(_params) do
    Logger.error(
      "Error: Response retruned \"instrument_type\" that doesn't have a matching schema"
    )

    {:error, :NO_MATCH}
  end
end
