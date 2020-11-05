defmodule Transaction do
  defstruct date_transaction: Date.utc_today, type_transaction: nil, value: 0, from: nil, to: nil

  @transactions "transactions.txt"

  def save_transaction(type_transaction, from, to \\ nil, value, date_transaction) do
    transactions = search_transactions() ++
    [%__MODULE__{type_transaction: type_transaction, from: from, to: to, value: value, date_transaction:date_transaction}]
    File.write(@transactions, :erlang.term_to_binary(transactions))
  end

  def search_everything(), do: search_transactions()

  defp search_transactions() do
    {:ok, binary} = File.read(@transactions)
    binary
    |> :erlang.binary_to_term()
  end
end