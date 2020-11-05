defmodule Account do

  defstruct user: User, balance: nil

  @accounts = "accounts.txt"

  def create_account(user) do:
    [%__MODULE__{user: user, balance: 1000}] ++ search_accounts()
    |> :erlang.term_to_binary()
    File.write(@accounts, binary)
  end

  def transfer(accounts, from, to, value) do
    from = Enum.find(accounts, fn account -> account.user.email == from.user.email end)
  
    cond do
      validate_balance(from.balance, balance) -> {:error, "insufficient funds"}
      true ->
        to = Enum.find(accounts, fn account -> account.user.email == to.user.email end)
        from = %Account{from | balance: from.balance - value}
        to = %Account{to | balance: to.balance + value}
      [from, to]
    end
  end

  def sac(account, value) do
    cond do
      validate_balance(account.balance, value) -> {:error, "insufficient funds"}
      true ->
        account = %Account{account | balance: account.balance - value}
        {:ok, account, "Withdrawal successful!"}
    end
  end

  defp validate_balance(balance, value), do: balance < value

  defp search_accounts do
    {:ok, binary} = File.read(@accounts)
    :erlang.binary_to_term(binary)
  end
end