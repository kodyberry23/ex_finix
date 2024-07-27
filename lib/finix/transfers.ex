defmodule Finix.Transfers do
  @moduledoc """
  # Transfers

  A Transfer represents any flow of funds either to or from a Payment Instrument. All payments in Finix are represented by a Transfer.

  See Finix Transfers API Documentation: https://finix.com/docs/api/tag/Transfers/
  """

  alias Finix.Transfers.Transfer

  @transfers_url "/transfers"

  @doc """
  Create a Transfer.
  """
  def create(body, client_opts \\ %{}) do
    %{
      method: :post,
      body: body,
      url: @transfers_url
    }
    |> Finix.request(client_opts)
    |> Finix.handle_response(Transfer)
  end

  @doc """
  Retrieve a Transfer.
  """
  def fetch(transfer_id, client_opts \\ %{}) do
    params =
      %{
        method: :get,
        opts: [path_params: [transfer_id: transfer_id]],
        url: @transfers_url <> "/:transfer_id"
      }

    params
    |> Finix.request(client_opts)
    |> Finix.handle_response(Transfer)
  end
end
